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
HistogramGraph <- function(data.frame, 
                           y.var, 
                           my.title = "Tittle",
                           y.lab = "Y Lab",
                           legend.title = "Legend Lab") {
p <- ggplot(data = data.frame,
            aes(x = factor(State, levels = State[order(Population)]), data.frame[,y.var], fill = data.frame[,y.var])) +
     geom_histogram(stat = "identity")+
     # geom_text(aes(label=joined$COW), vjust=-0.3, size=2.5)+
     labs(x = "State", y = y.lab, title = my.title, fill = legend.title)+
     coord_cartesian(ylim = c(0, max(data.frame$y.var)))+
     coord_flip()+
     theme(axis.text.y = element_text(face="bold", color = "black", 
                                        size=8))
 
  return(p)

}

#### TEST ####
# ptest2 <- ggplot(data = joined,
#             aes(x = factor(State, levels = State[order(Population)]),as.numeric(BIO), fill = as.numeric(BIO))) +
#   geom_histogram(stat = "identity")+
#   # geom_text(aes(label=joined$COW), vjust=-0.3, size=2.5)+
#   labs(aes(x = "State", y = y.lab, title = my.title, fill = legend.title))+
#   # ylim(y.min, y.max)+
#   coord_flip()+
#   theme(axis.text.y.left = element_text(face="bold", color = "black", 
#                                         size=8))
# 
# ptest2

#Sample Code
HistogramGraph(data.frame = joined, 
               y.var = "COW", 
               my.title = "TEST",
               y.lab = "COW",
               legend.title = "COW")

#### DONUT GRAPH TEMPLATE ####
# Create test data.
# dat = data.frame(count=c(10, 60, 30), category=c("A", "B", "C"))
# 
# # Add addition columns, needed for drawing with geom_rect.
# dat$fraction = dat$count / sum(dat$count)
# dat = dat[order(dat$fraction), ]
# dat$ymax = cumsum(dat$fraction)
# dat$ymin = c(0, head(dat$ymax, n=-1))
# 
# # # Make the plot
# p1 = ggplot(dat, aes(fill=category, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
#   geom_rect() +
#   coord_polar(theta="y") +
#   xlim(c(0, 4)) +
#   theme(panel.grid=element_blank()) +
#   theme(axis.text=element_blank()) +
#   theme(axis.ticks=element_blank()) +
#   annotate("text", x = 0, y = 0, label = "My Ring plot !") +
#   labs(title="")
# p1



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



### TEST IF CODE WERE RIGHT #####
# california <- filter(joined, State == "Arizona")
# california.energy <- data.frame(
#   count = c(california$BIO,
#             california$COW,
#             california$GEO,
#             california$HYC,
#             california$NG.,
#             california$NUC,
#             california$OOG,
#             california$PC.,
#             california$PEL,
#             california$TSN,
#             california$WND),
#   energy_type = c("BIO", "COW", "GEO", "HYC","NG.","NUC", "OOG", "PC.", "PEL", "TSN", "WND")
# )
# california.energy$fraction <- california.energy$count/sum(california.energy$count)
# california.energy = california.energy[order(california.energy$fraction), ]
# california.energy$ymax = cumsum(california.energy$fraction)
# california.energy$ymin = c(0, head(california.energy$ymax, n=-1))
# 
# california.donut.chart <- ggplot(california.energy, aes(fill=energy_type, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
#   geom_rect() +
#   coord_polar(theta="y") +
#   xlim(c(0, 4)) +
#   theme(panel.grid=element_blank()) +
#   theme(axis.text=element_blank()) +
#   theme(axis.ticks=element_blank()) +
#   # annotate("text", x = 0, y = 0, label = "legend title") +
#   labs(title="plot title")
# 
# blank_theme <- theme_minimal()+
#   theme(
#     axis.title.x = element_blank(),
#     axis.title.y = element_blank(),
#     # panel.border = element_blank(),
#     # panel.grid=element_blank(),
#     # axis.ticks = element_blank(),
#     plot.title=element_text(size=14, face="bold")
#   )
# 
# california.donut.chart+blank_theme+
# theme(axis.text.x=element_blank()) + theme(legend.position=c(.5, .5)) +
#   theme(panel.grid=element_blank()) +
#   theme(axis.text=element_blank()) +
#   theme(axis.ticks=element_blank()) +
#   theme(legend.title = element_text(size=8, face="bold")) +
#   theme(legend.text = element_text(size = 6, face = "bold")) +
#   geom_label(aes(label=paste(round(fraction,3)*100,"%"),x=3.5,y=(ymin+ymax)/2),inherit.aes = TRUE, show.legend = FALSE)


#sample code for pie chart 
p1 <- PieChart(data.frame = joined,
           state.name = "Arizona", 
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
# 
# data("mtcars")
# mtcars$manuf <- sapply(strsplit(rownames(mtcars), " "), "[[", 1)
# 
# p <- mtcars %>%
#   group_by(manuf) %>%
#   summarize(count = n()) %>%
#   plot_ly(labels = ~manuf, values = ~count, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
#   add_pie(hole = 0.6) %>%
#   layout(title = "Donut charts using Plotly",  showlegend = F,legend = l,
#          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# p
