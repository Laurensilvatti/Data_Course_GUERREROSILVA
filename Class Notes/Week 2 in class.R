# Week 2
getwd()
list.files(recursive = TRUE)
list.files(path = "Data",
           pattern = ".csv",
           full.names = TRUE)

#Give me the full path to wingspan file
list.files(recursive = TRUE,
           pattern = 'wingspan',
           ignore.case = TRUE,
           full.names = TRUE)
# Option + - <-  assing name to code
path <- list.files(recursive = TRUE,
                   pattern = 'wingspan_vs',
                   ignore.case = TRUE,
                   full.names = TRUE)
path

# csv comma separated value
# Hightlight and command + return - only runs that part
wingspan <- read.csv(path)

# command + option + b - runs code before cursor

#continue

m <- wingspan$mass
# $ name of variables.
v <- wingspan$velocity
s <- wingspan$variety

# data frame - 2 dimensional data: rows and columns. 
# vector - 1 dimensional (kinda like a list)

# max() min() mean() - maximum, minumum, average

max(m)
min(m)
mean(m)
summary(m)
cumsum(m) #cumulative sum
plot(m)
plot(cumsum(m))
plot(sort(m))

# x & y axis

plot(x=wingspan$wingspan,
     y=wingspan$mass)
# cor - correlation 

cor(x=wingspan$wingspan,
    y=wingspan$mass)
