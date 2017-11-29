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
 plot <-  ggplot(data = data.frame) +
   geom_point(mapping = aes(x = data.frame[,x.var],
                            y=data.frame[,y.var],
                            color = data.frame[,colorVar])) +
   labs(title = title, x = x.lab, y = y.lab, color = legend) + 
   xlim(x.min, x.max)+
   ylim(y.min, y.max)
  return(plot)
}

#sample code:
#setwd
#test <- read.csv('./data/intro-survey.csv',stringsAsFactors = FALSE)
#LineGraph(data.frame = test,
#          x.var = 'How.many.siblings.do.you.have.', 
#          y.var = 'How.many.inches.tall.are.you.',
#          colorVar = 'What.is.your.current.class.standing.', 
#          title = 'test',
#          x.lab = "x",
#          y.lab = "y",
#          legend = "legend",
#          x.max = 10, 
#          y.max = 85,
#          y.min = 50)