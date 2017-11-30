#load libraries
library(rio)
library(dplyr)
library(tidyr)

#format population csv to only include state and population and remove DC
population <- read.csv("./data/Sheet1-Table 1.csv",stringsAsFactors = FALSE)
population <- population[,c(1:3)]
colnames(population) <- c("State","Votes","Population")
population <- population %>% select(State,Population)
population <- population[3:53,] %>% na.omit()


#get party info and remove DC
party <- read.csv("./data/2016 Electoral Votes.csv",stringsAsFactors = FALSE)
#rename louisiana because it was mispelled
party[18,"State"] <- "Louisiana"



#change energy info to have each state as rows and amount of each type of energy as columns and remove DC
energy <- import("./data/Net_generation_for_all_sectors.csv",stringsAsFactors = FALSE) 
selected.energy <- energy %>% select(description, 'source key', as.character(2016)) %>% 
  mutate('source key' = substr(energy$`source key`, 10, 12)) %>% 
  mutate(State = gsub( " :.*$", "", energy$description)) %>% 
  select(State, 'source key', as.character(2016)) 

colnames(selected.energy) <- c("State","Type","Thousand Megawatthours")
unwanted.types <- c(".A","ALL","AOR")
selected.energy <- selected.energy[!selected.energy$Type %in% unwanted.types, ]
selected.energy <- selected.energy %>% filter(State %in% state.name)

#final energy use spread function
final.energy <- spread(selected.energy, key = Type, value ='Thousand Megawatthours')

#join data and change NA to -- and remove DC and remove a second Maine row
joined <- party %>% left_join(population, by = "State") %>% 
left_join(final.energy, by = "State")
joined[is.na(joined)] <- "--"
joined <- joined[!joined$State == "District of Columbia", ]
joined <- joined[-(20),]
joined[joined == "--" | joined == "NM"] <- 0
joined <- joined %>% 
  mutate(BIO = as.numeric(BIO)) %>% 
  mutate(COW = as.numeric(COW)) %>% 
  mutate(GEO = as.numeric(GEO)) %>% 
  mutate(HYC = as.numeric(HYC)) %>% 
  mutate(`NG-` = as.numeric(`NG-`)) %>% 
  mutate(NUC = as.numeric(NUC)) %>% 
  mutate(OOG = as.numeric(OOG)) %>% 
  mutate(`PC-` = as.numeric(`PC-`)) %>% 
  mutate(TSN = as.numeric(TSN)) %>% 
  mutate(WND = as.numeric(WND)) %>% 
  mutate(total = BIO +COW +GEO + HYC +`NG-`+NUC+OOG+`PC-`+TSN+WND)%>% 
  mutate(Population = as.numeric(gsub( "[[:punct:]]" , "",Population)))
  

#export as csv
export(joined,"./data/joined.csv", format = "csv")
