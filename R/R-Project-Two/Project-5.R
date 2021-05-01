#Lama Alzahrani
#Ruba Alkhattabi
#Reema Alotaibi
#Ahmed Altowairqi

library(tidyverse)
library(DataExplorer)
library(tidyr)
library(DescTools)
library(hrbrthemes) # for style


view(billboard)

# summary for our data.
introduce(billboard)

# EDA Before tidy data:

# plot 1
# This function returns and plots frequency of missing values for each feature.
plot_missing(billboard ,title='Missing values in top 100 songs Billboard')

# plot 2
# To know the artist with hiegst number of songs.
which.max(table(billboard$artist))
# This plot shows the artist Jay-z ranked songs in the first three weeks.
max_artist <- billboard %>%
  filter(artist == "Jay-Z") %>%
  select(wk1, wk2,wk3,track)
plot_scatterplot(max_artist,'track',title = 'Jay-Z Songs ranked in 3 weeks')



# Now we are tidy our data.
billboard_tidy <- billboard %>%
  pivot_longer(-c(artist , track, date.entered) , names_to = "week", values_to ="rank",values_drop_na = TRUE )
View(billboard_tidy)

# split date into year, month and day.
billboard_tidy$date.entered<- as.Date(billboard_tidy$date.entered)
billboard_tidy<-billboard_tidy %>%
  mutate(year = as.factor(format(date.entered, format = "%Y")),
         month = as.factor(format(date.entered, format = "%m %b")),
         day = as.factor(format(date.entered, format = "%d")))

# EDA after tidy data:

# polt 1 

# Freq function returns the levels of the variable with frequency, percent, 
# The cumulative sum of the frequency and percent.
rank_table<-Freq(billboard_tidy$rank)
# This plot shows the rank levels and the percent, (90,100] level is the highest level.
rank_table %>%
  ggplot(aes(level,perc)) +
  geom_segment( aes(x=level, xend=level, y=0, yend=perc), color="steelblue4") +
  geom_point( color="steelblue3", size=4, alpha=0.6) +
  theme_light() +
  labs(title = "Percent Frequency for Ranked Billboard", y = "Percent Frequency ", x = "Rank Levels") +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

# plot 2
# This plot shows how many times that artists show in the billboard songs 
# more than 30 times, and it shows Creed that its songs ranked over 100 times.
n <- data.frame(table(billboard_tidy$artist))
n[n$Freq > 30,] # to check.
n  %>%
  filter(Freq >30 )%>%
  ggplot(aes(x=Var1, y=Freq )) +
  geom_bar(stat = 'identity',fill ='steelblue4',width=0.5)+
  labs(title = "Artists Show in the Billboard Songs More Than 30 Times", y = "Frequency", x = "Artist") +
  coord_flip()  
