
# Simulate plot machine and calculate the expected profit to the casino of running this game

# Game Idae
# The machine will generate a combination of three symbols randomly
# If the correct combination appears, you can win a prize, maybe even the jackpot.

ACC_cashino_winning <- vector("integer", 10000)
cashino_winning <- 0 

################
# Function to randomly generate three symbols
# Symbols used are: diamonds (DD), sevens (7), triple bars (BBB), double bars (BB), single bars (B), cherries (C), and zeroes (0)
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE, 
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

################
# Score
# A player will win a prize if he gets:
# - Three of the same type of symbol (except for three zeroes)
# - Three bars (of mixed variety)
# - One or more cherries
# Otherwise, the player receives no prize.

# Diamonds (DD) are consider wild
# 1 D = prize that has been doubled 
# 2 D = prize that has been doubled twice
# 3 D (jackpot) = $800.

# function to calculate a prize based on those symbols
score <- function (symbols) {
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
               "B" = 10, "C" = 10, "0" = 0)
  # identify case
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3] # check if all symbols are the same 
  bars <- symbols %in% c("B", "BB", "BBB")
  
  # get prize
  if (same) {
    prize <- unname(payouts[symbols[1]]) 
  } else if (all(bars)) {
    prize <- 5
  } else {
    cherries <- sum(symbols == "C") # count how many cherries appears
    prize <- c(0, 2, 5)[cherries + 1]  # 1C = 0$ , 2C = 2$ , 3C = $5 
    }
  # adjust for diamonds
  diamonds <- sum(symbols == "DD") # count how many Diamond appears
  prize <-  prize * 2 ^ diamonds
}


################
# play function to run slot machine 
play <- function() {
  
 for(i in 1:length(ACC_cashino_winning)){
   
  # Each play of the slot machine costs $1 
  cashino_winning <- cashino_winning + 1
  
  # Generate symbols
  symbols <- get_symbols()
  
  # Display the symbols
  print(symbols)
  
  # Score the symbols
  prize <- score(symbols)
  
  # Print the score
  print(prize)
  
  # Recalucalte cashino winning
  cashino_winning <- cashino_winning - prize
  ACC_cashino_winning [i] <- cashino_winning
 }
  cat(" Total cashino winning after 10000 play is $", cashino_winning)
  plot(ACC_cashino_winning)
}


#############################
print("This simulation for 10000 play in plot machine")
play()

