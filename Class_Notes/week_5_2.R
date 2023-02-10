library(tidyverse)
library(palmerpenguins)
library(ggimage)
library(gapminder)
library(plotly)
library(gganimate)
#library(ggmap). google maps. can plot points with lat and long
#library(leaflet) steet view.

p <- penguins %>% 
  ggplot(aes(x=species,y=body_mass_g)) +
  geom_col()

penguins %>% names

p +
  transition_time(year) +
  labs(title = 'year: {frame_time}')

ggplotly(p) #description of each point in graph


penguins %>% 
  ggplot()+
  aes(
    x=flipper_length_mm,
    y=body_mass_g,
    label = "which line is going to be",
    angle=60,
    color="red")