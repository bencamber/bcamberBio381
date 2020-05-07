# ------------------------------------------------------
# File creation and batch processing
# 14 Apr 2020
# ------------------------------------------------------
# 

# ------------------------------------------------------
# FUNCTION: file_builder
# description: creates a set of random files for regression
# input: file_n = number of data files to create
#         file_folder = name of folder for random files
#         file_size = c(min,max) number of rows in file
#         file_NA = average number of NAs per column
# output: set of random files
########################################################
file_builder<-function(file_n=10,
                         file_folder = "randomfiles/",
                         file_size = c(15,100),
                         file_NA = 3){
for (i in seq_len(file_n)){
  
  file_length <- sample(file_size[1]:file_size[2],size=1)
  var_x <- runif(file_length) # create random x
  var_y <- runif(file_length) # create random y
  df <- data.frame(var_x,var_y) # bind into a data frame
  bad.vals <- rpois(n=1,lambda=file_NA)
  df[sample(nrow(df),size=bad_vals),1] <- NA
  df[sample(nrow(df),size=bad_vals),2] <- NA
  file_label <- paste(file_folder,"ranFile", # create label with padded zeroes
                      formatC(i,
                              width=3,
                              format="d",
                              flag="0"),
                              ".csv",
                              sep="")
  
  write.table(cat("# Simulated random data for batch processing",
                  "\n",
                  "# timestamp: ",
                  as.character(Sys.time()),
                  "# ---------------------------------------",
                  "\n",
                  file=file_label
                  row.names="",
                  col.names="",
                  sep=""))
  write.table(x=df,
              file=file_label,
              sep=",",
              row.names=FALSE,
              append=TRUE)


# ------------------------------------------------------
# FUNCTION: reg_stats
# description: fits linear models, extract model stats
# input: 2-column data frame (x and y)
# output: slope, p-value, and r^2
########################################################
reg_stats<-function(d=NULL) {
          if(is.null(d)) {
            x_var <- runif(10)
            y_var <- runif(10)
            d <- data.frame(x_var,y_var)
          }
. <- lm(data=d,d[,2]~d[,1])
. <- summary(.)
stats_list <- list(Slope=.$coefficients[2,1],
                   pVal=.$coefficients[2,4],
                   r2=.$r.squared)
return(stats_list)
}

# -------------------------------------------------------------------------
library(TeachingDemos)
char2seed("shitcock")
########################################################
# Global variables
file_folder <- "randomfiles/"
n_files <- 100
file_out <- "StatsSummary.csv"
########################################################
# create random datasets
dir.create(file_folder)
file_builder(file_n=n_files)
file_names<- list.files(path=file_folder)

# create a data frame to hold summary file statistics
ID <- seq_along(file_names)
file_name <- file_names
slope <- rep(NA,length(file_names))
p_val <- rep(NA,length(file_names))
r2 <- rep(NA,length(file_names))

