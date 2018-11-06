library(officer)
# Package `magrittr` makes officer usage easier.
library(tidyverse)


## Power Point ----------------------------------------------------------------

my_pres <- read_pptx() 

my_pres <- my_pres %>% 
  add_slide(layout = "Title and Content", master = "Office Theme")

layout_summary(my_pres)


my_pres <- my_pres %>% 
  ph_with_text(type = "title",  str = "Reto Wyss") %>%
  ph_with_text(type = "ftr",    str = "A footer") %>%
  ph_with_text(type = "dt",     str = format(Sys.Date())) %>%
  ph_with_text(type = "sldNum", str = "slide 1") %>%
  ph_with_text(type = "body",   str = "Hello world",  index = 1) 

print(my_pres, target = "002-officer/pptx/reto_wyss.pptx") 

## Word -----------------------------------------------------------------------


mkpar <- . %>% 
  rep(5) %>% 
  paste(collapse = "")

str1 <- mkpar("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ")
str2 <- mkpar("Aenean venenatis varius elit et fermentum vivamus vehicula. ") 
  
g <- ggplot(iris, aes(x = Sepal.Width, y = Petal.Width, color = Species)) + 
  geom_point() +
  ggtitle("Iris Dot-Plot")

my_doc <- read_docx()  %>%
  body_add_par(value = "Iris", style="heading 1") %>% 
  body_add_par(value = str1, style = "Normal") %>% 
  body_end_section_continuous() %>%
  body_add_gg(g) %>% 
  body_add_par(value = str2, style = "Normal") %>% 
  body_end_section_continuous()

print(my_doc, target = "002-officer/docx/iris.docx")
