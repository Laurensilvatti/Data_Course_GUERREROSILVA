library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)
library(janitor)
library(patchwork)
library(palmerpenguins)


mod1 <- glm(data=penguins,
            formula = body_mass_g ~ sex * species * island + bill_length_mm +
              bill_depth_mm + flipper_length_mm)

df <-  add_predictions(penguins,mod1)

df <- add_residuals(df, mod1)

summary(mod1)
performance(mod1)

names(penguins)
# Need to give a new data frame with exactly all the columns used before. In the same format.

new_pen <- data.frame(sex = "male",
           species = "Gentoo",
           island = "Biscoe",
           bill_length_mm = "1000",
           bill_depth_mm = "1000",
           flipper_length_mm = "1")
add_predictions(new_pen, model = mod1)
df$body_mass_g %>% max(na.rm = TRUE)
df$bill_length_mm %>% max(na.rm = TRUE)


# testing data set get set aside until the end
# training data set is for model building.
# choose randomly. 

penguins
# to have the same random numbers
set.seed(69)
rsq_mod2 <- c()
for( i in 1:1000){
  testing <- sample(1:nrow(penguins), size =round(nrow(penguins)*.2))
  test <- penguins[testing,]    #selecting only this data
  train <- penguins[-testing,]  #selecting everything but this data
  mod2 <- glm(data = train,
              formula = mod1$formula)
  rsq_mod2[i] <- rsquare(mod2,test)
}
mean(rsq_mod2)

data.frame(value=rsq_mod2) %>% 
  ggplot(aes(x=value)) +
  geom_density() +
  geom_vline(xintercept = mean(rsq_mod2), linetype=2, color = "red")


# testing <- sample(1:nrow(penguins), size =round(nrow(penguins)*.2))
# test <- penguins[testing,]    #selecting only this data
# train <- penguins[-testing,]  #selecting everything but this data
# mod2 <- glm(data = train,
#             formula = mod1$formula)
# rsq_mod2[i] <- rsquare(mod2,test)

#mod1$formula

mod2 <- glm(data = train,
            formula = mod1$formula)
# for the new data:
add_residuals(test,mod2) %>% 
  pluck("resid") %>% 
  .^2 %>% 
  mean(na.rm = TRUE) %>% 
  sqrt()
# for the data we have
rmse(mod2)

rsquare(mod2,test)
rsquare(mod1,penguins)


# mod1 and mod2 come from the same data. our model learned 80% of the data first and when we
# gave it the remaining 20% of the data it analyzed it accurately. 

