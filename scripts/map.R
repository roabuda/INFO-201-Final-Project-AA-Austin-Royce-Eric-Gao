#load libraries
library(dplyr)
library(plotly)
library(ggplot2)

#source pie chart function
source("./scripts/Pie_Chart_Function.R")

#create a function that uses the joined data and calculates the min and max of whichever
#type of varaible to compare (either population or type of energy), a variable of what type of energy is being compared, and shows each
#state's party won in 2016
CreateMap <- function(data.frame,compare)
{
  #generates state abriviations so that plotly can understand
  data.frame <- data.frame %>% 
    mutate('code' = state.abb[match(State,state.name)]) %>% 
    mutate(political.stance = ifelse(Winning.Party == "Democrats", 1 , 0))
  
  #create compare column
  vec <- data.frame[,compare]
  data.frame <- data.frame %>% mutate(compare = vec)
  
  #calculate the min and max
  min <- min(data.frame$compare)
  max <- max(data.frame$compare)
  
  #make state bounderies white
  l <- list(color = toRGB("white"), width = 2)
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = FALSE
  )
  #show data on map
  p <- plot_geo(data.frame, locationmode = 'USA-states') %>%
    add_trace(
      z = ~compare, text = ~Winning.Party, locations = ~code) %>%
    colorbar(title = compare) %>%
    layout(
      title = paste(compare,"Amount per State"),
      geo = g
    )
  
  return(p)
}

#create function that takes in two states and creates a subplot of the two states using the
#PieChart function.
StatePieCharts <- function(first.state,second.state)
{
  p1 <- PieChart(data.frame = joined,
                 state.name = "California", 
                 legend.title = "Energy Type", 
                 plot.title = paste0("California ", "Energy Type"))
  p2 <- PieChart(data.frame = joined,
               state.name = "Washington", 
               legend.title = "Energy Type", 
               plot.title = paste0("Washington ", "Energy Type"))
  p <- subplot(p1,p2, nrows = 2)
  return(p)
}
