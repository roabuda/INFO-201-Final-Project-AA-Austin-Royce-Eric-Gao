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
data <- read.csv("./data/joined.csv", stringsAsFactors = F)
data.both <- read.csv("./data/joined_new.csv", stringsAsFactors = F)
my.ui <- fluidPage(theme = shinytheme("slate"),

navbarPage(
  
  # Application title
  "Energy of America",
  

  # The title page for the app that mentions what our project is about
  tabPanel("Introduction",
      tags$blockquote(
        h2("Energy Consumption in the United States"),
          tags$hr(),
        plotlyOutput("bubble", width = "100%",height = "400px")
      ),
        tags$blockquote(
        h3("Project Overview"),
        h5("For our project, we wanted to observe the use of energy throughout the United States and to see how it correlated to the political inclination and population of each state. We were able to observe this connection with the use of three data sets that we later combined into one."),
        h3("Audience"),
        h5("Our target audience for our Final Project are people interested in seeing energy usage and its correlation to political inclination and population, such as environmentalists and civil activists. With this data, activists can focus their resources on certain states and potentialy know which party to lobby. This could help Americans think of potentially better ways to address energy usage on a state by state basis."),
        h3("Data"),
        h5("For our data, we used a data list from the US Energy Information Administration that included all the energy usage data throughout the states from 2016. We also got the electoral college results from the 2016 election from data.world. Population data was from the United states Census Bureau. All data unless otherwise noted is from 2016."),
         h3("Questions"),
        h5("-Do more populated states use more clean energy than those that aren’t as populated?",
           tags$br(),
            "-Does the energy consumption by each state correlate to its political inclination?",
           tags$br(),
            "-Does energy usage and population have a linear relationship?"),
        h3("Structure"),
        h5("Our tabs include: an interactive map that shows the political inclination of each state and will also display energy information in the form of a pie chart, 
           a histogram that displays the amount of energy use per state, a bar graph that displays the change in energy usage from 2015 to 2016, 
           and a scatter plot that shows the wattage for a population."),
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
  tabPanel("Why This Matters?",
           tags$blockquote(
             h3("Global Warming...Climate Change...it's real"),
             tags$hr(),
             tags$img(src = "https://www.carbonbrief.org/wp-content/uploads/2016/05/Stock-Fort-McMurray.jpg", width = "100%",height = "300px"),
              tags$div("In our world today, we are faced with the issue commonly known as Global Warming."),
                tags$br(),
                  tags$div("It is as it sounds-- the warming of our world. This is detrimental to us in the sense that with our climate rising in temperature, our polar ice caps are melting and therefore, the ocean levels are rising as well. This affects the coasts of all the continents and could leave millions, if not billions homeless if the ocean levels flooded major cities."),
                    tags$br(),
                      tags$div("The reason the Earth is heating up is because of carbon emissions and other natural gases that get released into our atmosphere every single day. Since the Industrial Revolution, factories, power plants and then later cars have released these gases that trap the Sun's energy in our atmosphere and prevent it from escaping into space as it should. This in return heats up the Earth. This is known as the Green House Effect."),
                        tags$br(),
                          tags$div("And it's not just us humans being affected. Animals could go extinct if their habitats are affected by the global climate change. Polar Bears are Endangered Species to this date with the melting of the northern ice cap. Animals are having to migrate to different areas of the world to try and save their existence. But sometimes the transition to a new territory isn't so smooth. They might not get used to the new environment or they might act as an invasive species that could dismantle the food chain in that territory. In the end, all of this are the repercussions of global warming. We are altering the balance of nature and in return we will end up not only causing the extinction of animals, but also our own."),
                            tags$br(),
                              tags$div("This report was created with the intention of presenting the various uses of energy here in the United States, and to show how we still heavily use energies that are damaging to our world today.")
            )
          ),

  tabPanel("Map/Pie Chart",
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
               h3("What does the Map represent?"),
               h5("When using the interactive map, you are able to see the 2016 electoral college results of each state to portray their political inclination at the time. You can also see the state data about the variable you want to compare. The energy is measured in Thosands of Megawatts"),
               h5("You can adjust the information being displayed through the widgets to choose what
                  variable to compare between each state, whether that be a type of energy or population.
                  You can also choose the maximum value and whether to include zero values or exclude them
                  as NA values."),
               plotlyOutput("map"),
               h3("What do the Pie Charts represent?"),
               h5("If you want to compare states energy usages individually, you can 
                  select two states to see percantages of how much of each type of energy is used."),
               splitLayout(cellWidths = c('50%','50%'),
                           plotlyOutput("pie.1", height = 500),
               plotlyOutput("pie.2", height = 500)),
               plotlyOutput("usa.energy", width = "60%", height = 600)
              
             
               )
           )
  ),
  
  
  tabPanel("Histogram",
           sidebarLayout(
             sidebarPanel(
               selectInput("hist.var", "Energy Type", 
                           choices = list(
                                          "All" = "total",
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
                                          "Wind" = "WND"
                           )
               ),
               uiOutput("slider2")
             ),

             # Show a plot of the generated distribution
             mainPanel(
               h3("What does the Histogram display?"),
               h5("In this histogram, we are able to see the seperate types of energies and how much each state consumed of each in 2016. You can select the energy you wish to display from the dropbox and the histogram will show you the consumption of that energy in each state. The energy is measured in Thosands of Megawatts."),
               
               plotlyOutput("histPlot", width = "100%", height = "800px")
               )
           )
  ),
  
  tabPanel("Change in Energy Usage",
           sidebarLayout(
             sidebarPanel(
               selectInput("hist.var.c", "Energy Type", 
                           choices = list(
                                          "All" = "total.c",
                                          "Coal" = "COW.c",
                                          "Biomass" = "BIO.c",
                                          "Geothermal" = "GEO.c",
                                          "Hydroelectric" = "HYC.c",
                                          "Natural Gas" = "NG..c",
                                          "Nuclear" = "NUC.c",
                                          "Other Gases" = "OOG.c",
                                          "Petrolium Coke" = "PC..c",
                                          "Petrolium Liquids" = "PEL.c",
                                          "Solar" = "TSN.c",
                                          "Wind" = "WND.c"
                           )
                
                           
               ),
               selectInput("remove", "Remove Zero Change", 
                          choices = list("Yes"= T,
                                         "No" = F
                          )
               ),
               uiOutput("max.slider"),
               uiOutput("min.slider")
             ),
             
             # Show a plot of the generated distribution
             mainPanel(
               h3("What does this Bar Graph display?"),
               h5("This bar graph shows the change in energy consumption from 2015 to 2016. The energy is measured in Thosands of Megawatts and depicts both the increase and decrease in energy usage by state. You can select the range of wattage as well as the energy type to be displayed."),
               plotlyOutput("changePlot", width = "100%")
               
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
               h3("What does the Scatter Plot show?"),
               h5("The interactive Scatter Plot above shows the Energy Consumption in wattage and how it corrolates to the population. When you hover over the dots you will come to realize that they are the representation of the states."),
               h5("You can change the Scatter Plot to display different data by adjusting the Range widgets or the Select dropboxes. "),
               plotlyOutput("scatterPlot")
               
             )
           )
  ),
  tabPanel("Analysis",
           h4("	From our data displayed in this report, we observed various correlations between the energy, population, and political inclination of each state. For instance, we noticed in our Scatter Plot that when the population is high, the energy usage per person is generally lower, resulting in the state to be more efficient. Also, another note worthy comment that should be addressed is that the Republican states tend to use more energy than the Democratic states."), 
	          tags$br(),   
              h4("From our Change in Energy Usage bar graph, we see that fossil fuels usage are decreasing in many states between 2015 and 2016. Despite the drop in use per state, the US still primarily uses coal as its main energy source."),
                tags$br(),
                  h4("From our bubble chart and histogram, we see that Texas is the state that uses the most energy overall. Texas happens to be Republican and its main energy us is Natural Gases.")
                    
  ),
  tabPanel("Sources",
  
  mainPanel(
    tags$blockquote(
      h3("These are the data resources that we used for the purpose of this report:"),
        tags$hr(),
      h1(" "),
      h4("US Energy Information Administration"),
        tags$a(href="https://www.eia.gov/", "Click here for the link"),
      h4("data.world"),
        tags$a(href="https://data.world/dash/2016-electoral-college-results", "Click here for the link"),
      h4("United States Census Bureau"),
        tags$a(href="https://www.census.gov/data/tables/2016/demo/popest/state-total.html", "Click here for the link")
        )
    )
  )
)
)
# Define UI for application that draws a histogram
shinyUI(my.ui)
        
