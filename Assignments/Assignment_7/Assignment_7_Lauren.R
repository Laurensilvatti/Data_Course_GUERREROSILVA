library(tidyverse)
library(ggplot2)
library(janitor)
library(skimr)
library(dplyr)


df <- read_csv("./Utah_Religions_by_County.csv") %>% 
  clean_names() %>% 
  select(-religious)


skim(df)

# 1. Does population of a county correlate with the proportion 
# of any specific religious group in that county?

clean_1 <- df %>%
  pivot_longer(cols = -c(county, pop_2010),
               names_to = "religion",
               values_to = "proportion")
  


clean_1 %>% 
  ggplot(aes(x=reorder(county,pop_2010),y=proportion,
                     color = religion)) +
  facet_wrap(~religion) +
  geom_point(alpha = 1) +
  geom_smooth(se=TRUE, method = "lm") +
  theme(axis.text.x = element_text(angle = 90,
                                   size = 8,
                                   vjust = .5)) +
  labs(x = "County", y = "Population Proportion")

GGally::ggpairs(clean_1, cardinality_threshold = 30)

# The doesn't seem to be any correlation. 


# cant figure out the correlation stuff.

# 2. Does proportion of any specific religion in a given county correlate 
#with the proportion of non-religious people?
clean_1 %>% 
  ggplot(aes(x=proportion,y=religion, color = religion)) +
  facet_wrap(~county) +
  geom_point() +
  theme(axis.text.x = element_text(size = 8,
                                   vjust = .5))

# The seems to be a inverse corratelation between non religions people and LDS people. 
#The more LDS people present in a county the lowe the non religious people 

