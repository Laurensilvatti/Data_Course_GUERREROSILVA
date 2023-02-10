library(tidyverse)
library(palmerpenguins)

p <- penguins[!is.na(penguins$sex),] %>% 
  ggplot(aes(x=island,
             y=body_mass_g,
             color = island)) +
  geom_violin() +
  facet_wrap(~sex)
ggsave("./my_penguin_plot.png",width=12, height =2, dpi =150) #save plot as an image. 


p2 <- p + 
  labs(x = "Living Quarters (letters)", y = "Fatness(grams)", Color = "Island")+ 
  theme(axis.text.x = element_text(angle = 169,
                                   hjust=2,
                                   vjust = .5,
                                   face = "bold.italic",
                                   color = "#ed00f5"),
        axis.text.y= element_text(angle = 169,
                                  size = 20,
                                  face = "bold",
                                  color = "#00f529"),
        plot.background =  element_rect(color="#cee314",
                                        fill = "#03fcf8",
                                        linewidth = 25,
                                        linetype = "solid"), 
        panel.grid.major.x = element_line(color= "#f2f205", linetype = 1,
                                          lineend = "butt", linewidth = 10),
        strip.background = element_rect(fill= "#f20505"),
        strip.text = element_text(size= 10,
                                  face = "bold",
                                  color = "#4005f2",
                                  angle = 90),
        axis.title.y = element_text(angle = 275,
                                    size = 20,
                                    color = "#058bf2"),
        axis.title.x = element_text(angle = 185,
                                    size = 20,
                                    color = "#f26805")) +
  labs(color="piece of land in the middle of water") +
  scale_color_manual(values = c("orange","blue","pink")) +
  theme(legend.title = element_text(angle = 180,
                                    size = 5),
        legend.text = element_text(angle = 190))


p2

ggsave(p2, filename= "./ugly.png", height = 8, width = 8)



