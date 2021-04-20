# Reading the data from the csv file and assign it to data variable.
data <- read.csv("/Users/ahmadbasha/Desktop/deck.csv")
# View the data
View(data)
# Print the structure of the data
str(data)


# declear the players vars
player1 <- 0
player2 <- 0
player3 <- 0

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
    player3 <<- head(deck , y)
    deck <<- deck[-c(1:y), ]
    print(c("Player One: ", player1[,2:4]))
    print(c("Player Two: ", player2[,2:4]))
    print(c("Player Three: ", player3[,2:4]))
  }
  else
  {
    print("*****There are no enough cards or you input more than the half of the cards *****")
  }
}

# calling deal and we choice 5 cards to deal for each player 
deal(7)



########## For Day 3 ##########

# this funcction to deal with two players and check for each one of them who has a larger value 
pointsForTwoPlayers <- function(playerX , playerY) {
  if(sum(playerX[ ,"value"]) > sum(playerY[ ,"value"])) 
  {
    sprintf("Player One has more points than Player Two . Player 1: %d, Player 2: %d" , sum(playerX[ ,"value"]) , sum(playerY[ ,"value"]))
  } else 
  {
    sprintf("Player Two has more points than Player One . Player 1: %d, Player 2: %d" , sum(playerX[ ,"value"]) , sum(playerY[ ,"value"]))
  }
}
# this funcction to deal with Three players and check for each one of them who has a larger value 
pointsForThreePlayers <- function(playerX , playerY , playerZ) {
  if((sum(playerX[ ,"value"]) > sum(playerY[ ,"value"])) & (sum(playerX[ ,"value"]) > sum(playerZ[ ,"value"]))) 
  {
    sprintf("Player One has more points than Others . Player 1: %d, Player 2: %d, Player 3: %d" , sum(playerX[ ,"value"]) , sum(playerY[ ,"value"]) , sum(playerZ[ ,"value"]))
  } else if ((sum(playerY[ ,"value"]) > sum(playerX[ ,"value"])) & (sum(playerY[ ,"value"]) > sum(playerZ[ ,"value"]))) 
  {
    sprintf("Player Two has more points than Others . Player 1: %d, Player 2: %d, Player 3: %d" , sum(playerX[ ,"value"]) , sum(playerY[ ,"value"]), sum(playerZ[ ,"value"]))
  }
  else {
    sprintf("Player Three has more points than Others . Player 1: %d, Player 2: %d, Player 3: %d" , sum(playerX[ ,"value"]) , sum(playerY[ ,"value"]), sum(playerZ[ ,"value"]))
  }
  
}


# this function will take the faces and knowing the similarity for each one of them 
# the faces will be taken from "face" function 
faceIteration <- function(faces) {
  count <- 1
  while (count <= length(faces) )
  {
    if ((faces[count] > 1) == TRUE)
    {
      print(c("has 2 of the same face",faces[count]))
    } else if ((faces[count] > 2) == TRUE) {
      print(c("has 3 or more of the same face",faces[count]))
    } 
    count = count + 1
  }
  
}


# this function is taking the player and put the faces with new vars Then call 
# faceIteration to see the number of faces for each value
face <- function (playerOne,playerTwo,playerThree) {
  #assign to table function for the faces for each one 
  FacingOne <- table(playerOne[,"face"])
  FacingTwo <- table(playerTwo[,"face"])
  FacingThree <- table(playerThree[,"face"])
  # passing values to faceIteration to know the similarity 
  print ("The first player")
  faceIteration( FacingOne)
  print ("The second player")
  faceIteration( FacingTwo)
  print ("The third player")
  faceIteration( FacingThree)

}

# this function will take the faces and knowing the similarity for each one of them 
faceIteration <- function(faces) {
  count <- 1
  while (count <= length(faces) )
  {
    if ((faces[count] > 1) == TRUE)
    {
      print(c("has 2 of the same face",faces[count]))
    } else if ((faces[count] > 2) == TRUE) {
      print(c("has 3 or more of the same face",faces[count]))
    } 
    count = count + 1
  }
  
}


# calling the methods to do the process 
pointsForTwoPlayers(player1,player2)
pointsForThreePlayers(player1,player2,player3)
# face method 
face(player1,player2,player3)

# uncomment this for testing purposes u can check all faces that the player have it 
#table(player1[,"face"])



