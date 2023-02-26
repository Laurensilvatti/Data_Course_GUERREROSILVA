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
# Graph
clean_1 %>% 
  ggplot(aes(x=reorder(county,pop_2010),y=proportion,
                     color = religion)) +
  facet_wrap(~religion) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90,
                                   size = 8,
                                   vjust = .5)) +
  labs(x = "County", y = "Population Proportion")

# trying something
#GGally::ggpairs(clean_1, cardinality_threshold = 30)

# Finding correlation 
religions <- clean_1$religion %>% unique

cor = numeric()
for( i in religions){
  loop <- 
    clean_1 %>% filter(religion == i)
  cor[i] <- 
    cor(x=loop$pop_2010 , y=loop$proportion)
}
cor_data <- data.frame(religion=names(cor), correlation = unname(cor)) %>% 
  arrange(correlation)


# The doesn't seem to be any meaningful correlation between population and religion proportion.
# The biggest counties are the ones to show more muslim religiuos proportion. 

# 2. Does proportion of any specific religion in a given county correlate 
#with the proportion of non-religious people?

# New data frame that has the religious as an individual column. 

df_2 <- read_csv("./Utah_Religions_by_County.csv") %>% 
  clean_names()

clean_2 <- df_2 %>%
  pivot_longer(cols = -c(county, pop_2010,religious),
               names_to = "religion",
               values_to = "proportion")


clean_2 %>% 
  ggplot(aes(x=proportion,y=religion, color = religion)) +
  facet_wrap(~county) +
  geom_point(alpha = 1) +
  geom_smooth(se=TRUE, method = "lm") +
  theme(axis.text.x = element_text(size = 8,
                                   vjust = .5))


cor = numeric()
for( i in religions){
  loop <- 
    clean_2 %>% filter(religion == i) %>% 
    mutate(non_reg_prop = 1 - religious)
  cor[i] <- 
    cor(x=loop$proportion , y=loop$non_reg_prop)
}
non_reg_cor_data <- data.frame(religion=names(cor), correlation = unname(cor)) %>% 
  arrange(correlation)


# The seems to be a inverse correlation between non religions people and LDS people. 
#The more LDS people present in a county the lower the non religious people 


