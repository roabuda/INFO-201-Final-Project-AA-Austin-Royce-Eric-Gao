
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
data.frame <- joined

#create a function that uses the joined data and takes in numbers for min and max energy, 
#a vector of what types of energy to compare, and shows each
#state's population and which party won in 2016

CreateMap <- function(data.frame,min,max,energy)
{
  #generates abriviations so that plotly can understand
  map.data <- data.frame
  map.data$State <-tolower(map.data$State) 
  map.data$State <-  lapply(map.data$State, simpleCap)
  map.data <- map.data %>% 
    mutate('code' = state.abb[match(State,state.name)]) %>% 
    mutate(poltical.stance = ifelse(Winning.Party == "Democrats", 1 , 0))
  

  l <- list(color = toRGB("white"), width = 2)
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  p <- plot_geo(map.data, locationmode = 'USA-states') %>%
    add_trace(
      z = ~Population, text = ~Winning.Party, locations = ~code
    ) %>%
    layout(
      title = 'Title',
      geo = g
    )
  
  return(p)
  
  ########ggplot version doesn't work with shiny for some reason######
  if (F == T){
    
    states <-  map_data("state")[,c("long","lat", "group", "region")]
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
  state.map <- states.base + 
  theme_void() + 
  geom_polygon(data = map.data, aes(fill = Winning.Party), color = "white")
  geom_polygon(color = "black", fill = NA) + #shiny does not like this at all
  scale_fill_manual(name = "State Political Party Inclination",values=c("blue", "red"))
  }
}

simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}

CreateMap(data.frame,min,max,energy)
