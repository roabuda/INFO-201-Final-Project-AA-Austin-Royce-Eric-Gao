library(ggplot2)
library(dplyr)
library(MASS)
joined <- read.csv("./data/joined.csv")

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
     # ylim(y.min, y.max)+
     coord_flip()+
     theme(axis.text.y.left = element_text(face="bold", color = "black", 
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

##### TEST #####

# For joined data, add additional columns, needed for the drawing the geom_rect
california <- filter(joined, State == "California")
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

#Plot the energy graph of one state
california.donut.chart <- ggplot(california.energy, aes(fill=energy_type, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
  geom_rect() +
  coord_polar(theta="y") +
  xlim(c(0, 4)) +
  theme(panel.grid=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.ticks=element_blank()) +
  annotate("text", x = 0, y = 0, label = "California") +
  labs(title="")

california.donut.chart


DonutChart <- function(data.frame,
                       state.name,
                       )