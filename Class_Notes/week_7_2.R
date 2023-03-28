library(tidyverse)
library(readxl)
library(janitor)

file <- "./Data/messy_bp.xlsx"

file <- readxl::read_xlsx(file, skip = 3) %>% 
  clean_names()

#?as.Date

tidy <- file %>% 
  mutate(dob= paste0(month_of_birth,"/",day_birth,"/",year_birth) %>% 
           as.Date(format="%m/%d/%Y")) %>% 
  select(-c(month_of_birth,day_birth,year_birth))

tidy_hr <- tidy %>% 
  select(-starts_with("bp_")) %>% 
  pivot_longer(cols = starts_with("hr_"),
               values_to = "heart_rate",
               names_to = "visit",  
               names_prefix = "hr_", 
               names_transform=as.numeric) %>% 
  mutate(visit = case_when(visit == "9" ~ "1",     
                            visit == "11" ~ "2",
                            visit == "13" ~ "3")) 

tidy_bp <- tidy %>% 
  select(-starts_with("hr_")) %>% 
  pivot_longer(cols = starts_with("bp_"),
               values_to = "blood_pressure",
               names_to = "visit",  
               names_prefix = "bp_", 
               names_transform=as.numeric) %>% 
 mutate(visit = case_when(visit == "8" ~ "1", 
                           visit == "10" ~ "2",
                           visit == "12" ~ "3"))

together <- tidy_hr %>% 
  full_join(tidy_bp) %>% 
  rename(ethnicity = hispanic)

together <- together %>% 
  select(pat_id,dob,sex,race,ethnicity,visit,heart_rate,blood_pressure) %>% 
  separate(col=blood_pressure,
           into= c("systolic","diastolic"),
           sep = "/",      #not necessary to type in this case, but this is how is done.
           convert = TRUE) 



