rm(list=ls())
# http://www.r-tutor.com/elementary-statistics/qualitative-data/frequency-distribution-qualitative-data

library(MASS)
# Load painters information

painters
# dataset

names(painters)
# list of columns

school <- painters$School
# the painter schools 

school.freq <- table(school)   
# apply the table function

school.freq
# display table frequency


grep("^R", painters, value = TRUE)

attach(mtcars)
aggdata <-aggregate(mtcars$disp,by=list(cyl), FUN=mean)
print(aggdata)

cbind(school.freq) 
# We apply the cbind function to print the result in column format

# The relative frequency distribution of a data variable is a summary of the frequency proportion in a collection of non-overlapping categories. The relationship of frequency and relative frequency is: relative frequency = frequency/sample size

school.relfreq <- school.freq / nrow(painters)
# Then we find the sample size of painters with the nrow function, and divide the frequency distribution with it. Therefore the relative frequency distribution is:

school.relfreq
# Display relative frequency

cbind(school.relfreq)
# Display in a column

sum(school.relfreq)
# sum of all relative frequency to verify it adds up to 1

old = options(digits=1) 
# reduces to two digits, need to confirm how this function works
school.relfreq 

barplot(school.freq)
# apply the barplot function 

colors <- c("red", "yellow", "green", "violet",  "orange", "blue", "pink", "cyan") 
# set colors for barplot

barplot(school.freq, col=colors) 
# bar plot with colors

pie(school.freq)
# pie chart

pie(school.freq, col=colors)
# pie charts with preset color

summary(painters)
painters

tapply(painters$Composition, painters$Drawing, max) 
df <- painters
df
tapply(df$Composition, df$Drawing, max) 
