# Project questions
# "Lists" in R

library(tidyverse)
library(easystats)
mod1 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ)
mod2 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ + drv)
mod3 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ * drv)
mod4 <- mpg %>%
  glm(data=.,
      formula = cty ~ displ + drv + trans)

mod1$effects
mod1$family$family

# list: kinda like a vector
# BUT.... types dont have to be the same

my_list <- list(item1=c("a", "b", "c"),
     item2=1:3,
     item3 = mpg)

mpg %>% view()
  
# data frame really is a list
# where every element is the same length 
#and each element must be named.

mod_list <-
  list(mod1=mod1,
       mod2=mod2,
       mod3=mod3,
       mod4=mod4)

rm(mod1,mod2,mod3,mod4) #removing modeles that are already part of a list

# purrr package (for working with lists....functional programming)

for(i in mod_list){
  print(rmse(i))
}

map(mod_list,rmse) # this is so you dont have to write for loops.!!!!! 
#THE OUTPUT IS ITSELF A LIST
#unlist
map(mod_list,rmse) %>% 
  unlist()

# Even a cleaner code, same outcome
mod_list %>% 
  map_dbl(rmse)


plot_list <- 
  list(
  p1= ggplot(mpg, aes(x=displ, y= cty)) + geom_point(),
  p2= ggplot(mpg, aes(x=displ, y= cty, color =drv)) + geom_point()
)

p1$coordinates # plots are lists too.

plot_list$p1


my_list2 <- 
  list(mpg,
       c("a","b","c"))

names(my_list)
names(my_list2)

my_list2


#compare
c("a","b","c")
my_list2[[2]] #double brackets in this case calls the second element in the list.
#look the same

#more examples
my_list2[[1]] 
my_list2[[2]][1]

mpg %>% class

#different ways to search through lists
mpg[[1]] #makes character class (vector)
mpg$manufacturer

mpg[1] # makes a tibble = data frame

# get just year as a vector from element 1 of my_list2
my_list2[[1]][[4]]

# DOUBLE BRACKETS CREATE VECTORS.

# get the year in row 81
my_list2[[1]][[4]][81]

my_list$item3$year[81]


# My list two doesn't have names in the 1st 2 elements we created.

library(palmerpenguins)

my_list3 <- 
  list(mpg,
       penguins)
my_list3

map(my_list3, "year")
map(my_list3, 1) # pull the 1st element of each element of the list (fist column of each list)

map(my_list3, 1)[[1]] #only for the 1st element of my_list3

words <- "The quick borwn fox jumped over the lazy dog"

# character vector od length 1
# 1 item in the vector
words %>% class
words %>% length()


str_split(words, " ") #creates a list of words: "The" "quick" "borwn" "fox" ...
str_split(words, " ") %>% length()
# Both have length 1

# But the lenght of the 1st element in that list will be 9
str_split(words, " ")[[1]] %>% length()

# get this list of words into vector
str_split(words, " ")[[1]] %>% 
  str_remove(".")
str_split(words, " ")[[1]] %>% 
  str_remove("..")

str_split(words, " ")[[1]] %>% 
  str_remove("//.") %>% 
  str_to_lower()


sentences


#convert to lower case
#get every word by itself as its own element
#remove periods, commas and apostrophies
  
words_1 <-  
sentences %>%
  str_remove("//.") %>% # remove periods first
  str_remove(",") %>% 
  str_remove("'") %>% 
  str_to_lower() %>% 
  str_split(" ") %>% # Do the split last
  unlist() # 5745 words

words_1 %>%  length()
words_1 %>% class()

table(words_1) #gives each word its frequency
table(words_1) %>% 
  as.data.frame() %>% 
  arrange(desc(Freq)) %>% 
  head(10)

table(words_1) %>% 
  as.data.frame() %>% 
  arrange(desc(Freq)) %>% 
  tail(10)

# create data frame
word_freq <- 
  table(words_1) %>% 
  as.data.frame() %>% 
  arrange(desc(Freq))
  

library(wordcloud)
wordcloud(words = word_freq$words_1, freq = word_freq$Freq)


clean_freq <- 
word_freq %>% 
  filter(Freq >10 & Freq < 100)

wordcloud(words = clean_freq$words_1, freq = clean_freq$Freq)
