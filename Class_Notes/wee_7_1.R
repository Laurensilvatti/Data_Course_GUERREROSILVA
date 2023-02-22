library(tidyverse)
library(janitor)
janitor::clean_names()
df <- read_csv("./Data/Bird_Measurements.csv") %>% 
  clean_names() %>% 
  select(-ends_with("_n"))


#c("YouR Mom" , "$ per day" , "# of people" , "gROUP") %>% 
  #make_clean_names()

# if name has # then clean_names makes # the word "number"

# 2. Select which column to KEEP
#df %>%  
  #select(-ends_with("_n")) %>% 
  #names()

# 3. Separate data frame: Female, Male, Unsexed
male <-
df %>% 
  select(starts_with("m_"),
         species_number, species_name, english_name, clutch_size,
         egg_mass,mating_system,family) %>% 
  mutate(sex="male")     #new column named sex, filled with the word male
female <-
  df %>% 
  select(starts_with("f_"),
         species_number, species_name, english_name, clutch_size,
         egg_mass,mating_system,family) %>% 
  mutate(sex="female")

unsexed <-
  df %>% 
  select(starts_with("unsexed_"),
         species_number, species_name, english_name, clutch_size,
         egg_mass,mating_system,family) %>% 
  mutate(sex="unsexed")

# clean up names
names(male) <-
  names(male) %>%
  str_remove("^m_")   # ^ starts with. 

names(female) <-
  names(female) %>%
  str_remove("^f_")

names(unsexed) <-
  names(unsexed) %>%
  str_remove("^unsexed_")

# join them back together
clean <- male %>% 
  full_join(female) %>% 
  full_join(unsexed) %>% 
  mutate(family = as.factor(family),
         mating_system = as.factor(mating_system),
         species_number = as.factor(species_number))
clean %>% 
  filter(!is.na(mating_system)) %>% #getting rid of NA
  ggplot(aes(x=mating_system,y=bill))+
  geom_boxplot()

# DONE!

# Additional info
clean %>% 
  filter(english_name == "Ostrich")



library(skimr)
df_1 <- skim(clean) %>% 
  as.data.frame()

complete_enough <-
  df_1 %>% 
  filter(complete_rate > .25)
complete_enough$skim_variable

clean %>% 
  select(complete_enough$skim_variable)




# Task of the day
# Plot salary (not comp) by rank and tier.

task <- read_csv("./Data/FacultySalaries_1995.csv") %>% 
  clean_names() %>% 
  select("fed_id", "univ_name", "state" , "tier", ends_with("_salary")) %>% 
  pivot_longer(cols = c(starts_with("avg_")),
               values_to = "salary",
               names_to = "salary_type", 
               names_prefix = "avg_") %>% 
  mutate(salaty_type = salary_type %>% str_remove("_salary"),
         tier = tier %>% factor(levels = c("I", "IIA", "IIB", "VIIB")))
task %>% 
  ggplot(aes(x=salaty_type,y=salary,
             fill = tier))+
  geom_boxplot()
  



