
# Decision Tree Demo with Titantic Data
# Packages needed
library(tidyverse)
library(readr)
library(dplyr)
library(party)
library(rpart)
library(rpart.plot)
library(ROCR)
library(caret)

# Import titanic dataset 
titanic3 <- "https://goo.gl/At238b" %>%
  read_csv %>% # read in the data
  select(survived, embarked, sex, 
         sibsp, parch, fare) %>%
  mutate(embarked = factor(embarked),
         sex = factor(sex))

View(titanic3)

titanic3$survived <- as.factor(titanic3$survived)

# splitting into training and testing data
set.seed(100) # random number
.data <- c("training", "test") %>%
  sample(nrow(titanic3), replace = T) %>%
  split(titanic3, .)

.data$training
.data$test

# Training the Decision Tree Classifier
# col name that we're looking for 
rtree_fit <- rpart(survived ~ ., .data$training) 
rpart.plot(rtree_fit)
prp(rtree_fit)

tree_fit <- ctree(survived ~ ., data = .data$training)
plot(tree_fit)
prp(rtree_fit)
# male have less chance to survive

# Predictions
rtree_fit.survived.predicated <- predict(rtree_fit, .data$test, type="class")

# Confusion Matrix for evaluating the model
confusionMatrix(rtree_fit.survived.predicated , .data$test$survived)

# tree_roc <- tree_fit %>%
#   predict(newdata = .data$test) %>%
#   prediction(.data$test$survived) %>%
#   performance("tpr", "fpr")

plot(rtree_fit.survived.predicated)


