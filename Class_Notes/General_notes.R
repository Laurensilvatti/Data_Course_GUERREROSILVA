# Class notes Jan 17

# How to upload files to GitHub
# 1. Make any change 
#-New file
#-delete file
#-Change file
# 2. git add _____ name of file
# 3. git commit -m " " 
# 4. git push


# Updating from others
# 1. Navigate to folder
# 2. git pull

#:)

# cammand + option + b  runs code before cursor

# hashtg means everything to the right on that line 
#is for humans, wont be read as R code 
# run a line of code hit cntrl enter
# hit tab in parenthesis for more information
# ~ means home
#when in doubt hit tab in parenthesis
# list.files(path = "Data/",pattern = ".csv") - looks for files in folder only with .csv in name
#list.files(recursive = TRUE) - re curses/lists all the files, digs into the file
# list.files(path = "Data/",pattern = ".csv", full.names = TRUE) - gives path from where you started
# TRUE = yes please, a special term, FALSE is special as well. 
#TAB helps auto complete
# comma seperates arguments to a function
# highlight push cntrl-shift-c comment vs uncomment (make a hashtag)
# list.files(path = "Data",pattern = ".csv", full.names = TRUE) - brings up paths to all my files 
# alt minus makes little arrow, assigner, save path to file under codename, save as variable for a value
# .csv -- data seperated by commas (comma seperated values)
# read.csv -- read a csv file into R
# wingspan <- read.csv(path) -- saves Data as an R thingy -- R knows about a data set has memorized in as <- (alt (-)) wingspan

# cntrl-alt-b runs everthing in your scirpt before your cursor

# wingspan$ access to one column of data

# $(whatever your dataframes name is)(whatever column you want) --- gives you access to that column

#"num" numeric type of data
#"chr" character type of data
# wingspan = DATAFRAME -- rows and columns
#data frame: 2-dimensional, has rows and columns
#vector: 1-dimensional, kind of like a list, a bunch of numbers in order
# max(m) maximum mass; mean(m); min (m) summary(m)
#cumsum (m)
# plot (cumsum(m)) -- makes a plot of cumulative sum of masses
#sort (m)
# plot (sort (m)) sorting data on a plot
# plot with x and y axis -- plot (w,m)

# to get correlation of data set : cor (x=wingspan$wingspan, y=wingspan$mass)
