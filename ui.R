#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

my.ui <- navbarPage(
  
  # Application title
  "Cereal Data",
  
  # Sidebar with a slider input for number of bins 
  tabPanel("Map",
           sidebarLayout(
             sidebarPanel(
               sliderInput("energy",
                           "Amount of energy:",
                           min = 0,
                           max = 24,
                           value = 4)
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("distPlot")
             )
           )
  ),
  tabPanel("Histogram",
           sidebarLayout(
             sidebarPanel(
               selectInput('hist.var', "What do you want to histogram?", 
                           choices = list("How much energy" = "sleep",
                                          "Which type of energy?" = "pet"
                           )
               )
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("histPlot")
             )
           )
  ),
  tabPanel("ScatterPlot",
           sidebarLayout(
             sidebarPanel(
               sliderInput("energy",
                           "Amount of energy:",
                           min = 0,
                           max = 24,
                           value = 4)
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("distPlot")
             )
           )
  )
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
        
