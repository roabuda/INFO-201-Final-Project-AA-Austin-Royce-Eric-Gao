#load libraries
library(rio)
library(dplyr)

#format population csv to only include state and population
population <- read.csv("./data/Sheet1-Table 1.csv")
population <- population[,c(1:3)]
colnames(population) <- c("State","Votes","Population")
population <- population %>% select(State,Population)

#get party info
party <- read.csv("./data/2016 Electoral Votes.csv")

#change energy info to have states as rows and types of energy as columns
energy <- import("./data/Net_generation_for_all_sectors.csv") %>% 
  select(description, 'source key', as.character(2016))%>% 
  mutate('source key' = substr(energy$`source key`, 10, 12)) 
  

#join data
joined <- party %>% left_join(population)
