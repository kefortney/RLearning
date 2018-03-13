# Script used to illustrate some methods to process time series data
# Presented at Burlington Data Science Meetup

# > today()
# [1] "2017-05-17"

# Greg Fanslow
# Blue Tree Analytics

# c - (802) 999-4944
# e - greg@bluetreeanalytics.com

# Get in touch if you have any questions or comments

## Install packages you'll need ####

# install.packages("lubridate", "plyr", "ggplot2", "reshape2", "zoo", "forecast", "xts", "dygraphs")

require(lubridate)
# like pandas
require(plyr)
# functions for time series
require(zoo)
# functions for fitting time series models and forecasting
require(forecast)
# plotting tools
require(ggplot2)
#change data from wide to long format
require(reshape2)
# time series package to send to diagraph with sliders
require(xts)
# Visualization with intereactive sliders
require(dygraphs)


# Loading the data ####
# and having a look at it...

load("C:/Users/kefor/Desktop/RLearning/temperatureData.RData")

# properties of the list...
class(airportList)
length(airportList)
names(airportList)

# Properties of its elements...
df <- airportList[["locB"]]

class(df)
head(df)
tail(df)
str(df)

dim(df)
length(df) # Think of a dataframe as a list of vectors with each one the same length!

# applying functions to the list...
?lapply

lapply(airportList, function(x) str(x))
lapply(airportList, dim)


## Function to do a bunch of things ####
# using lapply

name <- names(airportList)[1]

hourlyTempFUN <- function(name){
  
  df <- airportList[[name]]
  
  df$DateEST <- lubridate::ymd_hms(df$DateUTC - hours(5), tz = "EST")
  
  df$hour <- cut(df$DateEST, breaks = "hour")
  df$TemperatureF[df$TemperatureF == -9999.00] <- NA
  
  # To challenge the interpolation process...
  # randomly drop 100 rows of raw data from each set of raw data
  delete <- -50:50 + round(runif(1, 3000, 5000),0)
  df <- df[-delete,]
  
  # Aggregating to even hours
  hourlyTemps <- plyr::ddply(df, .(hour), .fun = function(x) c(tempF = mean(x$TemperatureF, na.rm = TRUE)))
  hourlyTemps$hour <- ymd_hms(hourlyTemps$hour)
  
  # identifying and replacing outliers
  hourlyTemps$tempF[6000] <- -10 # adding an outlier for fun
  
  outliers <- forecast::tsoutliers(hourlyTemps$tempF)
  # 
  # plot(hourlyTemps$tempF, type = "l")
  # points(outliers$replacements ~ outliers$index, pch = 19, col = "red")
  
  hourlyTemps$tempF[outliers$index] <- outliers$replacements
  
  # merging to a complete index so we can interpolate for missing hours
  
  idx <- data.frame(hour = seq(from = min(ymd_hms(hourlyTemps$hour)), to = max(ymd_hms(hourlyTemps$hour)), by = "hour"))
  
  hourlyTemps <- merge(idx, hourlyTemps, by = "hour", all.x = TRUE)
  
  hourlyTemps$interp <- zoo::na.spline(hourlyTemps$tempF, maxgap = 500)
  
  return(hourlyTemps)
  
}


# This is why you shouldn't use Excel for this kind of data...

ptm <- proc.time()
temperatureList <- lapply(names(airportList), hourlyTempFUN)
proc.time() - ptm

names(temperatureList) <- names(airportList)

lapply(temperatureList, function(x) summary(x))

df <- data.frame(Date = temperatureList[[1]]$hour,
                 locA = temperatureList[[1]]$interp, 
                 locB = temperatureList[[2]]$interp, 
                 locC = temperatureList[[3]]$interp, 
                 locD = temperatureList[[4]]$interp)

## Melting and Plotting in ggplot ####

meltDf <- reshape::melt.data.frame(data = df, id.vars = "Date", 
                                   variable_name = "Location")

ggplot(meltDf, aes(x = Date, y = value, color = Location)) + geom_line(alpha = 0.4)

## Revealing some short comings in the na interpolation ####

pairs(df[,-1], cex = 0.3)

plot(locC ~ locA, data = df, cex = 0.4)

which(df$locA > 100)

interestingArea <- -100:100 + 3249

plot(locC ~ locA, data = df[interestingArea,], cex = 0.4)

plot(locC ~ locA, data = df[interestingArea,], cex = 0.4, type = "l")

# diffDf <- as.data.frame(apply(df[,-1], 2, function(x) diff(x)))
# 
# plot(locA ~ locC, data = diffDf[interestingArea,], cex = 0.4, type = "l")

interestingMelt <- reshape::melt.data.frame(data = df[interestingArea,], id.vars = "Date", 
                                            variable_name = "Location")

ggplot(interestingMelt, aes(x = Date, y = value, color = Location)) + geom_line(alpha = 0.4)

temperatureList[["locA"]][interestingArea,]

## Interpolating using median of other sites ####

dfRaw <- data.frame(Date = temperatureList[[1]]$hour,
                    locA = temperatureList[[1]]$tempF, 
                    locB = temperatureList[[2]]$tempF, 
                    locC = temperatureList[[3]]$tempF, 
                    locD = temperatureList[[4]]$tempF)

summary(dfRaw)

medians <- apply(dfRaw[,-1], 1, function(x) median(x, na.rm = TRUE))

dfInterp2 <- list()

for (i in 1:4){
  tmp <- dfRaw[,i+1] # add 1 b/c to skip data column
  gaps <- which(is.na(tmp))
  tmp[gaps] <- medians[gaps]
  dfInterp2[[i]] <- tmp
}

dfInterp2 <- as.data.frame(do.call("cbind", dfInterp2))

# Adding back the date column...
dfInterp2 <- data.frame(dfRaw[,1], dfInterp2)

names(dfInterp2) <- names(dfRaw)

summary(dfInterp2)

## Comparing Some Interpolation Methods ####

plot(dfInterp2[interestingArea, 2], type = "l", col = "red", lwd = 2, lty = 3, ylab = "Temperature (F)", main = "Location A\n (deletion area)")
lines(na.approx(temperatureList[[1]]$tempF[interestingArea]), lwd = 2, col = "blue", lty = 2)
lines(na.spline(temperatureList[[1]]$tempF[interestingArea]), lwd = 2, col = "purple", lty = 2)
lines(temperatureList[[1]]$tempF[interestingArea], lwd = 2)


## Comparing using Dygraph

loc <- "locA"

tempXTS <- xts(cbind(na.spline(temperatureList[[loc]]$tempF),
                     dfInterp2[, loc], 
                     temperatureList[[loc]]$tempF),
               order.by = temperatureList[[loc]]$hour)

names(tempXTS) <- c("naSpline", "medInterp", "rawTemp")
head(tempXTS)

dygraph(tempXTS) %>% 
  dyRangeSelector() %>%
  dyOptions(colors = c("red", "blue", "black"))
