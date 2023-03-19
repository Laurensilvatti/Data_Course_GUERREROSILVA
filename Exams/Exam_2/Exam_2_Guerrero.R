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
#3.
tidy_data %>% 
  #filter(!is.na(mortality_rate)) %>% 
  ggplot(aes(x=year,y=mortality_rate)) +
  facet_wrap(~continent) +
  geom_path()+
  labs(x="Year",
       y="U5MR")+
  theme_bw()

#4.
ggsave("GUERRERO_Plot_1.png", plot = last_plot())

#5.
tidy_data %>% 
  #filter(!is.na(mortality_rate)) %>% 
  group_by(year, continent) %>% 
  summarise(mean_mortality_rate = mean(mortality_rate)) %>% 
  ggplot(aes(x=year, y= mean_mortality_rate, color= continent)) +
  geom_line() +
  labs(x="Year",
       y="Mean_U5MR") +
  theme_light()
#6.
ggsave("GUERRERO_Plot_2.png", plot = last_plot())

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
# Your initial prediction.
Ecuador_2020 <- data.frame(continent = "Americas",
                      year = 2020,
                      country_name = "Ecuador",
                      region = "South America")
add_predictions(Ecuador_2020, model = mod3)

# AND IT GOES DOWN HILL FROM HERE.
# my Prediction

Ecuador_2020_my_pred <- data.frame(continent = "Americas",
                           year = 2020,
                           country_name = "Ecuador",
                           region = "South America",
                           mortality_rate = 12.5)

mod1 <- glm(data = tidy_data,
            formula = mortality_rate ~ year)
summary(mod1)

add_predictions(Ecuador_2020_my_pred, model = mod1)
# Model 1 is exactly the same as the mod4 I created, so I deleted it and used model 1

final <- data.frame(Model = "mod1",
          Prediction = 11.44,
          Reality = 13)

final$difference <-  final$Reality - final$Prediction

final
