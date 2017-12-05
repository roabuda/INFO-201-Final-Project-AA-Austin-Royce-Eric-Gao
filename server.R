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
source('./scripts/Scatter_Graph_Function.R')
source('./scripts/histogram.R')
source('./scripts/map.R')
source('./scripts/Pie_Chart_Function.R')

data <- read.csv("./data/joined.csv", stringsAsFactors = F)

######Histograph######
shinyServer(function(input, output) {
  output$histPlot <- renderPlotly({
    # Filter data
    chart.data <- data %>% 
      filter(data[,input$hist.var] > 0)
      
    # Make chart
    HistogramLineGraph(data.frame = chart.data,
                   y.var = input$hist.var, 
                   my.title = "Energy Consumption",
                   bar.title  = input$hist.var,
                   line.title  = input$hist.var)
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
