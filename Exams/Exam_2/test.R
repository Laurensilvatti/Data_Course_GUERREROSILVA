library(tidyverse)
library(janitor)
library(modelr)
library(easystats)


#1.
unicef <- read_csv("./unicef-u5mr.csv")
colnames(unicef) <- make_clean_names(colnames(unicef)) #cleaning names (no capitals)

# 2.
tidy_data <- unicef %>% 
  pivot_longer(cols = starts_with("u5mr"),
               values_to = "mortality_rate",   #values of previosus col to new col called mor_rate
               names_to = "year",   #names of prev col to new col called year
               names_prefix = "u5mr_", #taking off prefix
               names_transform = list(year=as.numeric)) 
tidy_data <- tidy_data %>% 
  filter(!is.na(mortality_rate))

#7. 
mod1 <- glm(data = tidy_data,
            formula = mortality_rate ~ year) 
summary(mod1)

mod2 <- glm(data = tidy_data,
            formula = mortality_rate ~ year + continent)
summary(mod2)

mod3 <- glm(data = tidy_data,
            formula = mortality_rate ~ year * continent)
summary(mod3)

#8.
compare_performance(mod1,mod2, mod3) %>% plot
# Based on the comparison between the 3 models, model 3 is better.

#9. 
modelr::gather_predictions(tidy_data,mod1,mod2,mod3) %>% 
  ggplot(aes(x=year, y=pred,color=continent)) +
  #geom_point(aes(y=cty), alpha= .5) +
  geom_smooth(method = "glm") +
  facet_wrap(~model) +
  labs(x="Year",
       y="Predicted U5MR")+
  ggtitle("Model predictions")+
  theme_bw()

#10.
#unique(tidy_data$region)
#unique(tidy_data$continent)
Ecuador_2020 <- data.frame(continent = "Americas",
                           year = 2020,
                           country_name = "Ecuador",
                           region = "South America")
add_predictions(Ecuador_2020, model = mod3)

mod4 <- 
  glm(data = tidy_data,
      formula = mortality_rate ~ year * country_name)
summary(mod4)

mod5 <- 
  glm(data = tidy_data,
      formula = mortality_rate ~ year * region)
summary(mod4)


step <- MASS::stepAIC(mod4)
step$formula  #step is a list, there for we can use $

mod6 <- glm(data = tidy_data,
            formula = step$formula)

summary(mod6)

compare_performance(mod1,mod2, mod3, mod4, mod5, mod6) %>% plot

#install.packages("patchwork")
library(patchwork)
check_model(mod6)

Ecuador_2020 <- data.frame(continent = "Americas",
                           year = 2020,
                           country_name = "Ecuador",
                           region = "South America")
add_predictions(Ecuador_2020, model = mod2)
