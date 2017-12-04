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
  
  # The title page for the app that mentions what our project is about
  tabPanel("Introduction",
 
    mainPanel(
      h2("Energy Consumption in the United States"),
      h3("Project Overview"),
      h5("For our project, we wanted to observe the use of energy throughout the United States and to see how it corrolated to the political inclination and population of each state. We were able to observe this connection with the use of two data sets that we later combined into one."),
      h3("Audience"),
      h5("Our target audience for our Final Project are people interested in energy usage and its correlation to seemingly unrelated things (political inclination and population), such as environmentalists. Environmentalists would be interested in this data because it could help them understand why possibly harmful energy (fossil fuels) are used more in certain states versus clean energy usage. This could help think of better ways to address energy usage depending on which state has a bigger problem with the kind of energy they’re using."),
      h3("Data"),
      h5("For our data, we used a data list from the US Energy Information Administration that included all the energy usage data throughout the states from 2016. We also got the electoral college results from the 2016 election from data.world."),
      h3("Questions"),
      h5("-Do more populated states use more clean energy than those that aren’t as populated?",<b/r>,
          "-Does the energy consumption by each state corrolate to its political inclination?",<b/r>,
          "-What energy is used the most in each state?
         ")
      )
      ),
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
                                          "Hydroelectric" = "HYC",
                                          "Natural Gas" = "NG.",
                                          "Nuclear" = "NUC",
                                          "Other Gases" = "OOG",
                                          "Petrolium Coke" = "PC.",
                                          "Petrolium Liquids" = "PEL",
                                          "Solar" = "TSN",
                                          "Wind" = "WND",
                                          "All" = "total"
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
  ),
  tabPanel("Sources",
  
  mainPanel(
    h3("US Energy Information Administration"),
    h4("(https://www.eia.gov/)"),
    h1(""),
    h4("Sixth level title")
    )
  )
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
        
