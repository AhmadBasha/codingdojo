#Lama Alzahrani
#Ruba Alkhattabi
#Reema Alotaibi
#Ahmed Altowairqi

# Potential Questions to Answer:
# 1. Create snacks that the customers can buy and randomize who buys which snack
# 2. Pretend you own multiple theaters and run two simulations to represent each theater and plot the results
# 3. Create conditional statements for movies that may be PG-13 and children are not allowed to watch
# Cost for adults and children
ticket_cost <- 20
ticket_cost_child <- 10 
movies <- c('The Lion King', 'The Dark Knight', 'The Lord Of The Ring', 'Star Wars', 'Toy Story')  # List 5 of your favorite movies
screens <- 3 # How many screens does the theater have? (assume 1 per movie)
seats <-  100# How many seats does each theater hold
week_days <- rep(0, 7)  # Store totals for each day
currentTotal <-0
total<- 0
snack <- c("popcorn", "coke", "candy", "pepsi", "nachos")


# iterate through the week
for (i in week_days) { 
  # iterate through the amount of screens on a particular day
  for (j in 1:screens) {
    # Calculate  how many adults and children are watching the movie
    visitors_adults <- sample(seats, 1)
    visitors_children <- sample(abs(visitors_adults-seats),1)
    
    # Calculate the revenue for adults and children for a day and screen 
    currentTotal <- currentTotal + visitors_adults*20 + visitors_children*10
  }
  # Calculate revenue for the dat 
    print(currentTotal) 
    # for the total of days , Save total to the corresponding day
    total <<- c(total , currentTotal)
    currentTotal <-0

  
}


total <- total[-1]
names(total) <- c("M", "T", "W", "Th","Fr", "Sa" , "su")



# Make a barchart showing total revenue per day
barplot(
  total,
  main = "Title",
  xlab = " days",
  ylab = "revenue",
  legend = rownames(title),
  col = c("red")
)

# Make any other chart
plot(total, type="o", col="blue")
# The hieghst day
paste("The highest revenue is" , max(total), "on" , names(which.max(total)))

###################
###################
###################
snacksChildren <- sample(snack, visitors_children , replace = TRUE)
snacksAdults<- sample(snack, visitors_adults , replace = TRUE)


table(snacksChildren)
table(snacksAdults)







