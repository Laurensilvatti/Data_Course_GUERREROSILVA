library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)
library(janitor)
library(patchwork)


# Start of Assignmnet

mush <- read_csv("../../Data/mushroom_growth.csv")
colnames(mush) <- make_clean_names(colnames(mush)) 
glimpse(mush)
unique(mush$species)

# creating and graphing models. This is horrible...

mod_1 <-  glm(data=mush,
              formula = growth_rate ~ species )
summary(mod_1) 
ggplot(mush, aes(x=light,y=growth_rate)) + 
  geom_point() + 
  geom_smooth(method = "glm") +
  theme_minimal()


mod_2 <- glm(data=mush,
             formula = growth_rate ~ light * humidity)
summary(mod_2)
ggplot(mush, aes(x=humidity,y=growth_rate)) + 
  geom_point() + 
  geom_smooth(method = "glm") +
  theme_minimal()

mod_3 <- glm(data=mush,
             formula = growth_rate ~ humidity * species * temperature)
summary(mod_3)
ggplot(mush, aes(x=nitrogen,y=growth_rate, color = species)) + 
  geom_point() + 
  geom_smooth(method = "glm") +
  theme_minimal()

mod_4 <- glm(data=mush,
             formula = growth_rate ~ species * humidity)
summary(mod_4)
ggplot(mush, aes(x=humidity,y=growth_rate, color = species)) + 
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

# Model 3 is the best!!!!

step <- MASS::stepAIC(mod_3)
step$formula 

mod_5 <- glm(data = mush,
            formula = step$formula)
summary(mod_5)

compare_performance(mod_1,mod_2, mod_3, mod_4, mod_5) %>%  plot

# Through machine learning model 5 is the less crappy one. 
check_model(mod_5)


mushdf <- mush %>% 
  add_predictions(mod_3) 
mushdf %>% dplyr::select("growth_rate","pred")

mushdf2 = data.frame(temperature = c(35,20,25,45,55,25,35,45,45,25,30,35,45,35,50,35,35,45,40,50), 
                      humidity = c("Low","Low","Low","Low","Low","Low","Low","Low","Low","Low","High","High","High","High","High","High","High","High","High","High"),
                      species = c("P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.cornucopiae","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus"))


pred = predict(mod_3, newdata = mushdf2)

hyp_prediction <- data.frame(temperature = mushdf2$temperature,
                        species = mushdf2$species,
                        humidity = mushdf2$humidity,
                        pred = pred)

mushdf$PredictionType <- "Real"
hyp_prediction$PredictionType <- "Mushythetical"

mushpreds <- full_join(mushdf,hyp_prediction)

# 7

mushpreds <- mushpreds %>% 
  mutate(dankness=paste(humidity, temperature,
                        sep =" "))
ggplot(mushpreds,aes(x=dankness,y=pred,color=PredictionType)) +
  facet_wrap(~species) +
  geom_point() +
  geom_point(aes(y=growth_rate),color="black") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 60)) +
  labs(x = "Humidity*Temperature") +
  facet_wrap(vars(species), scales = "free")


# part 2

# 1. I don't think any of my models is right and I honestly am having a hard time interpreting the data. 

# 2.
# I am sure that if I plotted my data correcley I would have found exponential relationships. 
# to make this relationships linear I know you can turn the Y axis into a fuction of log()
  
  # 3.
  
non_linear <- read.csv("../../Data/non_linear_relationship.csv")

non_linear %>% 
  ggplot(aes(x=predictor,y=response)) +
  geom_point() 

test1 <- glm(data = non_linear,
                 formula = response ~ predictor)
summary(test1)

# Plot the log() of the response and make it linear 
non_linear %>% 
  ggplot(aes(x=predictor,y= log(response))) +
  geom_point() +
  geom_smooth() +
  theme_minimal()

linear_mod <- glm(data = non_linear,
              formula = log(response) ~ predictor)
summary(linear_mod)
compare_performance(crappymod,logmod) %>% plot
# I am having a very very very hard time with this topics.... :(



