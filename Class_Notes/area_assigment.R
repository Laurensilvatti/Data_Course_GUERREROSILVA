rectangles <- read.csv('./Data/rectangles.csv')
rectangles$area <- as.numeric(rectangles$length) * as.numeric(rectangles$width)

write.csv(rectangles,'./Data/rectangles_clean.csv') #saves a new copy

# load a packege if it's already installed
library(tidyverse)
