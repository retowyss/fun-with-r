# Altering examples from 
# https://cran.r-project.org/web/packages/dplyr/vignettes/programming.html

library(tidyverse)

# Take an unquatred argument and pass it throguh to dplyr functions 

summarise_all_by <- function(x, y, f = mean) {
  y <- enquo(y)
  
  x %>%
    group_by(!! y) %>%
    summarise_all(f)
}


summarise_all_by(iris, Species, mean)

summarise_all_by(iris, Species, median)

summarise_all_by(mtcars, cyl, median)

