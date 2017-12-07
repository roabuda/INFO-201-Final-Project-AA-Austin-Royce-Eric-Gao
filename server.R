#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(packcircles)
source('./scripts/Scatter_Graph_Function.R')
source('./scripts/histogram.R')
source('./scripts/map.R')
source('./scripts/Pie_Chart_Function.R')

data <- read.csv("./data/joined.csv", stringsAsFactors = F)
data.both <- read.csv("./data/joined_new.csv", stringsAsFactors = F)

######Histograph######
shinyServer(function(input, output) {
  
  #set the variable max
  output$slider2 <- renderUI({
    sliderInput("new.variable.max1", "Variable Max", min=0, max=max(data[,input$hist.var]), value=max(data[,input$hist.var]))
  }) 
  
  output$histPlot <- renderPlotly({
    # Filter data
    chart.data <- data %>% 
      filter(data[,input$hist.var] > 0)
    
    
    # Make chart
    HistogramLineGraph(data.frame = chart.data,
                       y.var = input$hist.var,
                       max.range = input$new.variable.max1,
                       my.title = "Energy Consumption",
                       bar.title  = input$hist.var)
  })
  
  
  
  output$usa.energy<- renderPlotly({

    usa.data <- data.frame(
      count = c(sum(data$BIO), 
                sum(data$COW),
                sum(data$GEO),
                sum(data$HYC),
                sum(data$NG.),
                sum(data$NUC),
                    sum(data$OOG),
                        sum(data$PC.),
                            sum(data$PEL),
                                sum(data$TSN),
                                    sum(data$WND)),
      energy_type = c("BIO", "COW", "GEO", "HYC","NG.","NUC", "OOG", "PC.", "PEL", "TSN", "WND")
    ) %>%
      filter(count != 0)
    
    # Add addition columns, needed for drawing with geom_rect.
    usa.data$fraction <- usa.data$count/sum(usa.data$count)
    usa.data = usa.data[order(usa.data$fraction), ]
    usa.data$ymax = cumsum(usa.data$fraction)
    usa.data$ymin = c(0, head(usa.data$ymax, n=-1))
    
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
    usa.total.energy <- p1 <- plot_ly(usa.data,
                                            labels = ~energy_type,
                                            values = ~fraction,
                                            type = 'pie',
                                            textposition = 'outside',
                                            textinfo = 'label+percent',
                                            textfont = list(color = 'white', size = 11)) %>%
      layout(title = "2016 USA Total Energy Consumption",  showlegend = T,legend = l,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE), font = t)%>% 
      layout(paper_bgcolor = "#272b30") %>% 
      layout(plot_bgcolor="#272b30")
    usa.total.energy
  })
  
  output$bubble <- renderPlotly({
    # Create data
    data.1=data.frame(State= data$State, `Thousands of Megawatts` =data$total) 
    
    # Generate the layout. This function return a dataframe with one line per bubble. 
    # It gives its center (x and y) and its radius, proportional of the value
    packing <- circleProgressiveLayout(data.1$Thousands.of.Megawatts, sizetype='area')
    
    # We can add these packing information to the initial data frame
    data.1 = cbind(data.1, packing)
    
    # Check that radius is proportional to value. We don't want a linear relationship, since it is the AREA that must be proportionnal to the value
    plot(data.1$radius, data.1$Thousands.of.Megawatts)
    
    # The next step is to go from one center + a radius to the coordinates of a circle that
    # is drawn by a multitude of straight lines.
    dat.gg <- circleLayoutVertices(packing, npoints=50)
    
    # Make the plot
    ggplot() + 
      
      # Make the bubbles
      geom_polygon(data = dat.gg, aes(x, y, group = id, fill=as.factor(id)), colour = "black", alpha = 0.6, text = data.1$State ) +
      
      # Add text in the center of each bubble + control its size
      geom_text(data = data.1, aes(x, y, size=Thousands.of.Megawatts, label = State)) +
      scale_size_continuous(range = c(1,4)) +
      
      # General theme:
      theme_void() + 
      theme(legend.position="none") +
      coord_equal()+
              coord_fixed()+
      ggtitle("Total Energy used by each State\nIn Thousands of Megawatts")
      
      
      
  })
  
  
  output$max.slider <- renderUI({
    sliderInput("change.max", "Variable Max", min=0, max=max(data.both[,input$hist.var.c]), value=max(data.both[,input$hist.var.c]))
  })
  
  output$min.slider <- renderUI({
    sliderInput("change.min", "Variable Min", max=0, min=min(data.both[,input$hist.var.c]), value=min(data.both[,input$hist.var.c]))
  })
  
  output$changePlot <- renderPlotly({
    # Filter data
    if(input$remove == T)
    {
      chart.data <- data.both %>% 
        filter(data.both[,input$hist.var.c] != 0,
               input$change.max >= data.both[,input$hist.var.c],input$change.min <= data.both[,input$hist.var.c])
      
    }
    else
    {
      chart.data <- data.both %>% 
        filter(input$change.max >= data.both[,input$hist.var.c])%>% 
        filter(input$change.min <= data.both[,input$hist.var.c])
    }
    m <- list(
      l = 50,
      r = 50,
      b = 50,
      t = 50,
      pad = 4
    )
    
    
    p <- plot_ly(chart.data, x = ~reorder(State, chart.data[,input$hist.var.c]), y = chart.data[,input$hist.var.c], type = 'bar',
                 color = chart.data$Winning.Party.x, colors = c('blue','red')) %>% 
      layout(yaxis = list(title = 'Thousands of MegaWatts'), font = list(size = 8, color = 'white'), 
             xaxis = list(title = "", tickangle = -35),
             title = "The change from 2015 to 2016")%>% 
      layout(paper_bgcolor="#272b30") %>% 
      layout(plot_bgcolor="#272b30") %>% 
      layout(autosize = F, width = 500, height = 400, margin = m)
  })
  
  ######Scatter######
  output$scatterPlot <- renderPlotly({
    # Filter data
    
    chart.data <- data %>% 
      filter(input$pop >= Population) %>% 
      filter(input$watt >= total)
    
    # Make chart
    if(input$conf == T)
    {
      conf = T
    }
    else{
      conf = F
    }
    if(input$unsure == T)
    {
      chart.data[chart.data == 0] <- NA
    }
    
    ScatterGraph(data.frame = chart.data,
                 x.var = 'Population', 
                 y.var = input$energy.type,
                 colorVar = 'Winning.Party', 
                 title = 'Energy Vs Population',
                 x.lab = "Population",
                 y.lab = "Energy Consumption (Thousand Mega Watts)",
                 legend = "State's Party",
                 confidence = conf,
                 type = input$regression,
                 per.person = input$per)
  })
  
  
  
  
  ######MAP######
  
  output$pie.1 <- renderPlotly({
    
    PieChart(data.frame = data,
             state.name = input$first.state,  
             legend.title = "Energy Type", 
             plot.title = paste(input$first.state, "Energy Type"))
  })
  output$pie.2 <- renderPlotly({
    
    PieChart(data.frame = data,
             state.name = input$second.state, 
             legend.title = "Energy Type", 
             plot.title = paste(input$second.state, "Energy Type"))
  })
  
  
  #these two compare to the input slider, but I want to compare to the new slider in the output
  #i need to change the input$vairable.max variable to the output variable
  output$slider <- renderUI({
    sliderInput("new.variable.max", "Variable Max", min=0, max=max(data[,input$compare]), value=max(data[,input$compare]))
  })
  
  output$map <- renderPlotly({
    
    if(input$political == 0){
      chart.data <- data %>%
        filter(data[,input$compare] <= input$new.variable.max)
    }
    else{
      chart.data <- data %>%
        filter(data[,input$compare] <= input$new.variable.max) %>% 
        filter(input$political == Winning.Party)
    }
    if(input$map.zero == F)
    {
      chart.data[chart.data == 0] <- NA
    }
    
    
    #creates reactive slider that changes range depending on what variable was chosen to compare
    #can't call output values in server
    
    
    CreateMap(chart.data, input$compare)
    
  })
  
})