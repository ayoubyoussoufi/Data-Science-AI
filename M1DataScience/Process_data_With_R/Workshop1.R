
#1 a Create a vector from 1 to 10 with 0.5
vect <- seq(1,10, by=0.5)
vect
#1 b define function fahrenheit_to_celsius()
fahrenheit_to_celsius <- function(x){
  c= (x-32)*5/9
  return(c)
}
fahrenheit_to_celsius(32)

#1 c from vector v create a sample,t, of size 100 

t<- sample(vect, size=100, replace=TRUE, prob = runif(length(vect)))
t

# Which number occurs the most

summary (as.factor(t)) #Numbers 1 and 5 occur most

graph <- hist(t,main="Sampling with replacements")
graph

#1 d Create a 7×8 matrix filled by row of Gaussian random numbers
gaussian <- rnorm(56,1,2)
gaussian
m <- matrix(gaussian,nrow = 7,ncol = 8)
m
# add 1 to elements lower than mean 
for (i in 1:nrow(m)){
  for (j in 1: ncol(m)){
    if (m[i,j]<1){
      m[i,j]=m[i,j]+1
    }
  }
}
print(m)

#1 e Using the iris datasets make a boxplot of the variables in the dataset
#View(iris)

boxplot(iris[1:4])

# Make a matrix of scatterplots of the previous variables
my_cols <- c("#00AFBB", "#E7B800", "#FC4E07")  
pairs(iris[,1:4], pch = 19,  cex = 0.5,
      col = my_cols[iris$Species],
      lower.panel=NULL) #color and form of the points depend on the species

#1 f Plot with different colors the estimated density functions 
f1 <- rgamma(1000,1)
f2 <- rgamma(1000,2)
f3 <- rgamma(1000,3)
f4 <- rgamma(1000,4)
plot(density(f1),col='Red',main = "Density funciton of random gamma")
lines(density(f2),col='Blue')
lines(density(f3),col='Black')
lines(density(f4),col='Green')

#Exercise 2 
library(dplyr)
library(nycflights13)
#View(flights)
#2 a Create a new data frame that contains only the flights on 8 April 2013

flights_new <- filter(flights,month=='4' & day=='8')
View(flights_new)
#2a Find the flight with the lowest departure delay
summary(flights_new$dep_delay)
lowest<-filter(flights_new,dep_delay==-21)
#2b How many flights were delayed by more than four hours
countdep_delay <- filter(flights_new,dep_delay>4)
nrow(countdep_delay)
countarr_delay <- filter(flights_new,arr_delay>4)
nrow(countarr_delay)
#2b New dataframe with the dep_delay variable for the flights with the highest departure delay for each month
flights_data <- na.omit(flights)
flights_data
flights_data %>%
group_by(month) %>%
summarise(dep_delay = max(dep_delay)) 

lax_data <- filter(flights,dest=='LAX')
lax_sort <- lax_data[order(lax_data$dep_delay),]

#Then compute the column mean.

lax_sort %>% summarise_if(is.numeric, mean)

#3a) Create a dataframe of 100 people with 3 columns
N <- 100
age <- runif(N,20,40)
weight <- round(runif(N,50,90),digits = 1)
graduate <- sample(x = c("Yes","NO"),prob = c(.6,.4),size = N,replace = TRUE)
df <- data.frame(age,weight,graduate)

#3c) Insert 5 missing values in each column at random locations, with a for loop

for (i in seq_along(df)) {
  df[sample(1:10,5),i] <- NA
}
#3d) Change column name "Graduated" to "Driving_License". 

colnames(df)[length(df)] <- "Driving_License"


#Count the number of missing values in the dataframe. Now remove them.
count_vect_df <- function(x){
  sum(length(which(is.na(x))))
  
}
na_count<- sapply(df, count_vect_df)
na_count

#remove NA

df_new <- na.omit(df)
df_new


#3e) Make a Min-Max Normalization: (X - min(X)) / (max(X) - min(X)) of the first 2 columns

norm_vect_df <- function(x){
  return (x-min(x))/(max(x)-min(x))
}

df_norm1 <- as.data.frame(norm_vect_df(df_new[1:2]))
df_norm1

zscore_vect_df <- function(x){
  return (x-mean(x))/(sd(x))
}


#3f) Make a a z-score standardization: (X - ??) / ?? of the first two columns

df_norm2 <- apply(df_new[1:2], 1, zscore_vect_df)
df_norm2




