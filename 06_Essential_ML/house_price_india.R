library(caret)
library(tidyverse)

df <- rbind(House_Price_India_2016, House_Price_India_2017)

glimpse(df)

colnames(df) <- c("id", "date", "no_of_bedrooms", "no_of_bathrooms", "living_area", "lot_area", "no_of_floors", "waterfront_present", "no_of_views", "house_condition", "house_grade", "house_area", "basement_area", "built_year", "renov_year", "postal_code", "lat", "long", "living_area_renov", "lot_area_renov", "no_of_schools", "distance_from_airport", "price")

# plot a simple histogram to see 'Price' distribution
# ถ้ากราฟเบ้ขวามาก ๆ ให้ใช้ log(Price)
ggplot(df, aes(log(price))) +
  geom_histogram(bins = 30) + 
  theme_minimal()

cor(df)

library(corrplot)
corrplot(cor(df))

# Function: split data
train_test_split <- function(data, trainRatio=0.8) {
  set.seed(42)
  (n <- nrow(data))
  id <- sample(1:n, size=trainRatio*n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return( list(train=train_data, test=test_data) )
}


# Function: evaluate model
mae_metric <- function(actual, prediction) {
  abs_error = abs(actual - prediction)
  mean(abs_error)
}

mse_metric <- function(actual, prediction) {
  sq_error = (actual - prediction)**2
  mean(sq_error)
}

rmse_metric <- function(actual, prediction) {
  sq_error = (actual - prediction)**2
  sqrt(mean(sq_error))
}

actual <- test_data$price
prediction <- price_pred



# use caret
# 1. split data
set.seed(42)
split_data <- train_test_split(df, 0.7)
train_data <- split_data$train
test_data <- split_data$test

# 2. train model
set.seed(42)

ctrl <- trainControl(method = "cv", number = 5, verboseIter = TRUE)

model <- train(log(price) ~ living_area + house_grade + house_area + living_area_renov ,
                     data = train_data,
                     method = "lm",
                     trControl = ctrl)

# 3. score model
p <- predict(model, newdata = test_data)

# 4. evaluate model
rmse_metric(test_data$price, exp(p))
rmse_metric(test_data$price, p)

rmse_metric(log(test_data$price), p)
mse_metric(log(test_data$price), p)
