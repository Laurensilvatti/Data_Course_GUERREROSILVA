library(tidyverse)
library(easystats)
library(modelr)
library(palmerpenguins)

# formula = y ~ ns(x,2)


names(penguins)
mod1 <- glm(data=penguins,
    formula = body_mass_g ~ sex + species + flipper_length_mm)
summary(mod1)
check_model(mod1)


# Classification modeling or Logistic regression
# logical (T/F)
# the variable needs to be a true of false.

# penguins %>% 
#   mutate(male = case_when(sex == "male" ~ TRUE,     # ~ in this case True
#                           TRUE ~ FALSE))          # ~ in all other cases Flase.

#.    or 
penguins <- penguins %>% 
  mutate(male = case_when(sex == "male" ~ TRUE,     # ~ in this case True
                          sex == "female" ~ FALSE)) #gets rid of NA. But same concept as above. 

names(penguins)
mod2 <- glm(data = penguins,
            formula = male ~ (body_mass_g + flipper_length_mm + bill_length_mm + island + year ) * species,
            family = "binomial")
summary(mod2)


add_predictions(penguins, mod2, type = "response") %>% 
  ggplot(aes(x= body_mass_g, y = pred, color = sex)) +
  #geom_smooth() +
  geom_point(size = 3, alpha = .5)

add_predictions(penguins, mod2, type = "response") %>% 
  ggplot(aes(x= body_mass_g, y = pred, color = species)) +
  geom_smooth() 
  #geom_point(size = 3, alpha = .5)
