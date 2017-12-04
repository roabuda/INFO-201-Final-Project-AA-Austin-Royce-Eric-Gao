library(plotly)
library(dplyr)
library(tidyr)
library(plyr)
library(scales)
joined <- read.csv("./data/joined.csv", stringsAsFactors = FALSE)

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
  
  #Plot the energy graph of one state
  california.donut.chart <- p1 <- plot_ly(california.energy,
                                          labels = ~energy_type,
                                          values = ~fraction,
                                          type = 'pie',
                                          textposition = 'outside',
                                          textinfo = 'label+percent',
                                          autosize = F,
                                          width = 900,
                                          height = 900,
                                          margin = m) %>%
    layout(title = plot.title,  showlegend = T,legend = l,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(california.donut.chart)
}

p1 <- PieChart(data.frame = joined,
               state.name = "California", 
               legend.title = "Energy Type", 
               plot.title = paste0("California ", "Energy Type"))
p1


#####################

# ##pie chart test ###
# bp<- ggplot(california.energy, aes(x="", y=california.energy$count, fill=energy_type))+
#   geom_bar(width = 1, stat = "identity")
# pie <- bp + coord_polar("y", start=0)
# 
# blank_theme <- theme_minimal()+
#   theme(
#     axis.title.x = element_blank(),
#     axis.title.y = element_blank(),
#     panel.border = element_blank(),
#     panel.grid=element_blank(),
#     axis.ticks = element_blank(),
#     plot.title=element_text(size=14, face="bold")
#   )
# 
# pie + scale_fill_grey() +  blank_theme +
#   theme(axis.text.x=element_blank()) +
#   geom_text(aes(y = count/3 + c(0, cumsum(count)[-length(count)]), 
#                 label = percent(california.energy$fraction)), size=5)
# 
# 
# l <- list(
#   font = list(
#     family = "sans-serif",
#     size = 12,
#     color = "#000"),
#   bgcolor = "#E2E2E2",
#   bordercolor = "#FFFFFF",
#   borderwidth = 2)
# 
# p1 <- plot_ly(california.energy, labels = ~energy_type, values = ~fraction, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
#   add_pie(hole = 0.6) %>%
#   layout(title = "Donut charts using Plotly",  showlegend = T, legend = l,
#          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# p1