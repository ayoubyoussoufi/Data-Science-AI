library(ggplot2)
library(caTools)
library(caret)
library(dplyr)
library(explore)
library(randomForest)
library(fpc)
library(factoextra)

setwd("~/D:\Desktop\DataScienceMSc\ProcessDataR")
set.seed(20)


data <- read.csv("mtcars.csv")
data %>% explore_tbl()
data %>% describe()

data_rescale <- data %>% 
  mutate_if(is.numeric, funs(as.numeric(scale(.)))) 
head(data_rescale)


create_train_test <-
  function(data, size = 0.8, train = TRUE) {
    n_row = nrow(data)
    total_row = size * n_row
    train_sample <-
      1:total_row
    if (train == TRUE) {
      return (data[train_sample, ])
    } else {
      return (data[-train_sample, ])
    }
  }
data_train <- create_train_test(data, 0.8, train = TRUE)
data_test <- create_train_test(data, 0.8, train = FALSE)

#dim(data_train)

# Model training for linear regression 
model <- lm(mpg ~ disp, data = data_train)

# Model prediction
new_data <- dplyr::tibble(disp = data_test$disp)
data_test$output <- predict(model, new_data)

# RMSE
sqrt(sum(data_test$mpg - data_test$output) ** 2 / nrow(data_test))


data %>% 
  ggplot(aes(x = mpg, y = am)) +
  geom_point() + theme_bw() +
  xlab("Fuel Efficiency (Miles/Gallon)") +
  ylab("Vehicle Transmission Type (0 = Automatic, 1 = Manual)")
set.seed(10)
split_size <- 0.8
sample_size <- floor(split_size * nrow(mtcars))
train_indices <- sample(seq_len(nrow(mtcars)), size = sample_size)
# Splitting dataframe
train <- mtcars[train_indices, ]
test <- mtcars[-train_indices, ]

label_train <- train[, 9]
data_train_t <- train[, -9]

# Logistic regression
l_model <- LogitBoost(data_train_t, label_train)

# Prediction
pr <- predict(l_model, test, type = "raw")
l_prediction <-  data.frame(car_name = row.names(test), test$mpg, test$am, pr)
l_prediction
ConfusionMatrix(y_pred = pr, y_true = mtcars$mpg)

## Now unsupervised learning KMeans
## Fitt
clusters <- kmeans(data[,2:3], 5) # mpg , cyl # 5 Clusters
# Save the cluster number in the dataset as column 'targer'
data$target <- as.factor(clusters$cluster)
str(clusters)
# ls = aggregate(mtcars_df[,2:3],by=list(clusters$cluster),FUN=mean)
# append cluster assignment
# mydata <- data.frame(mydata, fit$cluste
plotcluster(data[,2:3], clusters$cluster ,pointsbyclvecd=FALSE)
#accuracy 
accuracy <- clusters$betweenss/clusters$totss

plot(formula =mpg ~ disp, data = train) + abline(v=15, col="blue")

ggplot(data = train) + geom_point(mapping = aes(x = mpg, y = disp)) + geom_smooth(mapping = aes(x = mpg, y = disp),method = 'glm')










