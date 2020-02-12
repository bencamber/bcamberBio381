# Working with matrices, lists, and data frames
# 11 Feb 2020

# -------------------------------------------------------------------------

library(ggplot2)


# Matrices ----------------------------------------------------------------

# a matrix is just an atomic vector reorganized into 2 dimensions
# create a matrix with matrix function
m<-matrix(data=1:12,nrow=4,ncol=3)
print(m)
m<-matrix(data=1:12,nrow=4)
print(m)
# use byrow=TRUE to change filling direction
m<-matrix(data=1:12, nrow=4, byrow=TRUE)
print(m)

# use dim() function to find number of rows and colunmns
dim(m)
# also change rows and columns with dim()
dim(m)<-c(6,2) # product of the two numbers must equal length of atomic vector
print(m)
dim(m)<-c(4,3)
print(m)

# individual row and column dimensions
nrow(m)

# length of atomic vector is still there
length(m)

# adding names to matrix
rownames(m)<-c("hinkus","binkus","coppa","doodoo")
print(m)
colnames(m)<- LETTERS[1:ncol(m)]
print(m)

# grabbing an entire atomic vector 
z<-runif(3)
z[]

# specifying rows and columns, separated by a comma
m[2,3] # grabs the value in the 2nd row and 3rd column
m

# choose row two and all columns
m[2,]
m[,3]

# dimnames can assign a large matrix dimension names quickly
dimnames(m)<-list(paste("site",1:nrow(m),sep=""),
                  paste("species",1:ncol(m),sep="_"))
print(m)

# transpose a matrix (change rows and columns)
m2<-t(m)
print(m2)

# add a row to a matrix with rbind()
m2 <- rbind(m2,c(10,20,30,40))
print(m2)
dimnames(m2)<-list(paste("species",1:ncol(m2),sep="_"),
                   paste("site",1:nrow(m2),sep=""))
print(m2)

# or, if you're just missing one of the row names, you can assign a name to a single row
rownames(m2)[4]<- "myfix"
print(m2)

# access rows and columns with names as well as by index numbers
m2["myfix","site3"]
m2[c("myfix","species_1"),c("site2","site2")]

# cbinb() adds a column to a matrix

my_vec<-as.vector(m)
m
my_vec


# Lists -------------------------------------------------------------------

# lists are like atomic vectors, but each eleemtn can hold different things of different types and sizes
joink<-list(1:10,
            matrix(1:8,nrow=4,byrow=TRUE),
            letters[1:3],
            pi)

str(joink)

# try grabbing an element of a list
joink[4]
typeof(joink[4]) # you can't use an element of a list for functions that don't use lists as an argument. everything in a list becomes a list
joink[[4]]
typeof(joink[[4]]) # use double brackets to tell the list part to fuck off. what about for matrices or atomic vectors?
typeof(joink[[2]]) # tells us everything in that matrix is an integer (it is)
joink[[2]]

# if a list has ten elements it is like a train with ten cars. 
# [5] makes a mini-train with just car 5
# [[5]] gives me the contents of car 5
# [c(4,5,6)] gives me a little train with cars 4, 5, and 6. 

joink[[2]][3,2]

# name list items as we create them
hoink<-list(Tester=FALSE,
            little_m=matrix(runif(9),nrow=3))
hoink # $ in readout of hoink just shows what the labels are
hoink$little_m
hoink$little_m[2,3]
hoink$Tester
bink<-matrix(1:100,nrow=10,byrow=TRUE)
bonk<-matrix(1:100,nrow=10)
horsecock<-bink*bonk 
horsecock

# using a list to access output from a linear model
y_var <-runif(10)
x_var<-runif(10)
munkus<-lm(y_var~x_var)
qplot(x=x_var,y=y_var)
print(munkus)
summary(munkus)
str(summary(munkus))

# use the unlist() function to flatten outputs. This is just a way to get access to an otherwise inaccessible element of the structure of your model
z<-unlist(summary(munkus),recursive=TRUE)
print(z)
my_slope<-z$coefficients2
my_pval<-z$coefficients8
print(c(my_slope,my_pval))


# data frame --------------------------------------------------------------

# a data frame is a list of equal-lengthed vectors, each of which is a column in a data frame.
# differs from a matrix in that different columns may be of different data types. 

coco<-1:12
blip<-rep(c("con","lowN","highN"),each=4)
zipes<-runif(12)
d_frame<-data.frame(coco,blip,zipes,stringsAsFactors = FALSE)
print(d_frame)
d_frame[[2,]]
str(d_frame)

newts<-list(coco=13,blip="highN",zipes=0.502) # make a list that we want to add as a row to the data frame
str(newts)
d_frame<-rbind(d_frame,newts)
d_frame

# adding a column is easier because it will be all one data type (probably)
yowl<-runif(nrow(d_frame))
d_frame<-cbind(d_frame,yowl)
d_frame
