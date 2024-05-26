#24-0502 08:01 thus

#
library(tidyverse)
library(viridis)
viridis::viridis_pal()

#
mpg |> names()
mpg |> 
  ggplot(aes(x = manufacturer, y = after_stat(count))) +
  geom_bar(stat = "count") +
  coord_flip() +
  #facet_wrap(year~.)
  #facet_grid(.~year)
  #facet_wrap(year~class)
  #facet_grid(year~class)
  
#
diamonds |> print(n = 1000)
