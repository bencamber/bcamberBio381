# Functions
# 25 Feb 2020

# everything in R is a funtion
sum(2,3) # prefix function
3 + 1 # operator, but it is actually a function
`+`(3,2) # rewritten as an infix function

y<-3 
print(y)

# to see the contents of a function, print it 
print(read.table)


# anatomy of a user-defined function --------------------------------------
# name as a verb
function_name<-function(par_x=default_x,
                        par_y=default_y,
                        par_z=default_z) {
  #function body
  # lines of r code and annotation
  # may call or create other functions within this function
  # create local variables
  return(q) # returns a single element from the function
}

function_name(x=my_matrix,
              y="Order",
              z=1:10)

# Use prominent hash fencing around your funciton code
# give a header with function name, brief description of input and output
# names inside functions can and should be short
# functions should be short and simple, no more than 1 screen full of text
# if too complex, functions are impossible to debug
# provide default values for all input parameters. It should work even if it isn't given any inputs. 
# make the default values from random number generators. 



# Hardy-Weinberg function -------------------------------------------------

# inputs: an allele frequency p (0-1)
# output: p and the frequencies of genotypes AA, AB, and BB

# -------------------------------------------------------------------------

hw<-function(p=runif(1)) {
  if(p > 1.0 | p < 0.0){
    return("function failure: p must be between 0 and 1 inclusively")
  }
  q<-1-p
  f_AA<-p^2
  f_AB<-2*p*q
  f_BB<-q^2
 vec_out<-list(p=p,
               f_AA=f_AA,
               f_AB=f_AB,
               f_BB=f_BB)
 return(vec_out)
}

# -------------------------------------------------------------------------
hw()
hw(p=0.5)
pp<-0.6
hw(p=pp)

###########################################################################
hw(1.1) # doesn't work
z<-hw(1.1) # will work, but printing z will give you the error


# spring break??? ---------------------------------------------------------

# global variables: visible in all parts of the code, declared in main body of the program
# local variables: only visible in the function; either declared in the function or passed to it through the input parameters
myfunk<-function(a=3,b=4) {
  z<-a+b
  return(z)
}
myfunk()
##########################################################################
badfunk<-function(a=3){ # function compiles just fine, but it won't return anything because there's no b variable declared locally or globally
  z<-a+b
  return(z)
}
b<-4
badfunk() # works now because b is found globally after the function can't find it locally
##########################################################################
okfunk<-function(a=3){
  bb<-100
  z<-a+bb
  return(z)
}
okfunk()
okfunk(a=2) # you can manipulate a, but not bb
print(bb) # you can't even print bb because it's not an object in global environment

#########################################################################
# Funciton: fit linear
# fits simple regression line
# inputs: numeric vectors of predictor (x) and response (y)
# output: slope and p-value from said regression

finlin<-function(x=runif(n=20),
                 y=runif(n=20)) {
  mod<-lm(y~x)
  myout<-list(slope=summary(mod)$coefficients[2,1],
              p_val=summary(mod)$coefficients[2,4])
  plot(x=x,y=y)
  return(myout)
}
########################################################################
# Funciton: fit linear 2
# fits more complex inputs
# inputs: numeric vectors of predictor (x) and response (y)
# output: slope and p-value from said regression

finlin2<-function(p=NULL) {
  if(is.null(p)) {
    p<-list(x=runif(20), y=runif(20))
  }
  mod<-lm(p$y~p$x)
  myout<-list(slope=summary(mod)$coefficients[2,1],
              p_val=summary(mod)$coefficients[2,4])
  plot(x=p$x,y=p$y)
  return(myout)
}
pars<-list(x=1:10,y=runif(10)) # make a list that you want to pass to finlin2 
finlin2(p=pars)

# use the do.call function to pass a list of parameters to a function
z<-c(runif(99),NA)
mean(z) # R doesn't like the missing value
mean(x=z,na.rm=TRUE,trim=0.05)

mist<-list(x=z,na.rm=TRUE,trim=0.05)
mean(mist) # doesn't work because mist is assigning the mean parameters into the vector
do.call(mean,mist) # do.call asks for the function followed by the list of arguments. mist is the list of arguments for a mean, so this works. 

