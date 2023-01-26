rectangles <- read.csv('./Data/rectangles.csv')
as.numeric(rectangles$length) * as.numeric(rectangles$width)

rectangles$area <- as.numeric(rectangles$length) * as.numeric(rectangles$width)

