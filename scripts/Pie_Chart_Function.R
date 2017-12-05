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
  california <- filter(data.frame, State == state.name)
  california.energy <- data.frame(
    count = c(california$BIO, 
              california$COW,
              california$GEO,
              california$HYC,
              california$NG.,
              california$NUC,
              california$OOG,
              california$PC.,
              california$PEL,
              california$TSN,
              california$WND),
    energy_type = c("BIO", "COW", "GEO", "HYC","NG.","NUC", "OOG", "PC.", "PEL", "TSN", "WND")
  )
  
  # Add addition columns, needed for drawing with geom_rect.
  california.energy$fraction <- california.energy$count/sum(california.energy$count)
  california.energy = california.energy[order(california.energy$fraction), ]
  california.energy$ymax = cumsum(california.energy$fraction)
  california.energy$ymin = c(0, head(california.energy$ymax, n=-1))
  
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
    l = 0,
    r = 0,
    b = 50,
    t = 50,
    pad = 4
  )
  
  #text
  t <- list(
    color = 'white')
  
  #Plot the energy graph of one state
  california.donut.chart <- p1 <- plot_ly(california.energy,
                                          labels = ~energy_type,
                                          values = ~fraction,
                                          type = 'pie',
                                          textposition = 'outside',
                                          textinfo = 'label+percent',
                                          autosize = T,
                                          margin = m) %>%
    layout(title = plot.title,  showlegend = T,legend = l,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE), font = t)%>% 
    layout(paper_bgcolor="#272b30") %>% 
    layout(plot_bgcolor="#272b30")
  
  return(california.donut.chart)
}

p1 <- PieChart(data.frame = joined,
               state.name = "California", 
               legend.title = "Energy Type", 
               plot.title = paste0("California ", "Energy Type"))
p1