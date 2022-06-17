
plotDaysTakenToReachRank2 <- function(data, ranking = 1,col1="#a3c4dc",col2="#0e668b") {
    library(lubridate)
    options(dplyr.summarise.inform=F)

    df <- rankings %>% select(player, ranking_date, rank) %>%
        mutate(player = ifelse(player %in% c("Roger Federer", "Rafael Nadal", "Novak Djokovic", "Andy Murray"),paste0(player, "*"),player)) %>%
        mutate(ranking_date = as.Date(ranking_date)) %>%
        arrange(ranking_date) %>%
        group_by(player) %>%
        mutate(first_entry = first(ranking_date)) %>% filter(rank == ranking) %>%
        group_by(player) %>%
        filter(ranking_date == min(ranking_date),
               player %in% c("Bjorn Borg",
                             "Ivan Lendl",
                             "Andre Agassi",
                             "Pete Sampras",
                             "Roger Federer*",
                             "Rafael Nadal*",
                             "Novak Djokovic*")) %>%
        slice(1) %>% # takes the first occurrence if there is a tie
        mutate(time_taken = difftime(as.Date(ranking_date), as.Date(first_entry), units = "days")) %>%
        filter(time_taken>0) %>%
        select(!rank) %>%
        ungroup()

    df %>% arrange(desc(time_taken)) %>%
        ggplot(aes(x=first_entry, xend=ranking_date, y=reorder(player,-time_taken), group=player)) +
        geom_dumbbell(color=col1,
                      size=2,
                      colour_xend =col2) +
        labs(x="Year",
             y=NULL,
             title=sprintf("Time taken to reach rank %s", ranking),
             subtitle="Counted from first appearance in ranking to the first appearance as rank 1.",
             caption="Active players are marked with *") +
        geom_text(aes(x=first_entry, y=reorder(player,-time_taken), label=first_entry),
                  color=col2, size=3.5, vjust=1.4,) +
        geom_text(color=col2, size=3.5, vjust=-1,
                  aes(x=ranking_date, y=reorder(player,-time_taken), label=ranking_date))+
        geom_rect(aes(
            xmin = as.Date("2018-01-01"),
            xmax = as.Date("2022-01-01"),
            ymin = -Inf,
            ymax = Inf
        ), fill = "#b4d3e9") +
        geom_text(
            aes(
                label = time_taken,
                y = reorder(player,-time_taken),
                x = as.Date("2020-01-01")
            ),
            fontface = "bold",
            size = 3,
        ) +
        geom_text(data=filter(df, time_taken== min(time_taken)),
                  aes(x=as.Date("2020-01-01"), y=reorder(player,-time_taken), label="No. Days"),
                  color="black", size=3.1, vjust=-0.6, fontface="bold")+
        theme(
            panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            panel.border=element_blank(),
            axis.ticks=element_blank(),
            axis.text.x=element_blank(),
            plot.title=element_text(size = 16, face="bold"),
            plot.title.position = "plot",
            plot.subtitle=element_text(face="italic", size=12, margin=margin(b=12)),
            plot.caption=element_text(size=8, margin=margin(t=12), color="#7a7d7e")
        ) +
        theme_minimal()

}



