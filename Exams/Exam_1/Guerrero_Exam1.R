library(tidyverse)
library(ggplot2)

#1  Read the cleaned_covid_data.csv file into an R data frame. 
df <- read_csv("cleaned_covid_data.csv")

#2 Subset the data set to just show states that begin with “A” and save this as an object called A_states.
A_states <- df[grepl("^A",df$Province_State),]

#3 Create a plot of that subset showing Deaths over time, with a separate facet for each state.
A_states %>% 
  ggplot(aes(x=Last_Update, y=Deaths)) +
  geom_point(size=0) + #Create a scatterplot
  geom_smooth(se=FALSE) + #Add loess curves WITHOUT standard error shading
  facet_wrap(~Province_State, scales = "free") #Keep scales “free” in each facet

#4 (Back to the full dataset) Find the “peak” of Case_Fatality_Ratio for each state and 
#save this as a new data frame object called state_max_fatality_rate.

state_max_fatality_rate <- df %>% filter(!is.na(df$Case_Fatality_Ratio)) %>% 
  group_by(Province_State) %>% # “Province_State”
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio)) %>% #“Maximum_Fatality_Ratio”
  arrange(desc(Maximum_Fatality_Ratio)) #Arrange the new data frame in descending order by Maximum_Fatality_Ratio

#5 Use that new data frame from task IV to create another plot. 
state_max_fatality_rate %>% 
  ggplot(aes(x=reorder(Province_State, -Maximum_Fatality_Ratio), y=Maximum_Fatality_Ratio)) + #x-axis arranged in descending order, just like the data frame
  geom_col() + #bar plot
  theme(axis.text.x = element_text(angle = 90)) #X-axis labels turned to 90 deg to be readable

#6 Using the FULL data set, plot cumulative deaths for the entire US over time

df %>% 
  group_by(Last_Update) %>% 
  summarise(Cumulative_Deaths = sum(Deaths)) %>% 
  ggplot(aes(x=Last_Update, y= Cumulative_Deaths)) +
  geom_point(size=0)

  
  