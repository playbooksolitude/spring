#24-0407 19:54

#
library(tidyverse)


#
mpg
table(mpg$model) |> data.frame()

#
dplyr::count()
?count()
count(mpg, model)
