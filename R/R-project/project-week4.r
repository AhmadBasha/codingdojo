

ticket_cost <- 20
ticket_cost_child <- 10 
movies <- c('The Lion King', 'The Dark Knight', 'The Lord Of The Ring', 'Star Wars', 'Toy Story')  # List 5 of your favorite movies
screens <- 3 # How many screens does the theater have? (assume 1 per movie)
seats <-  100# How many seats does each theater hold
week_days <- rep(0, 7)  # Store totals for each day
currentTotal <-0
total<- 0


# iterate through the week
for (i in week_days) { 
  for (j in 1:screens) {
    visitors_adults <- sample(seats, 1)
    visitors_children <- sample(abs(visitors_adults-seats),1)
   # print(c("adult %d", visitors_adults*20))
   # print(c("children %d", visitors_children*20))
    currentTotal <- currentTotal + visitors_adults*20 + visitors_children*10
  }
    print(currentTotal) 
    total <<- c(total , currentTotal)
    currentTotal <-0

  
}


total <- total[-1]
names(total) <- c("M", "T", "W", "Th","Fr", "Sa" , "su")


typeof(total)


barplot(
  total,
  main = "Title",
  xlab = " days",
  ylab = "revenue",
  legend = rownames(title),
  col = c("red"),
  #horiz = TRUE,
  #args.legend = list(x= "bottomleft")
  # Change the placement of your legend by using:
  # “bottomright”, “bottom”, “bottomleft”, “left”, “topleft”, “top”, 
  # “topright”, “right”, “center”
)

# the point shape 
plot(total, type="o", col="blue")

max(total)