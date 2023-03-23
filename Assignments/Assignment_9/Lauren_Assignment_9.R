# Your tasks:
#   Use the data set “/Data/GradSchool_Admissions.csv”
# You will explore and model the predictors of graduate school admission
# the “admit” column is coded as 1=success and 0=failure (that’s binary, so model appropriately)
# the other columns are the GRE score, the GPA, and the rank of the undergraduate institution, where I is “top-tier.”
# Document your data explorations, figures, and conclusions in a reproducible R-markdown report
# That means I want to see, in your html report, your process of model evaluation and selection. Here’s an example
# Upload your self-contained R project, including knitted HTML report, to GitHub in your Assignment_9 directory

library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)
library(janitor)
library(patchwork)

dat <- read_csv("../../Data/GradSchool_Admissions.csv")
dat$admit <- as.logical(dat$admit)  
dat$rank <- as.factor(dat$rank)

mod1 <- glm(data = dat,
            formula = admit ~ (gre + gpa) * rank,
            family = "binomial")
summary(mod1)

mod2 <- glm(data = dat,
            formula = admit ~ (gre * gpa) + rank,
            family = "binomial")
summary(mod2)

mod3 <- glm(data = dat,
            formula = admit ~ gre * gpa * rank,
            family = "binomial")
summary(mod3)

mod4 <- glm(data = dat,
            formula = admit ~ gre * gpa,
            family = "binomial")
summary(mod4)

compare_performance(mod1,mod2,mod3,mod4) %>% plot()

add_predictions(dat, mod2, type = "response") %>% 
  ggplot(aes(x= gpa, y = pred, color = rank, group= rank)) +
  geom_smooth(se = FALSE) +
  theme_minimal()

add_predictions(dat, mod2, type = "response") %>% 
  ggplot(aes(x=gre, y=pred, color= rank, group=rank)) +
  geom_smooth(se = FALSE) +
  theme_minimal()

  

