#Lama Alzahrani
#Ruba Alkhattabi
#Reema Alotaibi
#Ahmed Altowairqi


library(plyr)
# Cost for adults and children
ticket_cost <- 20
ticket_cost_child <- 10 
movies <- c('The Lion King', 'Mad Max', 'The Lord Of The Ring', 'Star Wars', 'Toy Story')  # List 5 of your favorite movies
screens <- 5 # How many screens does the theater have? (assume 1 per movie)
seats <-  100 # How many seats does each theater hold
week_days <- rep(0, 7)  # Store totals for each day
currentTotal <-0
total<- 0
total_snack<-0
total_snacksChildren<-0
total_snacksAdults<-0

#creat data frame for snacks.
snack<-data.frame(
  snack_names = c("popcorn", "coke", "candy", "pepsi", "nachos"),
  snack_price = c(20,15,10,15,35) )

#creat data frame for movies.
movies<-data.frame(
  movie_names = c('The Lion King', 'Mad Max', 'The Lord Of The Ring', 'Star Wars', 'Toy Story'),
  #movie_con = c('PG','R','PG','PG13','G') )
  movie_con = c(0,1,0,0,0) )  #0=allowed, 1=not allowed.


# Iterate through the week
for (i in week_days) { 
  # Iterate through the amount of screens on a particular day
  for (j in 1:screens) {
    
    # Calculate how many adults and children are watching the movie
    visitors_adults <- sample(seats, 1)
    
    # Iterate through the conditional of movies on a particular day
    for (k in 1:length(movies$movie_con)) {
      # Creat if-else statement to the movies conditional.
      if(movies$movie_con == 1){  
        paste("Sorry, PG-13 and children are not allowed to watch this movie.")
        visitors_children<-0
      } else {
        visitors_children <- sample(abs(visitors_adults-seats),1) 
      } 
    }
    
    # Calculate how many adults and children buy snank
    snacksChildren <- sample(snack[,1], visitors_children , replace = TRUE)
    snacksAdults<- sample(snack[,1], visitors_adults , replace = TRUE)
    
    # Calclate freq of snakcs price
    count_snacksChildren<-count(snacksChildren)
    count_snacksAdults<-count(snacksAdults)
    
    # Calclate revenue of snakcs price
    sum_snacksChildren<-sum(count_snacksChildren$freq*snack$snack_price)
    sum_snacksAdults<-sum(count_snacksAdults$freq*snack$snack_price)
    
    # Calculate the revenue for adults and children for a day and screen 
    currentTotal <- currentTotal + visitors_adults*20 + visitors_children*10 + sum_snacksChildren + sum_snacksAdults
  }
  # Calculate revenue for the dat 
  print(currentTotal) 
  # For the total of days,total snacks for children and adults,total sncks, Save total to the corresponding day
  total <<- c(total , currentTotal)
  total_snacksChildren<-c(total_snacksChildren,sum_snacksChildren)
  total_snacksAdults<-c(total_snacksAdults,sum_snacksAdults)
  total_snack <<- c(total_snack , sum_snacksChildren + sum_snacksAdults )
  currentTotal <-0
}

# adding day names for each one:
total <- total[-1]
names(total) <- c("Monday", "Tuesday", "Wednesday", "Thursday","Friday", "Saturday" , "sunday")

total_snack <- total_snack[-1]
names(total_snack) <- c("Monday", "Tuesday", "Wednesday", "Thursday","Friday", "Saturday" , "sunday")

# total_snack_plot<-data.frame(total_snack)

total_snacksChildren <- total_snacksChildren[-1]
names(total_snacksChildren) <- c("Monday", "Tuesday", "Wednesday", "Thursday","Friday", "Saturday" , "sunday")

total_snacksAdults <- total_snacksAdults[-1]
names(total_snacksAdults) <- c("Monday", "Tuesday", "Wednesday", "Thursday","Friday", "Saturday" , "sunday")
# convert to dataframe to handle it easier.
total_snack_AC<-data.frame(total_snacksChildren,total_snacksAdults)


#               ***************   Updates Messages   ***************

# The hieghst revenue on which day 
paste("The highest revenue is" , max(total), "$ on" , names(which.max(total)),'.')
# The total tickets revenue
paste("The tickets revenue for the week is",sum(total-total_snack),'$.')
# The total week revenue for the snacks
paste("The total week revenue for the snacks is", sum(total_snack),'$.')
# The min and max snacks on which day
paste('The min snacks revenue is', min(total_snack), '$ on', names(which.min(total_snack)),', and the max sncks revenue is',max(total_snack),'$ on',names(which.max(total_snack)),'.')
# The total revenue of the week
paste("The total revenue of this week is", sum(total,total_snack),"$.")

#               ***************   Plots   ***************

# Make a barchart showing total revenue per day
barplot(
  total,
  main = "Total Revenue Per Day",
  xlab = "Days",
  ylab = "Revenue",
  legend = rownames(title),
  col = c("papayawhip",'peachpuff','peachpuff1','peachpuff2','peachpuff3','peachpuff4','mistyrose4')
)

# Make any other chart
plot(total, xaxt="n", type="b", col="salmon2",  main = 'Total Revenue Per Day',xlab = "Days",
     ylab = "Revenue")
# 1 means x-axis , 1:7 the varable want to chanege 
axis(1,at = 1:7, labels = names(total))


# Plot for snacks
boxplot(total_snack_AC,names=c("Total Snacks for Children","Total Snacks for Adults"),
        ylab = "Total Amount", main = "Total Snacks for Adults and Children")



