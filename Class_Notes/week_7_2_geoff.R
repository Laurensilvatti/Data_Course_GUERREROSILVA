library(tidyverse)
library(readxl)
library(janitor)

file <- "./Data/messy_bp.xlsx"

file <- readxl::read_xlsx(file, skip = 3) %>% 
  clean_names()
#as Geoff


