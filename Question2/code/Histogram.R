


hist(London_weather$max_temp,breaks = 13, col = "blue", main = "Maximum temperature")
hist(London_weather$sunshine ,breaks = 10, col = "yellow", main = "Hours of sunshine per day")

ggplot(London_weather) + geom_area(mapping = aes(x = mean_temp, y = sunshine)) +
    ggtitle(label = "mean_temp vs sunshine")

