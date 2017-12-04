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
      h5("-Do more populated states use more clean energy than those that aren’t as populated?
          -Does the energy consumption by each state corrolate to its political inclination?
          -What energy is used the most in each state?"),
      h3("Structure"),
      h5("Our tabs include: an interactive map that shows the political inclination of each state and will also display energy information in the form of a pie chart when you hover over each state, a histogram that displays the amount of energy use per state, and a scatter plot that shows the wattage for a population."),
      h3("Creators"),
      h5("Austin Chan, Xiaxuan Gao, Royce Abuda, Eric Acero")
      )
      ),

  tabPanel("Map",
           sidebarLayout(
             sidebarPanel(
               sliderInput("",
                           "Amount of energy:",
                           min = 0,
                           max = 1000000,
                           value = 0),
               selectInput("political", "Political Side", 
                           choices = list("Both" = 0,
                                          "Republicans" = "Republicans",
                                          "Democrats" = "Democrats"
                           )
               )
             ),
             mainPanel(
               plotlyOutput("map"),
               h3("What does the Map represent?"),
               h5("When using the interactive map, you are able to see the political inclination of each state and how it corrolates to the energy use. You can also see the population of each state when you hover over each state with the coursor."),
               h5("You can adjust the information being displayed by adjusting the Range widget and the Select dropbox that gives you the option to choose to display the Democratic or Republican states or both.")
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
               plotlyOutput("histPlot"),
               h3("What does the Histogram display?"),
               h5("In this histogram, we are able to see the different energies independently and how much each state consumed each of them in the year 2016. You just have to select the energy you wish to display from the Select dropbox and the histogram will be modified to show you the consumption of that energy in each state.")
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
               plotlyOutput("scatterPlot"),
               h3("What does the Scatter Plot show?"),
               h5("The interactive Scatter Plot above shows the Energy Consumption in wattage and how it corrolates to the population. When you hover over the dots you will come to realize that they are the representation of the states."),
               h5("You can change the Scatter Plot to display different data by adjusting the Range widgets or the Select dropboxes. ")
             )
           )
  ),
  tabPanel("Sources",
  
  mainPanel(
    h3("These are the data resources that we used for the purpose of this report:"),
    h1(" "),
    h4("US Energy Information Administration"),
    h5("https://www.eia.gov/"),
    h4("data.world"),
    h5("https://data.world/dash/2016-electoral-college-results"),
    h4("United States Census Bureau"),
    h5("https://www.census.gov/data/tables/2016/demo/popest/state-total.html")
    )
  )
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
        
