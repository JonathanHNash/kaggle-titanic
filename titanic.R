
# jonathan nash kaggle
# classification on titanic dataset

library(randomForest)
library(dplyr)

train <- read.csv("train.csv")
test <- read.csv("test.csv")

orig.train <- train
orig.test <- test

# impute age
train$Age[is.na(train$Age)] <- mean(train$Age, na.rm = T)

# random forest
rf <- randomForest(x = train[,c(3,5,6,7,10)], 
                   y = as.factor(train$Survived), 
                   importance = TRUE, 
                   ntree = 1000)

# impute age test
test$Age[is.na(test$Age)] <- mean(test$Age, na.rm = T)
test$Fare[is.na(test$Fare)] <- mean(test$Fare, na.rm = T)

# fix types
test <- rbind(train[1,-2] , test)
test <- test[-1,]
rownames(test) <- NULL

# prediction
rf.pred <- predict(rf, test[,c(2,4,5,6,9)])
results <- data.frame(test[,c(1,2,4,5,6,9)], 
                      Survived = rf.pred)


# output
submit <- results[,c("PassengerId","Survived")]
write.csv(submit, file = "predictions_jhsn.csv", row.names = F)













