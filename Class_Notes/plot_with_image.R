
library(tidyverse)
library(palmerpenguins)
library(ggimage)



p <- penguins[!is.na(penguins$sex),] %>% 
  ggplot(aes(x=island,
             y=body_mass_g,
             color = island)) +
  geom_boxplot() +
  facet_wrap(~sex)
ggsave("./my_penguin_plot.png",width=12, height =2, dpi =150) #save plot as an image. 


p2 <- p + 
  labs(x = "Living Quarters", y = "Fatness(g)", Color = "Island")+ 
  theme(axis.text.x = element_text(color = "#8ca336",
                                   angle = 180,
                                   face = "bold.italic"),
        axis.text.y= element_text(angle = 269, 
                                  size = 10,
                                  face = "bold",
                                  color = "#fc03ec"),
        panel.background = geom_image("Desktop")
        panel.grid.major.x = element_line(color= "orange",
                                          linetype = 4,
                                          lineend = "butt", 
                                          linewidth = 3),
        strip.background = g
p2