library(ggplot2)
library(dplyr)
joined.data <- read.csv("./data/joined.csv")
HistogramGraph <- function(data.frame, 
                           xvar, 
                           yvar, 
                           my.title,
                           x.lab,
                           y.lab,
                           colorVar,
                           x.max = min(x.var),
                           y.max = max(y.var),
                           x.min = 0,
                           y.min = 0) {
  #change -- as 0
  joined[joined == "--" | joined == "NM"] <- 0
  
 p <- ggplot(data = data.frame, aes(x=xvar, y=yvar))+
    geom_bar(stat = "identity")+
    geom_text(aes(y = yvar, label=yvar), vjust=1.6, 
              color="Black", size=3.5)+
    # scale_fill_brewer(palette = energy.type)+
    ggtitle(my.title)+
    labs(x=x.lab, y=y.lab)+
    xlim(x.min, x.max)+
    ylim(y.min, y.max)+
    theme_minimal()
  return(p)
}
HistogramGraph(joined, xvar = joined$Population, yvar = joined$BIO, my.title = "test", x.lab = "Population", y.lab = "BIO",colorVar = joined$BIO, x.max = max(joined$Population), y.max = max(joined$BIO), x.min = 0, y.min = 0)
