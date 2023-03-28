library(tidyverse)
library(readr)
library(modelr)
library(patchwork)
library(easystats)

df <- read_csv("./Data/GradSchool_Admissions.csv")
df %>% names()

df <- df %>% mutate(admit = case_when(admit=="1" ~ TRUE,  TRUE~FALSE),
                    admit=as.logical(admit))


#plots 
df %>% ggplot(aes(x=gpa)) + geom_bar()+ facet_wrap(~admit)

df %>%
  ggplot(aes(x=gpa))+geom_bar()+facet_wrap(~admit*rank)

df %>% ggplot(aes(x=rank))+geom_bar()+facet_wrap(~admit)

df %>% ggplot(aes(x=gre))+geom_bar()+facet_wrap(~admit)

df %>% ggplot(aes(x=gre, y=admit, color=gpa))+geom_point()+facet_wrap(~rank)
df %>% ggplot(aes(x=gpa, y=admit, color=gpa))+geom_point()
df %>% ggplot(aes(x=gpa, y=admit))+geom_point()+facet_wrap(~admit)
df %>% ggplot(aes(x=gpa, y=admit))+geom_smooth()
df %>% ggplot(aes(x=gre, y=admit))+geom_smooth()+facet_wrap(~admit)
df %>% ggplot(aes(x=rank, y=admit))+geom_smooth()
df %>% ggplot(aes(x=gpa, y=admit1))

mod1 <- glm(data=df, formula = admit~gre+gpa+rank, family=binomial)
mod1
summary(mod1)
check_model(mod1)

preds <- add_predictions(df, mod1, type='response')
preds

preds <- preds %>% mutate(rank=as.factor(rank))
plot1 <- preds %>% group_by(rank) %>% ggplot(aes(x=gpa, y=pred, color=rank, group=rank))+geom_smooth()
plot2 <- preds %>% group_by(rank) %>% ggplot(aes(x=gre, y=pred, color=rank, group=rank))+geom_smooth()

library(patchwork)
plot1+plot2
#LOGISTIC REGRESSION













