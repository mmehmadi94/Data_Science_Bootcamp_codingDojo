# Homework

# Using MatrixDS or R-Studio Cloud
# 1. Create a 10 sided dice and a 20 sided dice.
# 2. Create a function to roll 6 of these dice at a time and calculate the sum and
# 3. another function to calculate how many dice rolled more than 6 (for the 10 sided) or 16 (for the 20 sided).
# 4. Make sure to save all of your functions on a script called rolling.R
# 5. Upload your rolling.R script

##  a function to roll 6 of these dice at a time and calculate the sum
roll <- function(die1, die2, probability1, probability2){
  dice1 <- replicate(6,sample(die1,size = 1,replace=TRUE,prob=probability1))
  dice2 <- replicate(6,sample(die2,size = 1,replace=TRUE,prob=probability2))
  sum <-  sum(dice1,dice2)
  print(paste(c("sum of two dices (", dice1 ,") , (" ,dice2, "): is: ", sum), collapse=" "))

  countRolling(dice1,dice2)
  }

## function to calculate how many dice rolled more than 6 (for the 10 sided) or 16 (for the 20 sided)
countRolling <- function(dice1, dice2 ){
  countDice10 <- 0
  countDice20 <- 0

  for(i in 1:6) {
    ifelse(dice1[i] > 6 , countDice10 <- countDice10 + 1, 1)
    ifelse(dice2[i] > 16 ,countDice20 <- countDice20 + 1, 1)
  }

  print(paste(c("Dice 1 (",dice1,") rolled more than 6 (for the 10 sided): ", countDice10 , " times" ), collapse=" "))
  print(paste(c("Dice 2 (",dice2,") rolled more than 16 (for the 20 sided): ", countDice20 , " times" ), collapse=" "))
  }

# Calling roll function
# Create a 10 sided dice and a 20 sided dice.
die1 <-1:10
probability1 <- rep(c(1/10), times = 10)

die2 <- 1:20
probability2 <- rep(c(1/20), times = 20)

roll(die1,die2, probability1, probability2)


# Good Solution

# Create a 10 and 20 sided dice
#die10 <- 1:10
#die20 <- 1:20

# Create a function to roll 6 of these dice and calculate the sum
#roll6 <- function (die){
#  total <- 0
#  for(i in 1:6) {
#    dice<-sample(die, 1, replace=TRUE)
#    total = total + sum(dice)
#  }
#  print(total)
#}

# Create a function to calculate how many were > 6 or 16
#roll6_count <- function (die, sixer){
#  total <- 0
#  count <- 0
#  for(i in 1:6) {
#    dice<-sample(die, 1, replace=TRUE)
#    total = total + sum(dice)
#    if (dice > sixer) count=count+1
#  }
#  print(total)
#  print(count)
#}
#roll6_count(die10,6)
#roll6_count(die20,16)
