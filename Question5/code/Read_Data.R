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


