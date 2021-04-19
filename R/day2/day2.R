# Reading the data from the csv file and assign it to data variable.
data <- read.csv("/Users/ahmadbasha/Desktop/deck.csv")
# View the data
View(data)
# Print the structure of the data
str(data)


# declear the players vars
player1 <- 0
player2 <- 0

# shuffle function to take the data and start doing a random order by shffling variable 
shuffle <-function(x){
  shuffling <- sample(1:52, size = 52 , replace = FALSE)
  x[shuffling,]
}

# here to assigned the random ot the shffling cards to deck
deck <- shuffle(data)

# this function check the deck which has been shuffled and check the number of cards
# if it equlas to 5 or more it will do the condition , otherwise it will print
# it will give the first 5 card to player1 and the second 5 cards to player 2 
# for y is just for the number of cards that each player can take and it will check 
# if the deck bigger than y and the half of it is bigger or not 
deal <- function(y) {
  if ((nrow(deck) >= y) & (y<=(nrow(deck)/2)))
  {
    player1 <<- head(deck , y)
    deck <<- deck[-c(1:y), ]
    player2 <<- head(deck , y)
    deck <<- deck[-c(1:y), ]
    print(c("Player One: ", player1[,2:4]))
    print(c("Player Two: ", player2[,2:4]))
  }
  else
  {
    print("*****There are no enough cards or you input more than the half of the cards *****")
  }
}

# calling deal and we choice 5 cards to deal for each player 
deal(5)










