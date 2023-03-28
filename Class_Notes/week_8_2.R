# EVERYTHING IS BASICALLY 'GLM' IN DISGUISE

# https://mlu-explain.github.io/linear-regression/
# Residuals are points outside the linear fit.
# The goal is reducing the error to better fit our data. 

# Types of predictors (models):
# binary: yes or no. Does the house has a pool?
# Continuous. two variables. Price and Size. 
# Multivariate: Size of the house and whether it has a pool or not (additive)
# Interaction



library(tidyverse)
library(easystats)

mpg %>% names
mpg$class %>% unique

mod1 <- glm(data = mpg,
            formula = cty ~ class)
mpg %>% 
  filter(class == "compact") %>% 
  pluck("cty") %>% 
  mean()
summary(mod1)

mod2 <- glm(data = mpg,
            formula = cty ~ class + displ)
summary(mod2)


mod3 <- glm(data = mpg,
            formula = cty ~ class * displ)  #displ depend on class.
summary(mod3)


mod4 <- glm(data = mpg,
            formula = cty ~ class * displ * cyl)  #displ and cyl depend on class.
summary(mod4)


mod5 <- glm(data = mpg,
            formula = cty ~ class * displ * cyl * drv)
summary(mod5)

rmse(mod1) # root mean square error
rmse(mod5)

mpg %>% 
  ggplot(aes(x=displ, y= cty, color = factor(cyl))) +
  geom_smooth(method="glm")

# Additive: same slope.
# Multiplicative: different slopes.

modelr::gather_predictions(mpg,mod2,mod3) %>% 
  ggplot(aes(x=displ, y=pred,color=class)) +
  #geom_point(aes(y=cty), alpha= .5) +
  geom_smooth(method = "glm") +
  facet_wrap(~model)


compare_performance(mod1,mod2, mod3, mod4, mod5)
#R2 or R^2 generally between 1-0 the closer to 1 the best the models explains the line.

compare_performance(mod1,mod2, mod3, mod4, mod5) %>% plot
# "Goodness" is further away from the center. In this case mod5

# library(MASS) if you dont want to load the whole package then use MASS:: ...

# stepAIC takes a trained model
step <- MASS::stepAIC(mod5)
step$formula  #step is a list, there for we can use $

mod6 <- glm(data = mpg,
            formula = step$formula)
summary(mod6)

compare_performance(mod1,mod2, mod3, mod4, mod5, mod6) %>% plot

#install.packages("patchwork")
library(patchwork)
check_model(mod6)
