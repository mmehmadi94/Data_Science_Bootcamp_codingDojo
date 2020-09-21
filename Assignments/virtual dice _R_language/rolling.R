#Create a function to roll 6 of these dice at a time and calculate the sum
roll <- function(die1, die2, probability1, probability2){
  dice1 <- replicate(6,sample(die1,size = 1,replace=TRUE,prob=probability1))
  dice2 <- replicate(6,sample(die2,size = 1,replace=TRUE,prob=probability2))
  sum <-  sum(dice1,dice2)
  print(paste(c("sum of two dices (", dice1 ,") , (" ,dice2, "): is: ", sum), collapse=" "))
  
  countRolling(dice1,dice2)
  }

# calculate how many dice rolled more than 6 (for the 10 sided) or 16 (for the 20 sided)
countRolling <- function(dice1, dice2 ){
  countDice1 <- 0
  countDice2 <- 0
  
  for(i in 1:6) {
    ifelse(dice1[i] > 6 , countDice1 <- countDice1 + 1, 1)
    ifelse(dice2[i] > 16 ,countDice2 <- countDice2 + 1, 1)
  }
  
  print(paste(c("Dice 1 (",dice1,") rolled more than 6 (for the 10 sided): ", countDice1 , " times" ), collapse=" "))
  print(paste(c("Dice 2 (",dice2,") rolled more than 16 (for the 20 sided): ", countDice2 , " times" ), collapse=" "))
  }

# Calling roll function
# Create a 10 sided dice and a 20 sided dice.
die1 <-1:10
probability1 <- rep(c(1/10), times = 10)

die2 <- 1:20
probability2 <- rep(c(1/20), times = 20)

roll(die1,die2, probability1, probability2)


