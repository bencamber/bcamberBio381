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
