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
library(shinythemes)

my.ui <- fluidPage(theme = shinytheme("slate"),

navbarPage(
  
  # Application title
  "Energy of America",
  

  # The title page for the app that mentions what our project is about
  tabPanel("Introduction",
 
    mainPanel(
      h2("Energy Consumption in the United States"),
        tags$hr(),
          tags$img(src = "https://www.carbonbrief.org/wp-content/uploads/2016/05/Stock-Fort-McMurray.jpg", width = "800px", height = "300px"),
      h3("Project Overview"),
      h5("For our project, we wanted to observe the use of energy throughout the United States and to see how it correlated to the political inclination and population of each state. We were able to observe this connection with the use of two data sets that we later combined into one."),
      h3("Audience"),
      h5("Our target audience for our Final Project are people interested in energy usage and its correlation to seemingly unrelated things (political inclination and population), such as environmentalists. Environmentalists would be interested in this data because it could help them understand why possibly harmful energy (fossil fuels) are used more in certain states versus clean energy usage. This could help think of better ways to address energy usage depending on which state has a bigger problem with the kind of energy they’re using."),
      h3("Data"),
      h5("For our data, we used a data list from the US Energy Information Administration that included all the energy usage data throughout the states from 2016. We also got the electoral college results from the 2016 election from data.world."),
      h3("Questions"),
      h5("-Do more populated states use more clean energy than those that aren’t as populated?",
         tags$br(),
          "-Does the energy consumption by each state correlate to its political inclination?",
         tags$br(),
          "-What energy is used the most in each state?"),
      h3("Structure"),
      h5("Our tabs include: an interactive map that shows the political inclination of each state and will also display energy information in the form of a pie chart when you hover over each state, a histogram that displays the amount of energy use per state, and a scatter plot that shows the wattage for a population."),
      h3("Creators"),
      h5("Austin Chan",
          tags$br(),
           "Xiaxuan Gao", 
          tags$br(),
           "Royce Abuda", 
          tags$br(),
           "Eric Acero")
      )
      ),

  tabPanel("Map",
           sidebarLayout(
             sidebarPanel(
               selectInput("compare", "Variable to Compare",
                                       choices = list("Population" = "Population",
                                                      "Total Energy Consumption" = "total",
                                                      "Coal" = "COW",
                                                      "Biomass" = "BIO",
                                                      "Geothermal" = "GEO",
                                                      "Hydroelectric" = "HYC",
                                                      "Natural Gas" = "NG.",
                                                      "Nuclear" = "NUC",
                                                      "Other Gases" = "OOG",
                                                      "Petrolium Coke" = "PC.",
                                                      "Petrolium Liquids" = "PEL",
                                                      "Solar" = "TSN",
                                                      "Wind" = "WND")),
               

               uiOutput("slider"),
               
               selectInput("map.zero", "Show Zero Values", 
                           choices = list(
                             "Yes" = T,
                             "No" = F)),
               
               selectInput("political", "Political Side", 
                           choices = list("Both" = 0,
                                          "Republicans" = "Republicans",
                                          "Democrats" = "Democrats")),
           
               selectInput("first.state", "First State", 
                           choices = state.name),
           
               selectInput("second.state", "Second State", 
                           choices = state.name)
             ),
             mainPanel(
               plotlyOutput("map"),
               plotlyOutput("pie.1"),
               plotlyOutput("pie.2"),
               h3("What does the Map represent?"),
               h5("When using the interactive map, you are able to see the 2016 electoral college
                  results of each state to portray their political inclination at the time. You can also 
                  see the state data about the variable you want to compare."),
               h5("You can adjust the information being displayed through the widgets to choose what
                  variable to compare between each state, whether that be a type of energy or population.
                  You can also choose the maximum value and whether to include zero values or exclude them
                  as NA values. If you want to compare states energy usages individually, you can 
                  select 2 states to see percantages of how much of each type of energy is used.")
             
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
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
        
