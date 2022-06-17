#Cause_of_death_corr <- function(df = Cause_of_Death, Datesel1 = ymd(19900101), NYears = 29){

    #options(dplyr.summarise.inform=F)

#Cause_of_Death <- Data(Datroot = "data/Covid/Deaths_by_cause.csv")

#Malaria <- Cause_of_Death %>% group_by(`Entity`) %>% summarise_at( vars( c(`Year`, starts_with("Deaths - Tuberculosis")) %>%
#gather(-`Entity`, -`Year`) %>% mutate(Entity = gsub("Explained by: ", "", Entity))