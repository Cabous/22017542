Data <- function(Datroot){

    library(readr)
    options(dplyr.summarise.inform=F)
    # Silently in read_csv:
    silentread <- function(x){
        hushread <- purrr::quietly(read_csv)
        df <- hushread(x)
        df$result
    }

    Covid_19 <-
        read_csv(Datroot)

 Covid_19

}
