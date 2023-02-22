#install.packages("readxl")
library(tidyverse)
library(readxl)
file <- "~/OneDrive/Documentos/Chem 1225/exp_3_excel.xlsx"

#read in each sepratate run
run1 <- readxl::read_xlsx(file, range = "A8:B573", col_names = FALSE)
run2 <- readxl::read_xlsx(file, range = "D8:E846", col_names = FALSE)

#made meaningufl column names
names(run1) <-c("time_s","temp_c")
names(run2) <-c("time_s","temp_c")

#add 3rd column
run1$run <- "run_1"
run2$run <- "run_2"

#combine the two runs together into one data set
df_1 <- full_join(run1,run2)
write_csv(df_1,"~/OneDrive/Documentos/Chem 1225/exp_3_cleaned.csv")
df_1 %>% 
  mutate(chemical = case_when(run == "run_1" ~ "Lauric Acid",
                              run == "run_2" ~ "Mixture")) %>% 
  ggplot(aes(x=time_s, y=temp_c, color=chemical)) +
  geom_point()

#Save plot
ggsave(filename = "~/OneDrive/Documentos/Chem 1225/exp_3_plot.png", 
       height = 8, width = 8)



