library(tidyverse)

# process the text data instead

txt_path <- "exp_3_text" #add path if needed
txt <- readLines(txt)

# find lines that have "Vernier"
starts <- grep("Vernier",txt)
txt[starts]
# seems like "Vernier" is followed by 6 useless lines, then the data, then an empty line


# the word "Vernier" should mark the end of each run output by the computer ...
# well, the beginning of a run actually

# build vector of skip values:
skips <- starts+6

# define empty list
df_list <- list()
# define function to read in each as a new item in the empty list
for(i in seq_along(skips)){
  run <- read_delim(file=txt_path,
             col_names = FALSE,
             delim = "\t",
             skip = skips[i],
             )
  run$X3 <- NULL # remove empty column
  names(run) <- c("time_s","temp_c")# rename columns
  run$run <- paste0("run_",i) # add run name column
  max_n <- min(grep("Vernier",run$time_s)) - 1 # find last line before first instance of "Vernier"
  run <- run[1:max_n,]# subset to remove everything after that
  run <- run %>% 
    mutate(time_s = as.numeric(time_s),
           temp_c = as.numeric(temp_c))# convert to numeric
  df_list[[i]] <- run # add to list of data frames
}

# combine all items from list into new data frame
df_all <- reduce(df_list,full_join)

df_all %>% 
  ggplot(aes(x=time_s,y=temp_c,color=run)) +
  geom_point()


# for-loop to read through file once for each run, save to only those rows, convert to numeric, etc.for(i in seq_along(skips)){