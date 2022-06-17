compare_3year_trend <- function(df = Covid_19, Datesel = ymd(20200101), NYears = 3){

   # options(dplyr.summarise.inform=F)

library(dplyr)

   trimmed_Covid19 <-  Covid_19 %>% filter(date >= Datesel %m+% months(1) & date >= Datesel)

   grouped_continents <- trimmed_Covid19 %>% group_by(continent) %>% pull(continent) %>% unique()



    trimmed_Covid19 <-  trimmed_Covid19 %>% filter(continent %in% grouped_continents)%>%
       mutate(YM = format(date,"%Y-%B")) %>% group_by(continent, YM) %>%
    filter(date ==last(date))



}

#tidy up data
Covid19_compare <-  trimmed_Covid19 %>% group_by(date, continent) %>%
    summarize(total_cases = sum(total_cases), total_deaths = sum(total_deaths))


g <- Covid19_compare %>%
    # Initialize the canvas:
    ggplot() +
    # Now add the aesthetics:
    geom_line(aes(x = date, y = total_cases, color =continent), alpha = 0.8,
              size = 1)
g






#g <- g + facet_wrap(~continent)

#g






#head(covid_new)
