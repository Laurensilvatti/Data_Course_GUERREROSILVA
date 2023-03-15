library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)
library(janitor)
library(patchwork)
data("mtcars")
glimpse(mtcars)


mod1 = lm(mpg ~ disp, data = mtcars)
summary(mod1)

ggplot(mtcars, aes(x=disp,y=mpg)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal()

mod2 = lm(mpg ~ qsec, data = mtcars)
ggplot(mtcars, aes(x=disp,y=qsec)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal()

mean(mod1$residuals^2)
mean(mod2$residuals^2)



# Start of Assignmnet

mush <- read_csv("../../Data/mushroom_growth.csv")
colnames(mush) <- make_clean_names(colnames(mush)) 
glimpse(mush)
unique(mush$species)

# creating and graphing models. This is horrible...

mod_1 <-  glm(data=mush,
              formula = growth_rate ~ light )
summary(mod_1) 
ggplot(mush, aes(x=light,y=growth_rate)) + 
  geom_point() + 
  geom_smooth(method = "glm") +
  theme_minimal()


mod_2 <- glm(data=mush,
             formula = growth_rate ~ light * nitrogen)
summary(mod_2)
ggplot(mush, aes(x=nitrogen,y=growth_rate)) + 
  geom_point() + 
  geom_smooth(method = "glm") +
  theme_minimal()

mod_3 <- glm(data=mush,
             formula = growth_rate ~ light * nitrogen * temperature)
summary(mod_3)
ggplot(mush, aes(x=nitrogen,y=growth_rate, color = species)) + 
  geom_point() + 
  geom_smooth(method = "glm") +
  theme_minimal()

mod_4 <- glm(data=mush,
             formula = growth_rate ~ light * humidity * temperature)
summary(mod_4)
ggplot(mush, aes(x=temperature,y=growth_rate, color = humidity)) + 
  geom_point() + 
  geom_smooth(method = "glm") +
  theme_minimal()

# calculates the mean sq. error of each model
rmse(mod_1)
rmse(mod_2)
rmse(mod_3)
rmse(mod_4)
# model 4 has the less mean sqrt error.
compare_performance(mod_1,mod_2, mod_3, mod_4) %>%  plot

# Model 4 is the best!!!!

step <- MASS::stepAIC(mod_4)
step$formula 

mod_5 <- glm(data = mush,
            formula = step$formula)
summary(mod_5)

compare_performance(mod_1,mod_2, mod_3, mod_4, mod_5) %>%  plot

# Through machine learning model 5 is the less crappy one. 
check_model(mod_5)


mush %>% 
  gather_predictions(mod_3,mod_4,mod_5) %>% 
  ggplot(aes(x=temperature,y=growth_rate)) +
  geom_point(size=3) +
  geom_point(aes(y=pred,color=model)) +
  geom_smooth(aes(y=pred,color=model)) +
  theme_minimal() 
