
Covid_19$total_deaths[is.na(Covid_19$total_deaths)] <- 0
Covid_19$total_cases[is.na(Covid_19$total_cases)] <- 0
Covid_19$continent[Covid_19$continent==0] <- NA
