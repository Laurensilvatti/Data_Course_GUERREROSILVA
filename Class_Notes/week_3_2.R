library(tidyverse)

df <- read_csv('./Data/rectangles.csv')
glimpse(df)

#pipe operator : The output of LHS becomes first argument to RHS function.
mean(df$length)
df$length %>% mean() # command + shift + m
df$length %>% mean() %>% length()
df$length %>% 
  mean() %>% 
  length() %>%  
  class()


df %>% names()

#fix width column
df$width <- df$width %>% as.numeric()

 df %>% 
   ggplot(aes(x=length,y=width)) + # + means new layer
   geom_point() +
   geom_smooth()
#steps!!!!
 # start with data frame
 # ggplot using aes. aesthetic
 # adding layers
 
 iris %>% names
 iris$Species %>% unique()      

 iris %>% 
   ggplot(aes(x=Species,y=Petal.Length,color=Species)) +
   geom_boxplot() + #good plot to use. dont use bars.
   geom_jitter(width = .1,alpha=.25)
iris %>% 
  ggplot(aes(x=Sepal.Length,fill=Species)) +
  geom_density(alpha=.5)
 iris %>% 
   ggplot(aes(x=Petal.Length,y=Petal.Width,color=Species)) +
   geom_point(color='#b31793') + # #colorHEX number makes that color.
   geom_smooth(method = 'lm') + #method = 'lm' linear model
   theme_minimal() #gray background is smaller
 
 summary(iris$Sepal.Length)
 
 iris[iris$Species != 'virginica',] %>% 
   ggplot(aes(x=Petal.Length,y=Petal.Width,color=Species)) +
   geom_point(color='#b31793') + # #colorHEX number makes that color.
   geom_smooth(method = 'lm') + #method = 'lm' linear model
   theme_minimal() #gray background is smaller
 