#load libraries
library(rio)
library(dplyr)
library(tidyr)

#format population csv to only include state and population
population <- read.csv("./data/Sheet1-Table 1.csv")
population <- population[,c(1:3)]
colnames(population) <- c("State","Votes","Population")
population <- population %>% select(State,Population)

#get party info
party <- read.csv("./data/2016 Electoral Votes.csv")

<<<<<<< HEAD
#change energy info to have states as rows and types of energy as columns
energy <- import("./data/Net_generation_for_all_sectors.csv") %>% 
  select(description, 'source key', as.character(2016))%>% 
  mutate('source key' = substr(energy$`source key`, 10, 12)) 
  
=======
#change energy info to have each state as rows and amount of each type of energy as columns
energy <- import("./data/Net_generation_for_all_sectors.csv") 
energy.2 <- energy %>% select(description, 'source key', as.character(2016)) %>% 
  mutate('source key' = substr(energy$`source key`, 10, 12)) %>% 
  mutate(State = gsub( " :.*$", "", energy$description)) %>% 
  select(State, 'source key', as.character(2016))
unwanted.state<- energy.2[!energy.2$State %in% state.name,]
energy.2 <- energy.2[!energy.2$State == unwanted.state, ]
colnames(energy.2) <- c("State","Type","Thousand Megawatthours")
unwanted.types <- c(".A","ALL","AOR")
energy.2 <- energy.2[!energy.2$Type %in% unwanted.types, ]
datafr <- spread(energy.2, key = Type, value ='Thousand Megawatthours')
>>>>>>> b03356847100630dc2de505b86149114d817f7eb

#join data
joined <- party %>% left_join(population) %>% left_join(datafr)
joined[is.na(joined)] <- "--"
