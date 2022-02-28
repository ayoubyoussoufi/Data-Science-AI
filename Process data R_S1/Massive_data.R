install.packages("dplyr")
library(dplyr)
library(dslabs)
chicago <- read.csv("chicago.csv")
# Ex1) Random vector
## 1) Generate vector of 100 variables
v100 <- rnorm(100)
v100
length(v100)
## 2) Calculate its mean
mean(v100)
sumOf <- 0
# Print loop
for (value in v100) {
  sumOf= value + sumOf
}
meanOfv100 = sumOf/length(v100)
print(meanOfv100)
#3) Varience
cmSum <- 0
# Print loop
for (value in v100) {
  cmSum=cmSum + (value - meanOfv100)^2
}
print(cmSum/100-1)
#Ex 2)
# Use the airquality dataset from base
# Ex 3)
#1- Compute the mean of all columns of iris dataset
# View(iris)
data("iris")
iris.numeric <- iris[,c(1:4)]
colMeans(iris.numeric)
for (i in 1:4) {
  print(mean(iris[0,i]))
}
normalize <- function(numbers)
{    (numbers - mean(numbers))/sd(numbers)
}
new.iris <- apply(iris.numeric, 2, normalize)
apply(new.iris, 2, mean)
apply(new.iris, 2, sd)
# Compute their standard deviation