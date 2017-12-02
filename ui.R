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
  "Energy of America",
  
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
               selectInput("hist.var", "What do you want to histogram?", 
                           choices = list("Coal" = "COW",
                                          "Biomass" = "BIO",
                                          "Geothermal" = "GEO",
                                          "Hydroelectric" = "BIO",
                                          "Natural Gas" = "NG.",
                                          "Nuclear" = "NUC",
                                          "Other Gases" = "OOG",
                                          "Petrolium Coke" = "PC.",
                                          "Petrolium Liquids" = "PEL",
                                          "Solar" = "TSN",
                                          "Wind" = "WND"
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
               sliderInput("pop",
                           "min pop:",
                           min = 0,
                           max = max(data$Population),
                           value = c(min(data$Population),max(data$Population)))
             ),
            
             # Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("scatterPlot")
             )
           )
  )
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
        
