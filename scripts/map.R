#load libraries
library(dplyr)
library(plotly)
library(ggplot2)

#get joined data
joined <- read.csv("./data/joined.csv", stringsAsFactors = FALSE)
joined$State <- toupper(joined$State)

#create min,max, and energy values for testing
min <- 0
max <- 1000
energy <- c("PC.","GEO")

#create a function that uses the joined data and takes in numbers for min and max energy, 
#a vector of what types of energy to compare, and shows each
#state's population and which party won in 2016

create.map <- function(min,max,energy)
{
  #load US map data
  states <- map_data("state") %>% select(-subregion, -order)
  colnames(states) <- c("long","lat","group","State")
  states$State <- toupper(states$State)
  
  states.base <- ggplot(data = states, mapping = aes(x = long, y = lat, group = group)) + 
    coord_fixed(1.3) + 
    geom_polygon(color = "black", fill = "gray")
  
  #plot states with ggplot
  state.base <- ggplot()
  
  #create map of the US with state boundaries
  state.base <- state.base + geom_polygon( data=states, aes(x=long, y=lat, group = group),colour="white") + 
    coord_fixed(1.3)
  
  #join the states data and the joined data to create the map data
  map.data <- inner_join(states, joined, by = "State")
  
   state.map <- states.base + 
    geom_polygon(data = map.data, aes(fill = Winning.Party), color = "white") +
    geom_polygon(color = "black", fill = NA) + theme_void() + 
    scale_fill_manual(name = "State Political Party Inclination",values=c("blue", "red"))
}

