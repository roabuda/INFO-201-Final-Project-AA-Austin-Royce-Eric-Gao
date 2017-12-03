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
     geom_text(aes(label=data.frame[,y.var]), vjust=-0.3, size=2.5)+
     labs(x = "State", y = y.lab, title = my.title, fill = legend.title)+
     # coord_cartesian(ylim = c(0, max(data.frame$y.var)))+
     # coord_flip()+
     theme(axis.text.x = element_text(face="bold", color="#993333", 
                                            size=10, angle=90))
 
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







