setwd("~/Desktop/INFO-201-Final-Project-AA-Austin-Royce-Eric-Gao/")
library(dplyr)
library(shiny)
library(ggplot2)
library(rio)


raw.population.data <- import("./data/sub-est2016_all.csv")
population.data <- raw.population.data %>% 
  filter(STNAME == NAME) %>% 
  select(NAME,POPESTIMATE2016)
  