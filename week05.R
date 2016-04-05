# ==========================================================================

# SLU Data Science Seminar - Spring 2016 - Week 05

# ==========================================================================

rm(list = ls()) # clear workspace

# ==========================================================================

# file name - week05.R

# project name - Spring 2016

# purpose - Illustrate Functions for Working with Factors

# created - 04 Apr 2016

# updated - 04 Apr 2016

# author - CHRIS

# ==========================================================================

# full description - 
# This script illustrates multiple functions for manipulating factors
# in R.

# updates - 
# none

# ==========================================================================

# superordinates  - 
# auto.csv, downloaded from GitHub

# subordinates - 
# none

# ==========================================================================

# get working directory
getwd()

# change working directory
# setwd("E:\Users\prenercg\Documents")
setwd("/Users/herb/Dropbox/Dropbox Inbox")

# load data
cars <- read.csv("auto.csv", header=TRUE, stringsAsFactors=TRUE)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# recap for Week 04
# create ordinal from continuous
cars$mpg2 <- cut(cars$mpg,breaks=5,labels=c("lowest", "lower middle", 
                  "middle", "upper", "highest"), ordered = TRUE)

# tabulate frequencies for new object
table(cars$mpg2)

# ==========================================================================

# 1. edit labels
levels(cars$mpg2)[levels(cars$mpg2)=="lower middle"] <- "lowMid"

# tabulate frequencies for edited object
table(cars$mpg2)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 2. reorder values
# view labels
levels(cars$mpg2)

# reverse order of values
cars$mpg2 <- ordered(cars$mpg2, levels=rev(levels(cars$mpg2)))

# view labels
levels(cars$mpg2)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 3. collapse upper most categories
cars$mpg3 <- cars$mpg2
levels(cars$mpg3)[levels(cars$mpg3)=="highest"] <- "upper"

# tabulate frequencies for edited object
table(cars$mpg3)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 4. collpase multiple categories
# create new object
cars$mpg4 <- cars$mpg3 

# collapse upper into middle
levels(cars$mpg4)[levels(cars$mpg4)=="upper"] <- "middle" 

# collapse lowMid into lowest
levels(cars$mpg4)[levels(cars$mpg4)=="lowMid"] <- "lowest"

# rename middle to high
levels(cars$mpg4)[levels(cars$mpg4)=="middle"] <- "high"

# rename lowest to low
levels(cars$mpg4)[levels(cars$mpg4)=="lowest"] <- "low"

# reorder values
cars$mpg4 <- ordered(cars$mpg4, levels=rev(levels(cars$mpg4)))

# tabulate frequencies for edited object
table(cars$mpg4)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 5. change order of factors
# tabulate frequencies for original object
table(cars$foreign)

# move foreign to first position in factor
cars$foreign2 <- relevel(cars$foreign, "Foreign")

# tabulate frequencies for new object
table(cars$foreign2)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 6. bar plot for miles per gallon
counts <- table(cars$mpg2)
barplot(counts, main="1979 Car Distribution", 
        xlab="Miles per Gallon Groups")
dev.copy(png,'mpg.png') # create file from content of plot window
dev.off() # save file

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 7. stacked bar plot for miles per gallon by foreign
counts <- table(cars$foreign, cars$mpg2) # count values for plot
barplot(counts, main="1979 Car Distribution by Origin",
        xlab="Miles per Gallon Groups", col=c("darkblue","red"),
        legend = rownames(counts))
dev.copy(png,'mpgByOriginStack.png') # create file from content of plot window
dev.off() # save file

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# 8. grouped bar plot for miles per gallon by foreign
counts <- table(cars$foreign, cars$mpg2) # count values for plot
barplot(counts, main="1979 Car Distribution by Origin",
        xlab="Miles per Gallon Groups", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)
dev.copy(png,'mpgByOriginGroup.png') # create file from content of plot window
dev.off() # save file

# ==========================================================================

# exit
