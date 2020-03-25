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


# dplyr lesson 2 ----------------------------------------------------------

### March 5 2020
### Exporting and importing data
library(dplyr)
data(starwars)
starwars1<-select(starwars,name:species)
head(starwars1)

## write.table
write.table(starwars1,file = "StarwarsNamesInfo.csv", row.names=F,sep=",")
data<-read.csv(file="StarwarsNamesInfo.csv",header=TRUE,sep=",",stringsAsFactors = FALSE,comment.char="#")
head(data)
data<-read.table(file="StarwarsNamesInfo.csv",header=TRUE,sep=',',stringsAsFactors = F)
class(data) # dplyr doesn't automatically turn data frames into tibbles

data<-as_tibble(data)
class(data)
glimpse(data)


### if you're only working in R, you can use the saveRDS() function. Don't do this if you want to export the data
saveRDS(starwars1,file="StarWarsTibble") # saves R object as a file

sw<-readRDS("StarWarsTibble") # this restores the unreadable saved object to a useful object in the environment

glimpse(sw)

## count NAs
sum(is.na(sw))

## how many are not NA?
sum(!is.na(sw))


swSp<-sw %>%
  group_by(species) %>%
  arrange(desc(mass))

# determine sample size in each group
swSp %>%
  summarize(avgMass = mean(mass,na.rm=T),avgHeight=mean(height,na.rm=T),n=n()) %>% # filter out low sample size
  filter(n>=2) %>%
  arrange(desc(n))


# count helper function
swSp %>%
  count(eye_color)

swSp %>%
  count(wt=height)


## useful summary functions
## uses a lot of base R functions

swSummary<-swSp %>%
  summarize(avgHeight=mean(height,na.rm=T),
            medHeight=median(height,na.rm=T),
            height_SD=sd(height,na.rm=T),
            height_IQR=IQR(height,na.rm=T),
            min_height=min(height,na.rm=T),
            first_height=first(height),
            n_eyecolors=n_distinct(eye_color,na.rm=T)) %>%
  filter(n>=2) %>%
  arrange(desc(n))


### grouping with mutate: standardize within groups
sw2 <-sw %>%
  group_by(species) %>%
  mutate(prop_height=height/sum(height)) %>%
  select(species,height,prop_height)
sw2 # this doesn't do anything because life sucks!

# pivot_longer/pivot_wider function
# compare to gather() and spread()

A<-rnorm(n=20,mean=50,sd=10)
B<-rnorm(n=20,mean=45,sd=10)
C<-rnorm(n=20,mean=62,sd=10)
library(tidyr)
z<-data.frame(A,B,C)

# old:
long_z<-gather(z,Treatment,Data,A:C)

#new:
z2<-z %>%
  pivot_longer(A:C,names_to="treatment",values_to = "data")
z2

### pivot_wider uses names_from and values_from (opposite of pivot_longer)
