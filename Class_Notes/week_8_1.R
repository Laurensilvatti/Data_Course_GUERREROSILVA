# import -> tidy -> visualize (explore, plot) -> model(make a simple representation, equations) ->
# (back to tidy if thinks can improve.) -> -> Communicate

# t.test to compare means. Test null hypothesis.  
# p value. Smaller the p values, rejects the null. (how surprised we will be if null was true. 
                                                      # the smaller p, the more surprised)
# p value of .05 means that 5% of the time we will be wrong.

# t value is a number.
# p value is an area greater from the t value point. 

# TYPES OF ERRORS
# Type 1 error rate 5%: Failing to detect reality. - A woman pregnant, but tested negative
# Type 2 error rate 5%: Seeing a pattern where there is not one. - A man testing positive in a pregnancy test.

#FOR STATS 2040 
# t.test()
# aov() Analysis of variance.
# corr.test()

# FOR BIO 3100
# glm()   Generalized linear model
# formulas in are y ~ x (y as a function of x) y is a response and x predictor

# in the case of sex vs height
# glm(data= df,
#     formula= height ~ sex) 
# gives us: estimate coefficient and p-value.
# SexM: 52cm
# intersect : 125cm (all humans are 125, if male: add 52 cm)



library(tidyverse)
mpg %>% view()


# response value: cty
names(mpg)
?mpg
mpg$class %>%  unique


mpg %>% 
  ggplot(aes(x=displ, y=cty))+
  geom_point()+
  geom_smooth()

mod <- glm(data = mpg,
    formula = cty ~ displ)
summary(mod)
# y = mx + b
# y = cty
# x = displ
# b = intecept 
# m = cty/displ

mpg %>% 
  ggplot(aes(x=displ, y=cty))+
  geom_point()+
  geom_smooth(method = "glm")


df <-  data.frame(displ = 1:10)
predict(mod,newdata = df)
 # we don't data know pass 7 in displacement. So we should use 1:7
# ALL MODELS ARE WRONG.


mod_1 <- glm(data = mpg,
           formula = cty ~ displ + cyl)
summary(mod_1)
# cyl has a samller p value. so more significant. 

df_1 <-  data.frame(displ = 1:10, 
                    cyl = 5 )
predict(mod_1,newdata = df_1)




mpg$drv %>% unique()
mod_2 <- glm(data = mpg,
             formula = cty ~ displ + cyl + drv)
summary(mod_2)


df_2 <-  data.frame(displ = 1:10, 
                    cyl = 5,
                    drv = "f")
predict(mod_2,newdata = df_2)

mpg %>% 
  ggplot(aes(x=displ, y=cty, color=drv)) +
  geom_point()+
  geom_smooth(method = "glm") +
  coord_cartesian(xlim = c(0,7)) + # x limit from 0 to 7
  facet_wrap(~cyl)

residuals(mod_2)
residuals(mod_2)^2 #gets rid of negative and positives
residuals(mod_2)^2 %>% mean %>% sqrt() # how far off on avg we are from reality.
residuals(mod)^2 %>% mean %>% sqrt() 

library(easystats)
compare_performance(mod,mod_2) 
compare_performance(mod,mod_2) %>% plot()
