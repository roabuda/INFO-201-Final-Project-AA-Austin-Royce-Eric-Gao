library(ggplot2)
library(dplyr)
library(plotly)




ScatterGraph <- function(data.frame, 
                      x.var, 
                      y.var, 
                      colorVar, 
                      title = "Title",
                      x.lab = "X Title",
                      y.lab = "Y Title",
                      legend = "legend",
                      x.max = max(x.var),
                      y.max = max (y.var),
                      x.min = 0,
                      y.min = 0)
{
  
Population  <- data.frame[,x.var]
Watts  <- data.frame[,y.var]
Party  <- data.frame[,colorVar]
  plot <-  ggplot(data = data.frame, aes(x = Population,
                                         y= Watts, 
                                         color = Party )) +
   # geom_text(show.legend = F)+
    geom_point() +
    geom_smooth(se = T, method = "lm")+
    labs(title = title, x = x.lab, y = y.lab, color = legend) #+ 
 #   xlim(x.min, x.max)+
   # ylim(y.min, y.max)   
  return(plot)
}

#sample code:
#setwd

test <- read.csv('./data/joined.csv',stringsAsFactors = FALSE)
ScatterGraph(data.frame = test,
          x.var = 'Population', 
          y.var = 'total',
          colorVar = 'Winning.Party', 
          title = 'test',
          x.lab = "x",
          y.lab = "y",
          legend = "legend")
