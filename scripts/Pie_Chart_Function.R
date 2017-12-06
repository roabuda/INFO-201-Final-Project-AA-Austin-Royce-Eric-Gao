library(plotly)
library(dplyr)
library(tidyr)
library(plyr)
library(scales)
#joined <- read.csv("./data/joined.csv", stringsAsFactors = FALSE)

#### PIE CHART ####

PieChart <- function(data.frame,
                     state.name,
                     legend.title = "Legent Title",
                     plot.title = "Title") {
  #filter the specific state data that we want
  type.of <- filter(data.frame, State == state.name)
  type.of.energy <- data.frame(
    count = c(type.of$BIO, 
              type.of$COW,
              type.of$GEO,
              type.of$HYC,
              type.of$NG.,
              type.of$NUC,
              type.of$OOG,
              type.of$PC.,
              type.of$PEL,
              type.of$TSN,
              type.of$WND),
    energy_type = c("BIO", "COW", "GEO", "HYC","NG.","NUC", "OOG", "PC.", "PEL", "TSN", "WND")
  ) %>%
  filter(count != 0)
  
  # Add addition columns, needed for drawing with geom_rect.
  type.of.energy$fraction <- type.of.energy$count/sum(type.of.energy$count)
  type.of.energy = type.of.energy[order(type.of.energy$fraction), ]
  type.of.energy$ymax = cumsum(type.of.energy$fraction)
  type.of.energy$ymin = c(0, head(type.of.energy$ymax, n=-1))
  
  #Define legend paramter and margin of the graph
  l <- list( x=1.2, y=0.5,
             font = list(
               family = "sans-serif",
               size = 10,
               color = "#000"),
             bgcolor = "#E2E2E2",
             bordercolor = "#FFFFFF",
             borderwidth = 2)
  m <- list(
    b = 200,
    t = 200,
    pad = 4
  )
  
  s <- list(
    l = 50,
    r = 50,
    b = 100,
    t = 50,
    pad = 4
  )
  
  #text
  t <- list(
    color = 'white')
  
  #Plot the energy graph of one state
  type.of.pie.chart <- p1 <- plot_ly(type.of.energy,
                                          labels = ~energy_type,
                                          values = ~fraction,
                                          type = 'pie',
                                          textposition = 'outside',
                                          textinfo = 'label+percent',
                                          textfont = list(color = 'white', size = 11)) %>%
    layout(title = plot.title,  showlegend = T,legend = l,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE), font = t)%>% 
    layout(paper_bgcolor = "#272b30") %>% 
    layout(plot_bgcolor="#272b30")

  
  return(type.of.pie.chart)
}

p1 <- PieChart(data.frame = joined,
               state.name = "type.of", 
               legend.title = "Energy Type", 
               plot.title = paste0("type.of ", "Energy Type"))
p1



##### TEST #####
# type.of <- filter(joined, State == "type.of")
# type.of.energy <- data.frame(
#   count = c(type.of$BIO, 
#             type.of$COW,
#             type.of$GEO,
#             type.of$HYC,
#             type.of$NG.,
#             type.of$NUC,
#             type.of$OOG,
#             type.of$PC.,
#             type.of$PEL,
#             type.of$TSN,
#             type.of$WND),
#   energy_type = c("BIO", "COW", "GEO", "HYC","NG.","NUC", "OOG", "PC.", "PEL", "TSN", "WND")
# ) %>% 
#   filter(count != 0)
# 
# # Add addition columns, needed for drawing with geom_rect.
# type.of.energy$fraction <- type.of.energy$count/sum(type.of.energy$count)
# type.of.energy = type.of.energy[order(type.of.energy$fraction), ]
# type.of.energy$ymax = cumsum(type.of.energy$fraction)
# type.of.energy$ymin = c(0, head(type.of.energy$ymax, n=-1))

