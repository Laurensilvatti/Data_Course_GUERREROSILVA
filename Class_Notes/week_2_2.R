#Assigment_2

#finding files
list.files()

# recursively   logical means TRUE or FALSE
list.files(recursive = TRUE)

# with a seacrch pattern
csvs <- list.files(pattern = ".csv",
            recursive = TRUE)

# [] lets you picks elements from and object- the object in this case is cvs

airlines <- csvs[1] #character vector... 1st element
readLines(airlines,n=3)     #Real lines in files 1-3. or 1-x
readLines(csvs[1]) #lets you read in 1 line at the time
# makes a character vector where each line is an element
airlines <- read.csv(airlines) #pays attention to commas to split lines
# into columns


#  numeric vectors

x <- 1:10
length(x) #count mumber of elements on a vector
length(x) * 2

length(5) # 5 is a vector of length 1

# EVERYTHING IN R IS VECTORIZED
y <- 2:11
x
y
x + y # sums each number in order with the other vector below
x * y
x / y

letters
LETTERS
letters + LETTERS
paste0(letters,LETTERS,letters)

#expressions (logical)

class(x > 3)  #class gives you the vector class

# TRUES is 1
# FALSE is 0

sum(x > 3)

x >= 3
x <= 5
x == 5 #== is x iqual to 5

wingspan <- read.csv('./Data/wingspan_vs_mass.csv')
names(wingspan) #shows name of element. Each column is really just a vector
names(x) #no name in this vector

wingspan$mass # $ seach within one column/vector
wingspan$mass >= 70
sum(wingspan$mass >= 70)

wingspan$giant <- wingspan$mass >= 70 #created a new column called giant saying 
#true and false if an aninal is greater >= than 70

plot(x=wingspan$wingspan,y=wingspan$mass,col=wingspan$giant)


#doing assignment 2
# 4
csv_files <- list.files(path='Data',pattern = '.csv')

#5 

