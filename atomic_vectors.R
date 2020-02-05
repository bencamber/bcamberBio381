# Baisc examples of data types and their uses.

# 4 Feb 2020

# BEC


# -------------------------------------------------------------------------

# Using the assignment operator

x <- 5 # preferred
y = 4 # legal but not used except in function defaults

y <- y + 1
y
print(y)

# -------------------------------------------------------------------------

# variable names
z <- 3 # use lower case for variable names
plantHeight <- 3 # camel case naming because there's a capital in the middle. Not as easy to read as...
plant.height <- 3 # avoid periods in the name of variables
plant_height <- 3 # snake case: generates most readable code apparently
. <- 5 # use only for temporary variables

# -------------------------------------------------------------------------

# combine or concatenate function
z <- c(3.2,5,5,6)
print(z)
typeof(z)
is.numeric(z)

# character variable bracketed by quotes (single or double)
z <- c("perch", "striped bass", 'trout', 'binky boy')
z
print(z)
z <- c("This is one 'character string'", "and another")
print(z)
z <- c(c(2,3),c(4.4,6))
print(z)
z <- c(TRUE,FALSE,FALSE)
typeof(z)
is.integer(z)

# -------------------------------------------------------------------------

# each atomic vector has a unique type
typeof(z)
# they also have a specified length obtained in the environment, or by
length(z)
# atomic vectors can have optional names
z <- runif(5)
print(z)
names(z)
names(z) <- c("chow",
              "pug",
              "beagle",
              "greyhound",
              "zoinklby") # assigns name as a function. unusual but how it works
print(z)
z # returns third element in list z
z[c(3,4)] # gives third and fourth elements. Must use c function, otherwise you're specifying a 2D array instead of a vector
z[c("beagle","greyhound")] # calls variables by their names
z[c(3,3,3)] # gives third element of list three times

# add names when variable is built first (with or without quotes)
z2 <- c(gold=3.3, silver=10, lead=2)
print(z2)

# reset names
names(z2) <- NULL
# name some elements but not others
names(z2) <- c("copper","zinc")
print(z2)

# -------------------------------------------------------------------------

# NA designates missing data
z <- c(3.2,3.3,NA)
typeof(z)
length(z)
typeof(z[3]) # NA doesn't override rest of data's classification as "double"

z1 <- NA
typeof(z1)
is.na(z1)
!is.na(z)
mean(z)
mean(!is.na(z)) # asks for the mean of all trues and falses. not the right way
mean(z[!is.na(z)]) # asks for the mean of all values for anything that isn't NA. this is the right way

# NaN, -Inf, Inf from numeric division
z <- 0/0
print(z)
typeof(z)
z <- 1/0
print(z)
# null is nothing
z <- NULL
typeof(z)
is.null(z)

# -------------------------------------------------------------------------

# Three features of atomic vectors
# 1. Coercion
# All atomics are of the same type
# if elements are different, R coerces them into a single type
# logical -> integer -> double -> character

z <- c(0.1, 5, "O.2") # used a capital O instead of a zero
typeof(z) # tells you everything in this vector is a character
print(z) # print returns the double and integer as a character 

# use coercion for useful calculations
a <- runif(10)
print(a)
a > 0.5
sum(a > .5) # how many elements of a are greater than 0.5?
mean(a >0.7) # proportion of elements greater than 0.7

# qualifying exam question:
# in a normal distribution, approximately what percecnt of observations with a mean of zero and a variance of one are larger than 2.0?
mean(rnorm(100000) > 2)

# 2. Vectorization
z <- c(10, 20, 30)
z + 1
z2 <- c(1,2,3)
z + z2 # element by element operation
z^2
# recycling
z <- c(10,20,30)
z2 <- c(1,2)
z + z2 # if vectors are unequal length, R goes back to the beginning of the shorter vector and continues the operation. 

