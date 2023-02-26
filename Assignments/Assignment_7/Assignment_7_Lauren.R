library(tidyverse)
library(janitor)
library(skimr)
library(dplyr)


df <- read_csv("./Utah_Religions_by_County.csv") %>% 
  clean_names() %>% 
  select(-religious)


skim(df)

# 1. Does population of a county correlate with the proportion 
# of any specific religious group in that county?

clean_data <- df %>%
  pivot_longer(cols = -c(county, pop_2010),
               names_to = "religion",
               values_to = "proportion")
# Graph
clean_data %>% 
  ggplot(aes(x=reorder(county,pop_2010),y=proportion,
                     color = religion)) +
  facet_wrap(~religion) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90,
                                   size = 6,
                                   vjust = .5)) +
  labs(x = "County", y = "Population Proportion")

# CORRELATION 1
data_1_correlation <- clean_data %>% 
  group_by(religion) %>% 
  summarise(data_1_cor = cor(pop_2010,proportion))

# The doesn't seem to be any meaningful correlation between population and religion proportion.
# The biggest counties are the ones to show more muslim religiuos proportion. 

# 2. Does proportion of any specific religion in a given county correlate 
#with the proportion of non-religious people?


df_2 <- read_csv("./Utah_Religions_by_County.csv") %>%
  clean_names() %>% 
  select(county, pop_2010, religious, non_religious)

df_3 <- full_join(clean_data,df_2)


clean_data %>% 
  ggplot(aes(x=proportion,y=religion, color = religion)) +
  facet_wrap(~county) +
  geom_point() +
  theme(axis.text.x = element_text(size = 7,
                                   hjust = .5),
        axis.text.y = element_text(size = 6,
                                   vjust = .5))
        

# CORRELATION 2
data_2_correlation <- df_3 %>% 
  group_by(religion) %>% 
  summarise(data_2_cor = cor(proportion,non_religious))


# There seems to be a inverse correlation between non religions people and LDS people. 
#The more LDS people present in a county the lower the non religious people 


# :)






# NOTES TO MYSELF


# trying something
#GGally::ggpairs(clean_data, cardinality_threshold = 30)


# Finding correlation 
#religions <- clean_data$religion %>% unique

#cor = numeric()
#for( i in religions){
#loop <- 
#clean_data %>% filter(religion == i)
#cor[i] <- 
#cor(x=loop$pop_2010 , y=loop$proportion)
#}
#cor_data <- data.frame(religion=names(cor), correlation = unname(cor)) %>% 
#arrange(correlation)

# too complicated.
