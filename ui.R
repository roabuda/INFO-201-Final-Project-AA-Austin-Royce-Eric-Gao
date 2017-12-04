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
  

  tabPanel("Map",
           sidebarLayout(
             sidebarPanel(
               sliderInput("min",
                           "Amount of energy:",
                           min = 0,
                           max = 1000000,
                           value = 0),
               sliderInput("max",
                           "Amount of energy:",
                           min = 0,
                           max = 1000000,
                           value = 10000)
             ),
             mainPanel(
               plotlyOutput("map")
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
                                          "Hydroelectric" = "HYC",
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
                           "Maximum Population:",
                           min = 0,
                           max = max(data$Population),
                           value = max(data$Population)),
               sliderInput("watt",
                           "Maximum Wattage:",
                           min = 0,
                           max = max(data$total),
                           value = max(data$total)),
               selectInput("energy.type", 
                           "Energy Type",
                           list("All" = "total",
                                "Coal" = "COW",
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
                           ) ),
               selectInput("per", 
                           "Thousands of Mega Watts per person",
                           list("False" = F,
                             "True" = T
                           ) ),
               
               selectInput("conf", 
                            "Confidence line",
                            list("On" = T,
                            "Off"= F
                            ) ),
               selectInput("regression",
                           "Regression Type",
                           list("Linear" = "lm",
                                "Curve" = "auto",
                                "None" = F) ),
           selectInput("unsure", 
                       "Remove Zero and NA Consumption",
                       list("On" = T,
                            "Off"= F
                       )
                 
               )
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
        
