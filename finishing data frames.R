# finishing data frames
# 2/13/2020
zmat<- matrix(data=1:30,ncol=3,byrow=TRUE) 
zdf<-as.data.frame(zmat)

# structure
str(zmat)
str(zdf)

# element referenceing is the same for matrices and data frames
# data frame automatically formats variable names, where matrix doesn't

zmat[2,3] 
zdf[2,3] # same as above

# column referencing
zmat[,2]
zdf[,2]
zdf$V2 # specifies second column of data by the variable name

# specifying single elements in matrices vs data frames
zmat[2] # treats the matrix like a vector
zdf[2] 

# complete.cases for scrubbing atomic vectors
zD<- c(runif(3),NA,NA,runif(2))
complete.cases(zD) # asks "is this a valid value?"

zD[complete.cases(zD)] # only shows valid values

# what about scrubbin' matrices
m<-matrix(1:20,ncol=4,byrow=TRUE)
m[5,2] <- NA
m[complete.cases(m),]
m[complete.cases(m[,c(1,2)]),]
m[complete.cases(m[,c(2,3)]),]

# techniques for assignments and subsetting matrices and data frames
m<-matrix(data=1:12,nrow=3)
dimnames(m)<- # expecting 2 arguments for a two-dimensional object (matrix)
  list(paste("species",LETTERS[1:nrow(m)],sep=""),
       paste("site",1:ncol(m),sep=""))
m[1:2,3:4]
m[c("speciesA","speciesB"),c("site3","site4")]

# use blanks to pull all rows and columns
m[c(1,2),]
m[,c(1,2)]

# use logicals for more complex subsetting
# e.g. select columns with totals > 15

colSums(m) > 15
m[,colSums(m)>15]
m[rowSums(m)!=22,]
m[,"site1"]<3
m["speciesA", ]<5

m[m[,"site1"]<3,m["speciesA"]<5]

# use drop=FALSE to retain dimensions
z2<-m[1, ,drop=FALSE]
z2
str(z2)


# basic form of data frame is a csv file
# excel export to csv alayws fucks up the dataset (great job, excel)

# -------------------------------------------------------------------------

mydata<-read.table(file="booboobingbings.csv",
                   header=TRUE,
                   sep=",",
                   stringsAsFactors=FALSE)
str(mydata)

# use saveRDS() will save an R object as a binary
saveRDS(mydata,file="myRDS")
z<-readRDS("myRDS")




