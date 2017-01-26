# clean list
rm(list=ls())
# load file
housing.data <- read.csv("~/Desktop/R/BurlingtonPropertyDetails.csv", header = TRUE)
view data structure
str(housing.data)

#  -  handy to know where your working directory is set  - Read more at: http://scq.io/AVkLvbhX#gs.njsBe5Y 
getwd()

# changing the path that you get as a result of this function, maybe to the folder in which you have stored your data set - Read more at: http://scq.io/AVkLvbhX#gs.njsBe5Y
setwd("<location of your dataset>") 

# set values as dates, default yyyy-mm-dd back into the dataframe
pricing$Sale.Date <- as.Date(pricing$Sale.Date)

# finds a row number of a given requires value
which(pricing.2001$Sale.Price == 470000)
# 2001-07-27  254400.00 median 230000.00

start <- as.Date("2001-01-01")
end   <- as.Date("2002-01-01")
pricing.2001 <- sqldf(sprintf("select * from pricing where [Sale.Date] between %i and %i",start,end))
summary(pricing.2001)

# ggplot2 stuff
ggplot(pricing2, aes(`Sale Date`, `Sale Price`, color = `Deed Type`)) +
  geom_point() 

# htmlwidgets
install.packages("htmlwidgets")

install.packages("leaflet")

install.packages("tilegramsR")

pricing %>%
  group_by(Deed.Type) %>%
  summarise_each(funs(mean(., na.rm=TRUE)), -Sale.Price)


aggregate(pricing.2001[,5:6], list(pricing.2001$Sale.Date), median)


# This is a scatterplot, pch is the scatter plot point styel, see http://www.endmemo.com/program/R/pchsymbols.php
plot(property$Grade, property$Bath1, main="Scatterplot", xlab="X Axiz ", ylab="Y Axis", pch=19)

plot(housing.data$CurrentAcres)
plot(housing.data$TotalGrossArea)

barplot(grossarea)
barplot(grossarea[order(grossarea, decreasing = TRUE)])
plot(housing.data$Grade, col = rainbow(20), las=3)
# las=1) That represents the style of axis labels. (0=parallel, 1=all horizontal, 2=all perpendicular to axis, 3=all vertical)
hist(housing.data$CurrentValue)
currentvalue <- table(housing.data$CurrentValue)
hist(currentvalue, breaks = 20, las=3)
line(density(currentvalue))
summary(housing.data)


# scatter plot
plot(property$Grade, property$Bath1, main="Scatterplot", 
     xlab="X Axiz ", ylab="Y Axis", pch=19)

# bar plot, very simple
barplot(property$NumofBedrooms)

# historgram
hist(property$CurrentValue)

# pie chart
pie(property$Grade)

# alligator set with a linear regression in a data set
alligator <- data.frame(
  lnLength <- c(3.87, 3.61, 4.33, 3.43, 3.81, 3.83, 3.46, 3.76,
                3.50, 3.58, 4.19, 3.78, 3.71, 3.73, 3.78),
  lnWeight <- c(4.87, 3.93, 6.46, 3.33, 4.38, 4.70, 3.50, 4.50,
                3.58, 3.64, 5.90, 4.43, 4.38, 4.42, 4.25)
)

alli <- lm(lnWeight ~ lnLength, data = alligator)
summary(alli)

xyplot(resid(alli) ~ fitted(alli),
       xlab = "Fitted Values",
       ylab = "Residuals",
       main = "Residual Diagnostic Plot",
       panel = function(x, y, ...)
       {
         panel.grid(h = -1, v = -1)
         panel.abline(h = 0)
         panel.xyplot(x, y, ...)
       }
)

# install readr

# read a csv file into a data frame
read_csv("~/Desktop/R/ProperySalesPrice.csv")

# read a csv file into a vactor
read_lines("~/Desktop/R/ProperySalesPrice.csv")

# read a csv file into a single string
read_file("~/Desktop/R/ProperySalesPrice.csv")

install.packages("jsonlite")

install.packages("broom")

install.packages("tidytext")


