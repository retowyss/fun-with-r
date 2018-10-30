# Altering examples from 
# https://cran.r-project.org/web/packages/dplyr/vignettes/programming.html

library(tidyverse)

# Take an unquatred argument and pass it throguh to dplyr function 

summariser <- function(df, group_var, f = mean) {
  group_var <- enquo(group_var)
  
  df %>%
    group_by(!! group_var) %>%
    summarise_all(f)
}


summariser(iris, Species, mean)
summariser(iris, Species, median)
summariser(mtcars, cyl, median)

