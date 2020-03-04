### Manipulating data using dplyr
### March 3 2020

# What is dplyr?
# Part of tidyverse, new package with a set of tools for data manipulation
# same grammar and philosophy as ggplot, tidyr, etc. 

# specifically written to be fast
# individual functions for most operations
# easier to figure out what you want to do with your data

library(dplyr)

# Core verbs:
# filter() selects rows
# arrange()
# select() selects columns
# summmarize() and groupby()
# mutate() adds columns

data("starwars")
class(starwars)

# tbl: modern take on data frames specific to the tidyverse
# keeps best part of data frames, drops the dumb shit like how you change variable names and input types. 

# cleaning up data
# complete.cases not part of dplyr
swClean<-starwars[complete.cases(starwars[,1:10]),]
is.na(swClean[,1])
anyNA(swClean)

# what does our data look like now?
anyNA(swClean)


## filter() picks and subsets observations by their values
# uses >,<,>=,<=,!=,== for comparisons
# logical operators of and, or, and not: &, |, !
# filter() automatically excludes NAs

filter(swClean,gender=="male",height<180,height>100)
filter(swClean,eye_color %in% c("blue","brown"))


# arrange() reorders rows
arrange(swClean,by=height)
arrange(swClean,by=desc(height))

arrange(swClean,height,desc(mass))

starwars1<-arrange(starwars,height)
tail(starwars1)


# select chooses variables by their names, way easier than base R
select(swClean, 1:5)

select(swClean, name:species)
select(swClean, -(films:starships))

select(swClean,name,gender,species,everything()) #everything() is a helpful funciton for moving variables you care about to the beginning
select(swClean,name,contains("color"))
# other helpers: ends_with, starts_with, matches (use regex), num_range

# rename columns
select(starwars,name, haircolor=hair_color) # you specify new name followed by the previous name
# or
rename(swClean,haircolor=hair_color)


### mutate() creates new variables with functions of existing variables
mutate(swClean, ratio=height/mass) # didn't work?
swLBS<-mutate(swClean,mass_lbs=mass*2.2)
select(swLBS,1:3,mass_lbs)

# transmute() just keeps new variable
transmute(swClean,mass_lbs=mass*2.2)


# summarize and group_by" collapses values down to a single summary
summarize(swClean,meanHeight=mean(height)) # gives a 1x1 tibble with the mean height of everyone

# summarizing with NAs
summarize(starwars,meanHeight=mean(height, na.rm=TRUE),TotalNumber=n()) # you have to remove the NAs from the mean function. 

swGenders<-group_by(starwars,gender)
head(swGenders)
summarize(swGenders,meanHeight=mean(height, na.rm=TRUE), number=n())


# Piping is used to emphasize a sequence of actions; passes intermediate results into input of next function
# Don't use this unless you don't care at all about intermediate results. 

## use %>%

swClean %>%
  group_by(gender) %>%
  summarize(meanheight=mean(height),number=n())
