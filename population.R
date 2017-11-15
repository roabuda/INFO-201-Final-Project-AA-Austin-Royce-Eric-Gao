setwd("~/Desktop/FInal project")
library(dplyr)
library(shiny)
library(ggplot2)
library(rio)


raw.population.data <- import("./sub-est2016_all.csv")
population.data <- raw.population.data %>% 
  filter(STNAME == NAME) %>% 
  select(NAME,POPESTIMATE2016)
  