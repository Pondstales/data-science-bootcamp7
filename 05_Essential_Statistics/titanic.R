## Homework: titanic_train
library(titanic)
library(dplyr)

data(titanic_train)
head(titanic_train)

## DROP NA (missing values)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)


## Change some columns to factors, especially "Survived"
str(titanic_train)

titanic_train$Survived <- as.factor(titanic_train$Survived)
titanic_train$Pclass <- as.factor(titanic_train$Pclass)
titanic_train$Sex <- as.factor(titanic_train$Sex)
titanic_train$Embarked <- as.factor(titanic_train$Embarked)

## SPLIT DATA
set.seed(42)
n <- nrow(titanic_train)
id <- sample(1:n, size=n*0.7) ## 70% train 30% test
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

nrow(train_data)
nrow(test_data)

## Train Model
model <- glm(Survived ~ Pclass + Age + SibSp + Parch, data = train_data, family="binomial")
summary(model)
p_train <- predict(model, type = "response")
train_data$pred <- if_else(p_train >= 0.5, 1, 0)

mean(train_data$Survived == train_data$pred)

## Test Model
p_test <- predict(model, newdata = test_data, type = "response")
test_data$pred <- if_else(p_test >= 0.5, 1, 0)

mean(test_data$Survived == test_data$pred)


## Confusion Matrix
conM <- table(test_data$pred, test_data$Survived, 
              dnn = c("Predicted", "Actual"))

conM

cat("Accuracy:", (conM[1,1] + conM[2,2]) / sum(conM), "\n")
cat("Precision:", conM[2,2] / (conM[2,1] + conM[2,2]), "\n")
cat("Recall:", conM[2,2] / (conM[1,2] + conM[2,2]), "\n")
