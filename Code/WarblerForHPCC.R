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


# Fit a binomial GLM to the data ------------------------------------------

# Fit a binomial GLM to the model with elevation and forest as predictors
# in the model (assume they do not interact). 

# ANSWER: 
out <- glm(y ~ elev + forest, data = dat, family = binomial)

summary(out)


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
