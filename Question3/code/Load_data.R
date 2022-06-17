library(magrittr)
library(tidyverse)

data <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_matches_1968.csv')

for (i in 1969:2020) {
    data <- rbind(data,
                  read_csv(paste('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_matches_',
                                 i, '.csv', sep = '')))
}

rankings <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_rankings_70s.csv')
rankings_80s <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_rankings_80s.csv')
rankings_90s <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_rankings_90s.csv')
rankings_00s <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_rankings_00s.csv')
rankings_10s <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_rankings_10s.csv')
rankings_20s <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_rankings_current.csv',
                         col_names = c("ranking_date","rank", "player","points"))

rankings <- rbind(rankings, rankings_80s, rankings_90s, rankings_00s, rankings_10s, rankings_20s)
rm(rankings_80s, rankings_90s, rankings_00s, rankings_10s, rankings_20s)


## players - needed mostly for exacting the players' date of birth (retrieved 3.01.2020 at 21:54 CET)

players <- read_csv('https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/atp_players.csv',
                    col_names = c("player_id", "first_name", "last_name", "hand", "birth_date", "country_code"))


#### data preprocessing ####

## We will need to change the date format (in all of the data frames).
## We will also unify the naming conventions, making `player_id` stand for player ID, and `player`
## for his name and surname.

players %<>%
    mutate(birth_date = as.Date(as.character(birth_date), '%Y%m%d')) %>%
    unite(player, c("first_name", "last_name"), sep = " ")

## In the players datset there are many minor players, who

## In the rankings data frame we will restrict it to only top 100 players for each ranking week,
## which helps significantly (~15x) reduce the size of the object.
## We will also change date format and naming convention.
## It will be convenient to add players names (from the players df) also in the rankings data frame.

rankings %<>%
    filter(rank < 101) %>%
    mutate(ranking_date = as.Date(as.character(ranking_date), '%Y%m%d')) %>%
    arrange(ranking_date, rank) %>%
    rename(player_id = player) %>%
    left_join(players %>%  select(player_id, player), by = "player_id")



#library(dplyr)
#rankings <-
  #  list.files(path = "c:/Users/Cabous/OneDrive/Desktop/22017542/Question3/data/Tennis/",
 #              pattern = "*0s.csv",
 #              full.names = T) %>%
 #   map_df(~read_csv(., col_types = cols(.default = "c")))

#players <- read_csv("data/Tennis/atp_players.csv")
