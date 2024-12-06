# Black-throated Blue Warbler Binomial GLM (ML) ---------------------------
# SOLUTIONS
rm(list = ls())
library(tidyverse)
library(spAbundance) 

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
