# Black-throated Blue Warbler Binomial GLM (ML) ---------------------------
# SOLUTIONS
rm(list = ls())
library(tidyverse)

# Our goal for this analysis is to determine how elevation and forest cover
# influence the probability of observing a black-throated blue warbler at 
# 1076 locations across the eastern US. Our response variable takes value 
# 1 if a black-throated blue warbler was detected at the given site, or takes
# value 0 if the warbler was not detected. We will fit a binomial GLM to 
# these data with elevation and forest cover as predictors. This is a 
# very basic type of species distribution model. 

# Load the data and change your working directory as needed. 
load("Data/warbler-data.rda")
ls()
# y = detection (1) or non-detection (0) data of black-throated blue warbler 
#     at 1076 locations across eastern US. 
# elev = standardized elevation at each of the 1076 locations
# forest = standardized local forest cover at each of the 1076 locations
# coords = latitude/longitude coordinates of each location (will use for the optional
#          plotting at the end). 

# Put the detection data, elevation, and forest together in a data frame. 
dat <- data.frame(y, elev, forest)

# Exploratory data analysis -----------------------------------------------
# Use the table function and the detection/non-detection data to explore
# the total number of times the warbler was detected. What does this suggest
# to you about the probability of observing this bird? 
table(dat$y)

# ANSWER: the bird is only detected at 143 out of 933+143 = 1,076 sites, indicating
#         that across this region, the bird is pretty rare and our probability
#         of detection (averaged across the region) will be quite low. 

# Create two basic scatterplots: one with elevation on the x-axis and 
# detection/non-detection on the y-axis, and a second with forest on the 
# x-axis and detection/non-detection on the y-axis. 
# plot(dat$elev, dat$y, pch = 19)
# plot(dat$forest, dat$y, pch = 19)

# Those plots aren't all that informative when we have binary data. Let's 
# use some dplyr code to extract the mean elevation/forest cover at sites where
# we do detection the bird compared to those where we don't
dat %>%
  group_by(y) %>%
  summarize(for.mean = mean(forest), 
	    elev.mean = mean(elev))

# What does this suggest to you the effects of elevation and forest? 

# ANSWER: in my opinion, this is much more useful than the scatterplots. 
#         From this summary table, it is clear that on average the sites 
#         where we detect the warbler are higher in both elevation and amount
#         of local forest cover, indicating that these two variables have 
#         positive effects on the probability of bird occurrence. 

# Fit a binomial GLM to the data ------------------------------------------

# Fit a binomial GLM to the model with elevation and forest as predictors
# in the model (assume they do not interact). 

# ANSWER: 
out <- glm(y ~ elev + forest, data = dat, family = binomial)

summary(out)

# What do the resulting estimates from summary tell you about the effects of 
# elevation and forest on the probability of observing a black-throated blue 
# warbler? In other words, if you wanted to go out and see a black-throated 
# blue warbler, where would you go? 

# ANSWER: the probability of observing a warbler increases as the amount of 
#         forest cover increases, and as the amount of elevation increases. The
#         estimate for forest is larger than that of elevation, indicating that the
#         amount of forest cover is a more important predictor of observing 
#         a black-throated blue warbler than elevation. 

# What is the predicted probability of observing a black-throated blue warbler
# at the mean value of elevation and forest cover? 

coef.out <- coef(out)
plogis(coef.out[1])
plogis(coef.out[3])
out

# Real scale -> logit transformation during binomial glm
# Logit scale (raw coefficients) is log odds
# Exponentiate (raw coefficients) log odds to get odds given x
# (exp(raw coef) - 1) * 100% = percentage change in odds with 1 unit increase in x

# Inverse logit gives probability (plogis)


# ANSWER: the mean probability of observing a black-throated blue warbler
#         at mean elevation and forest cover is about 0.07.

# If we increased the amount of forest cover around a site by 1 standard 
# deviation, how would the odds of observing a black-throated blue warbler 
# change? 

# ANSWER: 
(exp(coef.out[3]) - 1) * 100

# If we increased the amount of forest cover around a site by 1 standard 
# deviation, the odds of observing a black-throated blue warbler
# increases by ~214%. 

# Suppose you went out birding to try and see a black-throated blue and 
# didn't have any luck :( After running this model, your friend tells you
# that you should go to a site that has a higher elevation. If you went to 
# a site that was 1 standard deviation higher than the site you previously 
# went to, how much higher are your odds of observing a black-throated blue
# warbler? 

# ANSWER: 

(exp(coef.out[2]) - 1) * 100

# At the new site with 1 SD higher elevation, our odds of seeing a black
# throated blue warbler are 82% higher than our previous site. 

# Some optional Plotting just for fun -------------------------------------
# This is just some optional plotting code in case you're interested
# in seeing how we can make a map of these results. 
library(tidyverse)
# If you don't have this package installed, you will need to run 
# install.packages("sf"), which may take a while. 
library(sf)
# You will also need the maps package to grab a map of the US. 
library(maps)
# Get predicted values of the probability of observing a warbler 
# at the 1076 locations
out.pred <- predict(out, type = 'response')

# Put the predicted values in a data frame with the latitude/longitude coordinates. 
pred.dat <- data.frame(prob = out.pred, 
		       x = coords[, 1], 
		       y = coords[, 2])

# Get a map of the US. 
usa <- st_as_sf(maps::map("state", fill = TRUE, plot = FALSE))
# Only grab the states where we have data points. 
btbw.states <- usa %>%
  dplyr::filter(ID %in% c('connecticut', 'delaware', 'georgia',
		   'illinois', 'indiana', 'kentucky', 'maine', 'maryland',
		   'massachusetts', 'michigan', 'minnesota', 'north carolina',
		   'new hampshire', 'new jersey', 'new york', 'ohio',
		   'pennsylvania', 'rhode island', 'south carolina', 'tennessee',
		   'vermont', 'virginia', 'wisconsin', 'west virginia'))

pred.sf <- st_as_sf(pred.dat,
		      coords = c("x", "y"),
		      crs = "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")

# Map of probability of observing a black-throated blue warbler. 
ggplot() +
  geom_sf(data = btbw.states) +
  geom_sf(data = pred.sf, aes(bg = prob), pch = 21, size = 2.5) +
  theme_bw(base_size = 16) +
  scale_fill_viridis_c() +
  labs(x = "Longitude", y = "Latitude", fill = expression(psi)) +
  theme(legend.position = c(0.13, 0.25),
	legend.background = element_rect(fill = 'white', color = 'black'))
# Looks like it likes Appalachia!
