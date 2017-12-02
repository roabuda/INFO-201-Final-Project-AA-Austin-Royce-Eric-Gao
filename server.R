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


data <- read.csv("./data/joined.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$histPlot <- renderPlotly({
    # Filter data
    chart.data <- data 
      
    # Make chart
    HistogramGraph(data.frame = chart.data,
                   y.var = input$hist.var, 
                   my.title = "Energy Consumption",
                   y.lab = input$hist.var,
                   legend.title = input$hist.var)
  })
  
  
  output$scatterPlot <- renderPlotly({
    # Filter data
    chart.data <- data %>% 
      filter(input$pop > Population)
    
    # Make chart
    ScatterGraph(data.frame = chart.data,
                 x.var = 'Population', 
                 y.var = 'total',
                 colorVar = 'Winning.Party', 
                 title = 'Energy Vs Population',
                 x.lab = "Population",
                 y.lab = "Energy Consumption (Thousand Mega Watts)",
                 legend = "State's Party")
  })
  
  output$distPlot <- renderPlotly({
    if(input$hist.var == 'sleep') {
      chart.data <- as.numeric(data[,input$hist.var])
    } else {
      chart.data <- data[,input$hist.var]
    }
    # Make chart
    plot_ly(x = chart.data, 
            type="histogram") %>% 
      layout(xaxis=list(title=input$hist.var)) 
  })
  
})