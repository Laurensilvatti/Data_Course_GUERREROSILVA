library(tidyverse)
library(gganimate)
library(janitor)
dat <- read_csv("../../Data/BioLog_Plate_Data.csv")
colnames(dat) <- make_clean_names(colnames(dat)) #cleaning names (no capitals)

# 1.
dat_long <-dat %>% 
  pivot_longer(cols = c("hr_24", "hr_48", "hr_144"),
               values_to = "absorbance",   #values of previosus col to new col called abs
               names_to = "time",   #names of prev col to new col called time
               names_prefix = "hr_", #taking off hr_ prefix
               names_transform = list(time=as.numeric)) # numermic values to 24 48 144

# 2. 
#skimr::skim(dat_long)
unique(dat_long$sample_id)

dat_long <- dat_long %>% 
  mutate(source = case_when(sample_id == "Soil_1" ~ "Soil",      #creates a new col called source and replaces words withing prev col.
                            sample_id == "Soil_2" ~ "Soil",
                            sample_id == "Clear_Creek" ~ "Water",
                            sample_id == "Waste_Water" ~ "Water"))

unique(dat_long$source)

# 3.  1st plot            
plot_1 <- dat_long %>% 
  filter(dat_long$dilution == .1)

plot_1 %>% 
  ggplot(aes(x=time,y=absorbance,color=source)) +
  facet_wrap(~substrate) +
  geom_smooth(se=FALSE) +
  labs(x="Time",
       y="Absorbance",
       subtitle = "Just dilution 0.1",
       color= "Type") +
  theme_minimal()

#4. second plot
unique(dat_long$substrate)

plot_2 <- dat_long %>% 
  filter(dat_long$substrate == "Itaconic Acid") 


plot_2 <- plot_2 %>% 
  group_by(time, sample_id, dilution) %>% 
  summarise(Mean_ab = mean(absorbance)) %>% 
  ggplot(aes(x=time,
             y=Mean_ab,
             color=sample_id)) +
  facet_wrap(~dilution) +
  geom_line() +
  labs(x="Time",
       y="Mean_absorbance",
       color="Sample ID") +
  theme_minimal()

plot_2 +
  transition_reveal(time)

# I was about to jump out of my balcony with step 4 and then realized that
# I was forgetting basic things....



