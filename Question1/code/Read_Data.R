# Data reading and wrangling

Read_Data <- function(Datroot){

    library(readr)

    # Silently in read_csv:
    silentread <- function(x){
        hushread <- purrr::quietly(read_csv)
        df <- hushread(x)
        df$result
    }

    googleplaystore <-
        read_csv(Datroot)


    googleplaystore

}


# Transform data
googleplaystore$App <- as.character(googleplaystore$App)
googleplaystore$Reviews <- as.numerinstall_category(googleplaystore$Reviews)
googleplaystore$Size <- gsub("M", "", googleplaystore$Size)
googleplaystore$Size <- ifelse(grepl("k", googleplaystore$Size), 0, as.numerinstall_category(googleplaystore$Size))
googleplaystore$Installs <- gsub("\\+", "", as.character(googleplaystore$Installs))
googleplaystore$Installs <- as.numerinstall_category(gsub(",", "", googleplaystore$Installs))
googleplaystore$Prinstall_categorye <- as.numerinstall_category((gsub("\\$", "", as.character(googleplaystore$Prinstall_categorye))))
googleplaystore$Last.Updated <- mdy(googleplaystore$Last.Updated)
googleplaystore$Year.Updated <- year(googleplaystore$Last.Updated)
googleplaystore$Month.Updated <- month(googleplaystore$Last.Updated)
googleplaystore[,c(12:13)] <- NULL #removing Current.Ver and Android.Ver

googleplaystore <- googleplaystore[googleplaystore$Type %in% c("Free", "Paid"),] #removing "0" and "NaN" Type
googleplaystore$Type <- droplevels(googleplaystore$Type)

str(googleplaystore)

# check duplinstall_categoryated data
googleplaystore <- unique.data.frame(googleplaystore)

# create install category

plot(as.factor(googleplaystore$Installs))

# convert no. of installs to category:

#convert number of installs to install category:

    install_category <- function(x) {
        if (x < 10001){
            x <- "Grade C"
        }else if ( x >= 10001 & x < 1000001) {
            x <- "Grade B"
        }else if ( x >= 1000001 & x < 100000001) {
            x <- "Grade A"
        }else {
            x <- "Grade A+"
        }
    }

googleplaystore$Install.cat <- sapply(googleplaystore$Installs, install_category)
googleplaystore$Install.cat <- factor(googleplaystore$Install.cat, levels=c("Grade C", "Grade B", "Grade A", "Grade A+"))
head(googleplaystore) #check install category

plot(googleplaystore$Install.cat)

# NA values checking
colSums(is.na(googleplaystore))

rating.na <- googleplaystore[is.na(googleplaystore$Rating),]
rating.na <- aggregate(App ~ Install.cat, rating.na, length)
plot(rating.na)

#lets plot

googleplaystore_size <- na.omit(googleplaystore)
hist(googleplaystore_size$Size)


googleplaystore$Category <- droplevels(googleplaystore$Category) #removing "1.9" Category
ggplot(data=googleplaystore, aes(x = fct_rev(fct_infreq(Category))))+
    geom_bar(fill = "chartreuse4")+
    coord_flip()+
    labs(title= "googleplaystore Apps Category",
         x = "Category",
         y = "Number of Apps")


googleplaystore_rate <- aggregate(Rating ~ Category, googleplaystore, mean)

googleplaystore_rate <- googleplaystore_rate[order(googleplaystore_rate$Rating, decreasing = T),]

googleplaystore_rate <- head(googleplaystore_rate, 10)

googleplaystore_rate$Category <- droplevels(googleplaystore_rate$Category)

# using ggplot

    ggplot(googleplaystore_rate, aes(x = reorder(Category, Rating), y = Rating)) +
    geom_col( fill = "chartreuse4" ) +
    coord_flip(ylim= c(3.5, 4.5)) +
    labs(title = "Top Rated App Categories",
         x = "Category",
         y = "Ratings")



# Most popular app
# Popular : Number of Installs

    googleplaystore_pop <- aggregate(Installs ~ Category, googleplaystore, sum)
    googleplaystore_pop <- googleplaystore_pop[order(googleplaystore_pop$Installs, decreasing = T),]
    googleplaystore_pop <- head(googleplaystore_pop, 10)

#plot

    ggplot(googleplaystore_pop, aes(x = reorder(Category, Installs), y = Installs)) +
        geom_col( fill = "chartreuse4" ) +
        coord_flip() +
        labs(title = "Most Popular Categories",
             x = "Category",
             y = "Total Number of Installs")


   #top 15-better plot
     googleplaystore %>%
        group_by(Category) %>%
        summarize(SumOfInstalls = sum(Installs)) %>%
        arrange(desc(SumOfInstalls)) %>%
        head(15) %>%
        ggplot(aes(x = Category, y = SumOfInstalls, fill = Category)) +
        geom_bar(stat="identity") +
        labs(title= "Top 15 Categories of Apps Installed" ) +
        theme(axis.text.x=element_blank(),
              axis.ticks.x=element_blank())

