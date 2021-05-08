# excel dataset foremat
library(readxl)
# to use a copy function for the data
library(data.table)
#using shiny
library(shiny)
# use ggplot for test purposes 
library(tidyverse)


# read data from excel file 
my_data <- read_excel("/Users/ahmadbasha/Desktop/Internship/SL/Attribute\ DataSet.xlsx")
# check the data
View(my_data)
str(my_data)
# make a copy of the data 
my_data2 <- copy(my_data)
# change rating ,recomendation and others to factors .Also, price should be categorical var here
my_data2$Recommendation <- as.factor(my_data2$Recommendation)
my_data2$Rating <- as.factor(my_data2$Rating)
my_data2$Size <- as.factor(my_data2$Size)
my_data2$Price <- as.factor(my_data2$Price)
my_data2$Season <- as.factor(my_data2$Season)
#here we have Low and low in price so change one of them to another because it's a typo
# also high and High as well
summary(my_data2$Price)
my_data2$Price[my_data2$Price == "Low" ] <- "low"
my_data2$Price[my_data2$Price == "High" ] <- "high"
summary(my_data2$Rating)
# Also with the size and season 
my_data2$Size[(my_data2$Size == "small") | (my_data2$Size == "s")] <- "S"
my_data2$Season[(my_data2$Season == "summer") ] <- "Summer"
my_data2$Season[(my_data2$Season == "winter") ] <- "Winter"
my_data2$Season[(my_data2$Season == "spring") ] <- "Spring"
my_data2$Season[(my_data2$Season == "Automn") ] <- "Autumn"

# to check if there NA values 
summary(my_data2)
# here we have 4 missing values so delete them and we can check by the rows numbers
dim(my_data2)
my_data2 <- na.omit(my_data2)
dim(my_data2)


# Here start using shiny app 
ui <- fluidPage(
  sliderInput(inputId="num",
              label = "Choose The Rating Number",
              value=4.8,
              min=0,
              max=5.0,
              step = 0.1),
  plotOutput("bar")

  
)

server <- function(input, output, session) {
  title <- "Clothes Prices Based On Rating"
  output$bar <- renderPlot({
    my_data2 %>%
      filter(Rating == input$num) %>%
      ggplot(aes(Rating)) +
      geom_bar(aes(fill = Price), position = "dodge") +
      labs(title = title) 
    
  })
  
}

shinyApp(ui, server)



#############





