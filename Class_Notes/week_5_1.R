library(tidyverse)
library(palmerpenguins)



adelie <- penguins[penguins$species == "adelie" , ]
gentoo <- penguins[penguins$species == "gentoo" , ]
chinstrap <- penguins[penguins$species == "chinstrap" , ]

adelie$body_mass_g %>% mean(na.rm=TRUE)
gentoo$body_mass_g %>% mean(na.rm=TRUE)
chinstrap$body_mass_g %>% mean(na.rm=TRUE)

means <- numeric()
for(i in unique(penguins$species) %>% as.character()){
  ss <- penguins[penguins$species == i,]
  means[i] <- ss$body_mass_g %>% mean(na.rm=TRUE)
  ss$body_mass_g %>% mean(na.rm=TRUE) %>% print()
}
means
                #THIS CAN BE DONE LIKE THIS. 

# dplyr verbs:
# group_by()/ summarize ()
# arrange


penguins %>% 
  group_by(species) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm=TRUE))

penguins %>% 
  group_by(species,sex) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm=TRUE))

penguins %>% 
  group_by(species,sex) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm=TRUE),
            max_body_mass = max(body_mass_g, na.rm=TRUE)) %>% 
  arrange(desc(mean_body_mass)) # or just arrange(mean_body_mass) for ascending order.

# filter : filters rows. 

#check for NA 
penguins$sex %>% unique()
#install.packages("skimr")
skimr::skim(penguins)

test <- 
penguins %>% 
  filter(!is.na(sex)) %>%  # true or false questions based on column. int his case SEX.
  group_by(species,sex) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm=TRUE),
            max_body_mass = max(body_mass_g, na.rm=TRUE)) %>% 
  arrange(desc(mean_body_mass))  # or just arrange(mean_body_mass) for ascending order.


 #overwrite leves of factor in new order. Normal order is Adelie, Chinstrap, Gentoo.
test$species <-
factor(test$species, levels = c('Gentoo','Chinstrap', 'Adelie'))

 # the program arranges things in alphabetical order. Now it's arranged in the order I wanted.


test %>% 
  ggplot(aes(x=species,
             y=max_body_mass,
             fill=sex)) +
  geom_col(position = "dodge")



#filter penguins where the sex is NOT NA & where penguin body mass > 4000

penguins %>% 
  filter(!is.na(sex) & body_mass_g > 4000 & year == 2007)

