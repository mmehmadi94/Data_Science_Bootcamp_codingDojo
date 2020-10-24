# You have been Hired by Napa Wine inc. to help build a decision model. Mr. Johnson the winemaker at Napa 
# Wine believes that a storm is coming and he needs to decide whether or not to harvest the grapes
# today or wait until after the storm.



library(rpart)
library(rpart.plot)

data <- data.frame(condition = c("harvest", "not harvest"),
                   weather = c("sun","storm"),
                   earn = c(8000,0))

tree <- rpart(earn ~ ., data)

test1 <- data.frame(condition = "harvest", weather= "storm")  # earn 4000
test2 <- data.frame(condition = "not harvest", weather= "sun")

print(tree.earn.predicated <- predict(tree, test1 ))
