# Load deck cards
deck <- read.csv("~/deck.csv", stringsAsFactors=FALSE)

#Create blackjack Deck
blackjack <- deck
facecard <- c("king","queen","jack")
blackjack$value [blackjack$face %in% facecard] <- 10
blackjack$value [blackjack$face == "ace"] <- NA

#Create Hearts Deck
hearts <- deck
hearts$value <- 0
hearts$value [hearts$suit == "hearts"] <- 1
hearts$value [hearts$suit == "spades" & hearts$face == "queen"] <- 13

# Shuffle out the deck
# shuffle a dataframe in R by rows
shuffle<- function(curr_deck){
  rows <- sample(nrow(curr_deck))
  curr_deck <- curr_deck[rows, ]
}

#Deal two players from hearts deck.

deal_hearts<- function() {
  playhearts<- shuffle(hearts)
  h_player1<- head(playhearts, 13)
  h_player2<- tail(playhearts, 13)
  print("----Hearts player1----")
  print(h_player1)
  print("----Hearts player2----")
  print(h_player2)
}


#Deal two players & dealer from blackjack deck.
deal_jacks<- function() {
  playjacks<- shuffle(blackjack)
  j_player1<- head(playjacks, 2)
  j_player2<- tail(playjacks, 2)
  dealer<- playjacks[c(10:11),1:3]
  print("----Blackjack player1----")
  print(j_player1)
  print("----Blackjack player2----")
  print(j_player2)
  print("----Blackjack dealer----")
  print(dealer)
}

print(deal_hearts())
print(deal_jacks())




