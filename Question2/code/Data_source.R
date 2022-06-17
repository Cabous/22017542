Data_source <- function(Datroot){

    library(readr)

    # Silently in read_csv:
    silentread <- function(x){
        hushread <- purrr::quietly(read_csv)
        df <- hushread(x)
        df$result
    }

    London_weather <-
        read_csv(Datroot)


    London_weather

}




