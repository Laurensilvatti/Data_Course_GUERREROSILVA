library(ggimage)
library(tidyverse)
library(palmerpenguins)

p <- penguins[!is.na(penguins$sex),] %>% 
  ggplot(aes(x=island,
             y=body_mass_g)) +
  #geom_point() +
  geom_image(aes(image="./geoffz.jpeg")) +
  facet_wrap(~sex)
p

#ggsave("./my_penguin_plot.png",width=12, height =2, dpi =150) #save plot as an image. 


p2 <- 
  p + labs(x = "Living Quarters", y = "Fatness(g)", Color = "Island") + 
  theme(axis.text.x = element_text(color = "#8ca336",
                                   angle = 180,
                                   face = "bold.italic"),
        axis.text.y= element_text(angle = 269, 
                                  size = 10,
                                  face = "bold",
                                  color = "#fc03ec"))
        


p2

#coord_polar()
