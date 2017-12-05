library(ggplot2)
library(dplyr)
library(MASS)
library(ggrepel)
library(scales)
library(plotly)
library(tidyr)
library(plyr)

joined <- read.csv("./data/joined.csv", stringsAsFactors = FALSE)

#### HISTOGRAM FUNCTION ####
HistogramLineGraph <- function(data.frame, 
                           y.var, 
                           my.title = "Tittle",
                           bar.title = "Energy",
                           line.title = "State"
                           ) {
 #Set the boundry
   f1 <- list(
    family = "Arial, sans-serif",
    size = 15,
    color = "lightgrey"
  )
  f2 <- list(
    family = "Old Standard TT, serif",
    size = 5,
    color = "black"
  )

  t <- list(
    color = 'white') 
  
#make the histogram  
  p1 <- plot_ly(data = data.frame, x = ~data.frame[,y.var], y = ~reorder(State, data.frame[,y.var]), name = bar.title,
                type = 'bar', orientation = 'h',text = ~data.frame[,y.var], textposition = 'auto',
                marker = list(color = 'rgba(50, 171, 96, 0.6)',
                              line = list(color = 'rgba(50, 171, 96, 1.0)', width = 1))) %>%
    layout(yaxis = list(showgrid = FALSE, showline = FALSE, showticklabels = TRUE, domain= c(0, 0.85),title = "STATE",
                        titlefont = f1,
                        showticklabels = TRUE,
                        tickfont = f2,
                        exponentformat = "E"),
           xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE),font = t) 
 
#make the line graph
  p2 <- plot_ly(data = data.frame, x = ~data.frame[,y.var], y = ~reorder(State, data.frame[,y.var]), name = line.title,
                type = 'scatter', mode = 'lines+markers',
                line = list(color = 'rgb(128, 0, 128)')) %>%
    layout(yaxis = list(showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
                        linecolor = 'rgba(102, 102, 102, 0.8)', linewidth = 2,
                        domain = c(0, 0.85)),
           xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE,
                        side = 'top', dtick = 25000),font = t) 

#merge them together
  p <- subplot(p1, p2) %>%
    layout(title = my.title,
           legend = list(x = 0.029, y = 1.038,
                         font = list(size = 10)),
           margin = list(l = 100, r = 20, t = 70, b = 70),
           paper_bgcolor = 'rgb(248, 248, 255)',
           plot_bgcolor = 'rgb(248, 248, 255)') %>% 
    layout(paper_bgcolor="#272b30") %>% 
    layout(plot_bgcolor="#272b30") 
  
  return(p)

}


###### SAMPLE CODE FOR HISOTGRAM #######
HistogramLineGraph(data.frame = joined,
                   y.var = "COW",
                   my.title = "My Tittle",
                   bar.title = "bar_title",
                   line.title = "line_title")

# #### TEST ####
# ptest1 <- ggplot(data = joined,
#             aes(x = factor(State, levels = State[order(joined[,"COW"], decreasing = TRUE)]), joined[,"COW"], fill = joined[,"COW"])) +
#   geom_histogram(stat = "identity")+
#   geom_text(aes(label=joined[,"COW"]), vjust=-0.3, size=2)+
#   labs(x = "State", y = "COW", title = "my.title", fill = "legend.title")+
#   # coord_cartesian(ylim = c(0, max(data.frame$y.var)))+
#   # coord_flip()+
#   theme(axis.text.x = element_text(face="bold", color="#993333",
#                                    size=10, angle=90))
# ptest1
# p <- ptest1+ geom_line(data=joined, aes(x=as.numeric(State), y=joined[,"COW"]), colour = "red")
# p
m <- list(
  l = 30,
  r = 30,
  b = 80,
  t = 80,
  pad = 4
)

# p <- plot_ly(joined, y = ~factor(State, levels = State[order(joined[,'COW'], decreasing = F)]), x = ~COW, type = 'bar',
#              text = ~BIO, textposition = 'auto',orientation = 'h',
#              marker = list(color = 'rgb(158,202,225)',
#                            line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
#   layout(title = "MY ASS",
#          xaxis = list(title = ""),
#          yaxis = list(title = "COW"))
# 
# p
# #Sample Code
# HistogramGraph(data.frame = joined,
#                y.var = "BIO",
#                my.title = "TEST",
#                y.lab = "BIO",
#                legend.title = "BIO")
# 
# f1 <- list(
#   family = "Arial, sans-serif",
#   size = 15,
#   color = "lightgrey"
# )
# f2 <- list(
#   family = "Old Standard TT, serif",
#   size = 5,
#   color = "black"
# )
# a <- list(
#   title = "AXIS TITLE",
#   titlefont = f1,
#   showticklabels = TRUE,
#   tickangle = 45,
#   tickfont = f2,
#   exponentformat = "E"
# )
# 
# 
# 
# p1 <- plot_ly(data = joined, x = ~COW, y = ~reorder(State, COW), name = 'COW',
#               type = 'bar', orientation = 'h',text = ~COW, textposition = 'auto',
#               marker = list(color = 'rgba(50, 171, 96, 0.6)',
#                             line = list(color = 'rgba(50, 171, 96, 1.0)', width = 1))) %>%
#   layout(yaxis = list(showgrid = FALSE, showline = FALSE, showticklabels = TRUE, domain= c(0, 0.85),title = "STATE",
#                       titlefont = f1,
#                       showticklabels = TRUE,
#                       tickfont = f2,
#                       exponentformat = "E"),
#          xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE))
#   # add_annotations(xref = 'x1', yref = 'y',
#   #                 # x = COW * 2.1 + 3,  y = y,
#   #                 text = ~COW,
#   #                 font = list(family = 'Arial', size = 12, color = 'rgb(50, 171, 96)'),
#   #                 showarrow = FALSE)
# p1
# p2 <- plot_ly(data = joined, x = ~COW, y = ~State, name = 'Line Graph',
#               type = 'scatter', mode = 'lines+markers',
#               line = list(color = 'rgb(128, 0, 128)')) %>%
#   layout(yaxis = list(showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
#                       linecolor = 'rgba(102, 102, 102, 0.8)', linewidth = 2,
#                       domain = c(0, 0.85)),
#          xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE,
#                       side = 'top', dtick = 25000))
#   # add_annotations(xref = 'x2', yref = 'y',
#   #                 x = x_net_worth, y = y,
#   #                 text = paste(x_net_worth, 'M'),
#   #                 font = list(family = 'Arial', size = 12, color = 'rgb(128, 0, 128)'),
#   #                 showarrow = FALSE)
# p2
# p <- subplot(p1, p2) %>%
#   layout(title = 'Household savings & net worth for eight OECD countries',
#          legend = list(x = 0.029, y = 1.038,
#                        font = list(size = 10)),
#          margin = list(l = 100, r = 20, t = 70, b = 70),
#          paper_bgcolor = 'rgb(248, 248, 255)',
#          plot_bgcolor = 'rgb(248, 248, 255)')
#   # add_annotations(xref = 'paper', yref = 'paper',
#   #                 x = -0.14, y = -0.15,
#   #                 text = paste('OECD (2015), Household savings (indicator), Household net worth (indicator). doi: 10.1787/cfc6f499-en (Accessed on 05 June 2015)'),
#   #                 font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
#   #                 showarrow = FALSE)
# p
# 

