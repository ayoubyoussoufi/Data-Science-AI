library(dplyr)
library(dslabs)

# Ex1) Random vector
## 1) Generate vector of 100 variables
vect <- rnorm(100)
vect
length(vect)
## 2) Calculate its mean
mean(vect)
sumOf <- 0
# Print loop
for (i in vect) {
  sumOf= i + sumOf
}
meanOfvect = sumOf/length(vect)
meanOfvect
#3)Varience
cmSum <- 0
# Print loop
for (j in vect) {
  cmSum=cmSum + (j - meanOfvect)^2
}
cmSum/100-1
#2b missing values:
#1
View(airquality)
#2
apply(airquality, 2, function(col)sum(is.na(col))/length(col))
#3
airquality[,which(colMeans(!is.na(airquality)) > 0.5)]
#4
airquality_new <- data.frame(sapply(airquality,function(x) ifelse(is.na(x)<0.5 ,mean(x, na.rm = TRUE),x)))
airquality_new
#Exercise 3
#1 Compute the mean of all columns of iris dataset
# View(iris)

apply(iris[1:4], 2, mean)

#2 Compute their standard deviation
apply(iris[1:4], 2, sd)