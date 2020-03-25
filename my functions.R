# ------------------------------------------------------
# Sourcing file to contain all functions
# 24 Mar 2020
# ------------------------------------------------------

# ------------------------------------------------------
# FUNCTION: get_data
# description: read in .csv file
# input: .csv file
# output: data frame
########################################################
get_data<-function(file_name=NULL) {
if(is.null(file_name)) {
  df<-data.frame(ID=101:110,
                 var_a=runif(10),
                 var_b=runif(10))
} else {
  df<-read.table(file=file_name,
                 header=TRUE,
                 sep=",",
                 stringsAsFactors = FALSE)
}
  return(df)
  get_data()
} # end of get_data


# ------------------------------------------------------
# FUNCTION: calculate_stuff
# description: fit an ordinary least squares regression model
# input: x and y vectors of numeric and they must be the same length
# output: entire model summary that will come from fitting a linear model
########################################################
calculate_stuff<-function(x_var=runif(10),
                          y_var=runif(10)) {
  
  # function body
  df<-data.frame(x_var,y_var)
  reg_model<-lm(y_var~x_var,data=df)
  return(summary(reg_model))
} # end of calculate_stuff

calculate_stuff()

# ------------------------------------------------------
# FUNCTION: summarize_output
# description: pull elements from model summary list
# input: list from summary call of lm
# output: vector of regression residuals
########################################################
summarize_output<-function(z=NULL) {
  if(is.null(z)) {
    z <- summary(lm(runif(10)~runif(10)))
  }
  
  return(z$residuals)
  
} # end of summarize_output

summarize_output()
# ------------------------------------------------------
# FUNCTION: graph_results
# description: graph data and fitted OLS line
# input: x and y vectors of numeric. Must be same length
# output: creates graph
########################################################
graph_results<-function(x_var=runif(10),
                        y_var=runif(10)) {
df<-data.frame(x_var,y_var)
p1<-qplot(data=df,
          x=x_var,
          y=y_var,
          geom=c("smooth","point"))
print(p1)
message("Message: Regression graph created!")

  
} # end of graph_results
graph_results()

# ------------------------------------------------------
# FUNCTION: ilr
# description: 
# input: stochastic distributions
# output: summary table of each iteration of the model
########################################################
ilr<-function(x=5) {

# function body
return("Checking...multiple linear regression")

} # end of multiple linear regression

