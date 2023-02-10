library(tidyverse)
library(palmerpenguins)
#make nifty penguin plot
p <- penguins[!is.na(penguins$sex),] %>% ggplot(aes(x=species, y=body_mass_g, color = island, fill = species))+
  geom_boxplot() + facet_wrap(~sex)
ggsave("./penguin.png", width = 5, height = 7, dpi = 300)
getwd()
#saves last plot 
p2 <- p + 
  labs(x = "Species", y = "Body Mass (g)", Color = "Island")+ 
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust = .5, face = "italic"),
        axis.text.y= element_text(angle = 
                                    180, size = 20, face = "bold", color = "pink"),plot.background =  element_rect(color="orange", fill = "blue", linewidth = 15, linetype = "dotted"), 
        panel.grid.major.x = element_line(color= "orange", linetype = 4,
                                          lineend = "butt", linewidth = 3), strip.background = element_rect(fill= "pink"))
ggsave(p2, filename= "./ugly.png", height = 6, width = 6)

#h just 0 = left aligned h just = 1 = right aligned

p2+scale_fill_manual(values=c("purple", "green", "black")) + #scale_y_reverse()+
  coord_polar() + theme(strip.text = element_text(size= 12, face = "bold"), legend.text = element_text(face='italic'), 
                        legend.background = element_rect(fill="pink"), legend.position = "none", axis.title = element_text(
                          angle = 60, size = 40
                        ))
# + coord_flip() + coord_cartesian(ylim = c(100,3000)) 
# gg image

#for more fun download ggimages, this wont work because no package is installed!
penguins %>% ggplot(aes(x=body_mass_g, y=flipper_length_mm)) + 
  geom_image("")
