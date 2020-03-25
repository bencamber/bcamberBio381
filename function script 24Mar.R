# ------------------------------------------------------
# illustrate use of functions and structured programming
# 24 Mar 2020
# ------------------------------------------------------
# 


# all functions need to be put into memory before they're called. 

# load libraries -----------------------------------
library(ggplot2)
# source files -----------------------------------
source("my functions.R")
# global variables -----------------------------------
ant_file<-"antcountydata.csv"
x_col<-7 # column 7, latitude center of each county
y_col <- 5 # column 5, number of a ant species
########################################################
temp1<-get_data(file_name = ant_file)
x<-temp1[,x_col] # extract predictor variable
y<-temp1[,y_col] # extract response variable

# fit regression model
temp2<-calculate_stuff(x_var=x,y_var=y)

# extract residuals
temp3<-summarize_output(z=temp2)

# create graph 
graph_results(x_var=x,y_var=y)
  
print(temp3)
