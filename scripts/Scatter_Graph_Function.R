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
                      y.min = 0,
                      confidence = T,
                      type = "lm",
                      per.person = F)
{
  
Population  <- data.frame[,x.var]
if(per.person == T)
{
  `Thousands of Mega Watts`  <- data.frame[,y.var]/data.frame[,x.var]
}
else
{
`Thousands of Mega Watts`  <- data.frame[,y.var]
}
Party  <- data.frame[,colorVar]
  plot <-  ggplot(data = data.frame, aes( 
                                          x = Population,
                                         y= `Thousands of Mega Watts`, 
                                         color = Party
                                        
                                        )) +
    
   # geom_text(show.legend = F)+
    geom_point(aes( text = paste0("State: ",data.frame$State )) ) +
    geom_smooth(se = confidence, method = type)+
    labs(title = title, x = x.lab, y = y.lab, color = legend) + 
    scale_color_manual(values=c("#00fcff", "#ff2600")) + 
    theme_dark()+
    theme(plot.background = element_rect(fill = "#272b30"))+
    theme(plot.margin=unit(c(1,1,1.5,1.2),"cm"), 
          axis.text.x=element_text(colour="white"),
          axis.text.y=element_text(colour="white"),
          axis.title.x=element_text(colour="white"),
          axis.title.y=element_text(colour="white"),
          title = element_text(colour="white"), 
          panel.background = element_rect(fill = "#272b30",
        colour = "#4189c7",
         size = 0.5, linetype = "solid"),
          panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                          colour = "white"), 
          panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                          colour = "white"),
        legend.background = element_rect(fill="#272b30"),
        legend.text = element_text(colour="white")
        )
  #xlim(x.min, x.max)+
   # ylim(y.min, y.max)
  return(plot)
}

#sample code:
#setwd
#if(F == T){
test <- read.csv('./data/joined.csv',stringsAsFactors = FALSE)
ScatterGraph(data.frame = test,
          x.var = 'Population', 
          y.var = 'total',
          colorVar = 'Winning.Party', 
          title = 'test',
          x.lab = "x",
          y.lab = "y",
          legend = "legend",
          confidence = F)
#}