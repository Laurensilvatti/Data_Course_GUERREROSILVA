library(tidyverse)

table1
table2


# Tidy rule: every variable is a single column.
#      no column has more than one variable.

# Tidy rule 2: every observation gets its own row.
#     always rectangular.


table3.  # two variables merged into 1 column.
table4a. # one variable split into 2 columns 
table4b # one variable split into 2 columns 
table5  # one variable split into 2 columns and 2 variables merged into 1 column.

# multiples variables in a single column use pivot_wider
table2 %>%        
  pivot_wider(names_from = type,
              values_from = count)

# single variables in multiple columns.
table4a %>% 
  pivot_longer(cols = c('1999','2000'),     # -country (everithing except contries.) -c(country, whatever else)
               names_to = 'year',
               values_to = 'cases')
table4a %>% 
  pivot_longer(cols = c('1999','2000'),     # -country (everything except contries.) -c(country, whatever else)
               names_to = 'year',
               values_to = 'polulation')


table3 %>% 
  separate(col=rate,
           into= c("cases","population"),
           sep = "/",      #not necessary to type in this case, but this is how is done.
           convert = TRUE) #converted characters to integers.

table5 %>% 
  mutate(newyear= paste0(century,year) %>%  as.numeric()) %>% #paste together century and year
  select(-c(century,year)) %>% #keep everything but century and year
  separate(rate, into = c("cases","population"), convert = TRUE) %>% #new columns named cases and population from the column rate
  select(country,newyear,cases, population)   #rearrange. 


df <- read_csv("./Data/wide_income_rent.csv") %>% 
  pivot_longer(cols = -c(variable),    
               names_to = 'states') %>% 
  pivot_wider(names_from = variable,
              values_from = value)
  
