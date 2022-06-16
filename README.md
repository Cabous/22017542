# Purpose

``` r
gc() # garbage collection - It can be useful to call gc after a large object has been removed, as this may prompt R to return memory to the operating system.
```

    ##          used (Mb) gc trigger (Mb) max used (Mb)
    ## Ncells 444083 23.8     946885 50.6   643845 34.4
    ## Vcells 790853  6.1    8388608 64.0  1649105 12.6

``` r
library(pacman)
p_load(tidyverse, lubridate)

list.files('Question1/code/', full.names = T, recursive = T) %>% as.list() %>% walk(~source(.))
```

### Question 1

#### Loading the data

#### First plot

I can describe this plot as follows…

It shows that ….

For the below, I had to adjust the sizes to fit into the readme a bit.

The second plot in the paper …

### Question 2

### First plot

Some description here would be great.

### Table

### Second plot

### Regression plot

Short overview
