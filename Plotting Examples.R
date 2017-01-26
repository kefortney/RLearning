# Ozone Solar.R Wind Temp Month Day
air <- airquality

# qplot is a quick plotting visualization,  it has the following: qplot(x, y, data=, color=, shape=, size=, alpha=, geom=, method=, formula=, facets=, xlim=, ylim= xlab=, ylab=, main=, sub=)

# basic histogram
qplot(Ozone, data=air)

# Scatterplot 
qplot(Ozone, Wind, data=air)

# Scatterplot with color coding 
qplot(Ozone, Wind, data=air, color=Temp)

# Scatterplot with a smoothing method for the geom The geom option is expressed as a character vector with one or more entries. geom values include "point", "smooth", "boxplot", "line", "histogram", "density", "bar", and "jitter".
qplot(Ozone, Wind, data=air, geom="smooth")

# Scatter plot with a smoothing as well as as points
qplot(Ozone, Wind, data=air, geom=c("point","smooth"))

# Scatterplot with points and a linear regression and smoothing
qplot(Ozone, Wind, data=air, geom=c("point","smooth"), method="lm")

# Facets with rows facets = rows~columns wiht . returning one, historgram
qplot(Ozone, Temp, data=air, facets = Month~., binwidth=2)

# facets with columns
qplot(Wind, data=air, facets =.~Month, binwidth=1)

# logrythimic representation of data
qplot(log(Wind), data=air)

# log with density smoothing
qplot(log(Wind), data=air, geom="density")

# log with color variable
qplot(log(Ozone), log(Wind), color=Month, data=air, geom=c("point","smooth"), method="lm")

# log with facets and color variable
qplot(log(Ozone), log(Wind), facets=.~Month, data=air, geom=c("point","smooth"), method="lm")

# ggplot functions http://docs.ggplot2.org/current/
# same as qplot(Ozone, Wind, data=air)
ggplot(air, aes(Ozone,Wind)) +
  geom_point() 

# Same as above with smoothing with method of linear regression, can be left blank
ggplot(air, aes(Ozone,Wind)) +
  geom_point() +
  geom_smooth(method="lm")

# Same as above with smoothing with method of linear regression broken out into month columns
ggplot(air, aes(Ozone,Wind)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_grid(.~Month)

# Same as above with smoothing with method of linear regression broken out into month rows
ggplot(air, aes(Ozone,Wind)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_grid(Month~.)

# Same as above with themes utilized
ggplot(air, aes(Ozone,Wind)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_grid(Month~.) +
  theme_minimal()

# Same as above with smoothing with method of linear regression and modified labels
ggplot(air, aes(Ozone,Wind)) +
  geom_point(aes(color=Month)) +
  geom_smooth(method="lm") +
  labs(x = "Ozone again and again")

# line plit with a y limit of 10, this cuts chuncks of data out that exceed that limit
ggplot(air, aes(Ozone,Wind)) +
  geom_line() +
  ylim(-10,10)

# line plit with a coordinate limit of 10, this keeps in the dat for ones that exceed
ggplot(air, aes(Ozone,Wind)) +
  geom_line() +
  coord_cartesian(ylim = c(-10,10))



