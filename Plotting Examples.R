library(ggplot2)
library(plyr)
library(datasets)

data("iris")

str(iris)

# qplot is a quick plotting visualization,  it has the following: qplot(x, y, data=, color=, shape=, size=, alpha=, geom=, method=, formula=, facets=, xlim=, ylim= xlab=, ylab=, main=, sub=)

# basic histogram
qplot(Sepal.Length, data=iris)


# Scatterplot 
qplot(Sepal.Width, Sepal.Length, data=iris)

# Scatterplot with color coding 
qplot(Sepal.Length, Sepal.Width, data=iris, color=Species)

# Scatterplot with a smoothing method for the geom The geom option is expressed as a character vector with one or more entries. geom values include "point", "smooth", "boxplot", "line", "histogram", "density", "bar", and "jitter".
qplot(Sepal.Width, Sepal.Length, data=iris)

# Scatter plot with a smoothing as well as as points
qplot(Sepal.Width, Sepal.Length, data=iris, geom=c("point","smooth"))

# Scatterplot with points and a linear regression and smoothing
qplot(Ozone, Wind, data=air, geom=c("point","smooth"), method="lm")

# Facets with rows facets = rows~columns wiht . returning one, historgram
qplot(Sepal.Width, Sepal.Length, data=iris, facets = Species~.)

# facets with columns
qplot(Sepal.Width, data=iris, binwidth=1)

# logrythimic representation of data
qplot(log(Sepal.Length), data=iris)

# log with density smoothing
qplot(log(Sepal.Length), data=iris, geom="density")

# log with color variable
qplot(log(Sepal.Length), log(Sepal.Width), color=Species, data=iris, geom=c("point","smooth"), method="lm")

# log with facets and color variable
qplot(log(Sepal.Length), log(Sepal.Width), facets=.~Species, data=iris, geom=c("point","smooth"), method="lm")

# ggplot functions http://docs.ggplot2.org/current/
# same as qplot(Ozone, Wind, data=air)
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_point() 

# Same as above with smoothing with method of linear regression, can be left blank
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_point() +
  geom_smooth(method="lm")

# Same as above with smoothing with method of linear regression broken out into month columns
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_grid(.~Species)

# Same as above with smoothing with method of linear regression broken out into month rows
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_grid(Species~.)

# Same as above with themes utilized
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_point() +
  geom_smooth(method="lm") +
  facet_grid(Species~.) +
  theme_minimal()

# Same as above with smoothing with method of linear regression and modified labels
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_point(aes(color=Species)) +
  geom_smooth(method="lm") +
  labs(x = "Ozone again and again")

# line plit with a y limit of 10, this cuts chuncks of data out that exceed that limit
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_line() +
  ylim(-10,10)

# line plit with a coordinate limit of 10, this keeps in the dat for ones that exceed
ggplot(iris, aes(Sepal.Width,Sepal.Length)) +
  geom_line() +
  coord_cartesian(ylim = c(-10,10))



