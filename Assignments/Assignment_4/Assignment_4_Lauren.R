library(tidyverse)
library(ggplot2)
library(janitor)
#install.packages("janitor")

df<-read.csv("./Assignments/Assignment_4/Project_Data_fake.csv")
df<- df %>% clean_names()

df$avg_grooming <- mean(df$grooming_sec)
df$avg_sniffing <- mean(df$sniffing_sec)
df$avg_rooting <- mean(df$rooting_sec)
df$avg_no_cont <- mean(df$no_contact_sec)

df %>%
  pivot_longer(avg_grooming:avg_no_cont) %>%
  mutate(across(where(is.character), as.factor)) %>%
  ggplot(aes(x = groups, y = value, fill=name))+
  geom_col(position = "dodge", width=0.75) +
  theme(legend.position = "bottom", )+
  labs(fill="",
       y="Time in Seconds", 
       x="Groups")

ggsave("./Assignments/Assignment_4/Fake_plot.png",width=12, height =12, dpi =150)
