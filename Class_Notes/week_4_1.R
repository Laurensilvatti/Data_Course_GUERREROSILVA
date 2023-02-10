#playing with ggplot
library(tidyverse)
#install.packages("palmerpenguins")
library(palmerpenguins)
install.packages("GGally")
library(GGally)
penguins
penguins %>% names() #finding names of columns. *no spaces *all lower case *units

# find outcome variables
#   flipper_length_mm

# find predictors? independent variables
#   island, species, sex, year

penguins$year %>% unique() #list the unique years recorded. 

# GGally::ggpairs(penguins) also work as:
ggpairs(penguins) #how is everything related to each other. 

?ggplot

penguins %>%  # data to use.
  ggplot(aes(y=flipper_length_mm, x=island)) + #set 'global' mapping. which variables to which aspect (x or y) of the plot
  geom_boxplot()

penguins %>%  # data to use.
  ggplot(aes(y=flipper_length_mm,
             x=island,
             fill=species)) + 
  geom_violin()

penguins$sex %>% unique()

is.na(penguins$sex) #ask what is NA 
!is.na(penguins$sex) #ask what is not NA  

p <- 
penguins[!is.na(penguins$sex),] %>%  #takes out the NA in the plots.
  ggplot(aes(x=flipper_length_mm,
             fill=species,)) + #no 'y' axis. when working with density.
  geom_density(alpha=.5) + #'alpha' - opacity *making it lighter or darker. 
  facet_wrap(~island*sex) # wraps 'islands' and 'sex' into a category.
class(p)
# data
# how to map variables
# what to draw
# facets?

p +               #we can keep adding layers.
  theme_bw()

# make a plot of body_mass_g with some x axis. 

penguins[!is.na(penguins$sex),] %>%  
  ggplot(aes(y=body_mass_g,
             x=sex,
             fill=sex)) +
  geom_boxplot() +
  facet_wrap(~island)


 # Geoff Plot
names(penguins)
penguins[!is.na(penguins$sex),] %>%  
  ggplot(aes(x=flipper_length_mm,y=body_mass_g,color=sex)) +
  geom_point(size=3,alpha=.1) +
  geom_smooth(method="lm",se=FALSE) +
  facet_wrap(~species) +
  theme_void()


t <-
penguins %>% 
  ggplot(aes(x=bill_length_mm,
             y=body_mass_g,
             #size=flipper_length_mm,
             color=species)) +
  geom_point(alpha=.25) +
  geom_smooth(method = "lm", se=FALSE) #lm is linear model

t +
  theme_minimal() +
  theme(axis.title=element_text(face = "bold")) +
  labs(x= "Bill Length (mm)",
       y="Body mass (g)",
       color="Species",
       title = "Penguin body mass",
       subtitle = "Lauren Guerrero",
       caption = "Data that I didnt collect") +
scale_color_manual(values=c("#fc0dbc", "Salmon", "Red")) # c= compact together. 
