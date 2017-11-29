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

raw.data <- read.csv('./data/cereal.csv', stringsAsFactors = FALSE)
raw.data <- raw.data %>% 
  select(Participant.ID, Response, Poll.Title)

data <- spread(raw.data, key=Poll.Title, value=Response)
colnames(data) <- c('id', 'pet', 'sleep', 'ta.help', 'raingear')



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderPlotly({
    # Filter data
    chart.data <- data %>% 
      filter(as.numeric(sleep) > as.numeric(input$hours))
    
    # Make chart
    plot_ly(x = chart.data$ta.help, 
            y = as.numeric(chart.data$sleep),
            color = chart.data$pet,
            type="scatter") %>% 
      layout(xaxis=list(title="TA Help")) 
  })
  
  output$histPlot <- renderPlotly({
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