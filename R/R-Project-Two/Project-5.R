#Lama Alzahrani
#Ruba Alkhattabi
#Reema Alotaibi
#Ahmed Altowairqi

library(tidyverse)
library(DataExplorer)
library(tidyr)


view(billboard)
# summary for our data.
summary(billboard)

introduce(billboard)

# EDA Before:
# plot 1
plot_missing(billboard)
# plot 2
max_artist <- billboard %>%
  filter(artist == "Jay-Z") %>%
  select(wk1, wk2,wk3,track)
max_artist %>%
  select(wk1, wk2, track) 
plot_scatterplot(max_artist,'track',title = 'Jay-Z Songs ranked in 3 weeks')

# Tidy
billboard_tidy <- billboard %>%
  pivot_longer(-c(artist , track, date.entered) , names_to = "week", values_to ="rank",values_drop_na = TRUE )
View(billboard_tidy)

# split date into year, month and day.
billboard_tidy$date.entered<- as.Date(billboard_tidy$date.entered)
billboard_tidy<-billboard_tidy %>%
  mutate(year = as.numeric(format(date.entered, format = "%Y")),
         month = as.factor(format(date.entered, format = "%m")),
         day = as.numeric(format(date.entered, format = "%d")))

# EDA after tidy

# polt 1
billboard_tidy %>%
  ggplot(aes(x=month)) +
  geom_bar()


# plot 2
n <- data.frame(table(billboard_tidy$artist))

n[n$Freq > 1,] # to check.

n  %>%
  filter(Freq > 30 )%>%
  ggplot(aes(x=Var1, y=Freq)) +
  geom_bar(stat='identity')+
  coord_flip()



