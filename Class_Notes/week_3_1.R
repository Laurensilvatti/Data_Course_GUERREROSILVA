# notes jan 24

#character class
letters
class(letters)
length(letters) # number of elements in a vector
rep(letters,2) #repeat twice
length(rep(letters,2))
class(length(rep(letters,2)))# number of elememts when letter repeated twice 
rep(letters,each=2) #each letter will be repeated twice. 
rep(letters,each=2) [20] # [] pick specific elements
rep(letters,each=2) [20:25] 
 x <- "1"
 x+1
 as.numeric(x) + 1 #turns something into actual numbers
 as.character(123) #converts something into characters 
 
 y <- c(1:10,'one') # vectors can only be one thing. R turned everything into characters.
 # c means combine
as.numeric(y) 

y<-1
# NA refers to missing data.

as.numeric(letters)



#numeric class
10
class(10) #numeric
class(10L) #integer if you add an L
length(10)
rep(10:15, each=30)
seq(0,10,length.out=3) #devided the total number into 3 equal spaces. 0 5 10

#factor class
x<-factor(letters)
z<-rep(x,each=50)
length(z)
class(x)
length(x)
levels(x) #levels can conly be done with factors
levels(z)
z # it will warn me that is is a factor by stating: LEVELS in the console. 
z[1300]

c(z[1300],"A") # the code runs "26" "A" becuase the 1300th character was z. and z is the 26th factor.

as.character(z)
as.numeric(z)

as.numeric('z')
 # ! means is not.
!FALSE
1 != 5
1 == 5

mtcars
mtcars$mpg
dim(mtcars) # [rows, columns]
mtcars[1,1] # 2 numbers because is a 2 dimensional
mtcars[1, ]
mtcars[1:3,1:3]
mtcars[c(1,3),c(1,3)] # c - helps specify what rows and column we need.
mtcars
head(mtcars)

mtcars$mpg > 21
mtcars[mtcars$mpg > 21, ] # only shows the rows > 21 and shows all other columns.
row.names(mtcars)
mtcars$new_name <- #creates a new column called names.

#_______FOR LOOPS______
  
for(yourmom in 1:10){ #curly brakets outside parenthesis add everything we need the loop to do.
  print(yourmom + 5)
}

for(yourdad in letters){
  print(paste('your dad = ' ,yourdad))
  }  

myfiles<- list.files("Data",pattern = '.csv', full.names = TRUE)

for(i in myfiles){
  print(readLines(i,n=1)) # n= the number of lines. (n=3 read the first 3 lines of each file.)
}

for(i in myfiles){
  print(readLines(i)[c(5,6)]) 
}
  
for(i in myfiles){
  print(read.csv(i)) # will read all data in the .csv files.
}
