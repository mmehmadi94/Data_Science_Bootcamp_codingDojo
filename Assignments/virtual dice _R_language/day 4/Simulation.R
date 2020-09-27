# Rules of Black Jack Game #
# Player bets $1 , if player wins he gets his money back plus 1$ #
# if player loses he loses $1 #
# if a tie happens, player recovers his money #
# chance of player winning is 0.4222, chance of tie is 0.0848 #
# Chance of dealer winning is 0.493 #

# This Simulation for 10,000 Blackjack hands.
cashino_winnings <- vector("integer", 10000)
total_cashino_winnings <- vector("integer", 10000)


##  Comapre between cases of number of players below to determine which more profit for the cashino 
# 2 - dealer and a player
# 3 - dealer and 2 players
# 4 - dealer and 3 players
# 5 - dealer and 4 players

for (p in 2:5){
# one hand of play #
numplayers <- p
  for (i in 1:length(cashino_winnings)){
  
   onhand <- sample( c("D", "P", "T"), numplayers, prob = c(0.493, 0.4222,0.0848), replace = TRUE)
   
  # if the dealer wins, the cashino will get $1 of the player but if the player wins, the cahino will loss $1 as the player
  # will return his $1 and gain $1.
  # calculate the profit to the casino.
   cashino_winnings[i] <- length(onhand[onhand == "P"])* -1 + length(onhand[onhand == "D"])
  
    if(i != 1){
      total_cashino_winnings[i] <- total_cashino_winnings[i-1] + cashino_winnings[i]
    }else{
      total_cashino_winnings[i] <- cashino_winnings[i]
    }
  }

hist(cashino_winnings,  main= c("One deal winnings for ",p, "players") )
hist(total_cashino_winnings , main= c("Total Winnings for ",p, "players") )
}

#plot (total_cashino_winnings)
#plot(cashino_winnings)
# hist(total_cashino_winnings)
#hist(cashino_winnings)



