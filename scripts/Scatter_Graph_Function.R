library(ggplot2)
library(dplyr)




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
  plot <-  ggplot(data = data.frame, aes(x = data.frame[,x.var],
                                         y=data.frame[,y.var], color = data.frame[,colorVar])) +
    geom_point() +
    geom_smooth(se = FALSE)+
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