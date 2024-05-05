#3rd 24-0428

#
library(tidyverse)
library(scales)
library(bbplot)


# install.packages('devtools')
#https://bbc.github.io/rcookbook/


#
diamonds
#https://www2.stat.duke.edu/courses/Fall15/sta112.01/post/hw/HW1.html

#
install.packages("nycflights13")
library(nycflights13)

#
diamonds
?diamonds
2.43/mean(3.95,3.98)

#
diamonds |> 
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  facet_grid(cut ~ color)

#
flights |> 
  names()

#
flights |> 
  group_by(month, origin) |> 
  reframe(n = n()) |> 
  print(n = Inf)

#
flights |> 
  group_by(month, origin) |> 
  reframe(n = n())

flights |> 
  group_by(month, dest) |> 
  reframe(n = n())

#
flights |> 
  group_by(month, origin) |> 
  reframe(n = n()) |> 
  pivot_wider(names_from = origin, values_from = n)

#
install.packages("viridis")
library(viridis)

#
# Libraries
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)

# The dataset is provided in the gapminder library
library(gapminder)
data <- gapminder %>% 
  filter(year=="2007") %>% dplyr::select(-year)


# Most basic bubble plot
data %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, size=pop, fill=continent)) +
  geom_point(alpha=0.5, shape=21, color="black") +
  scale_size(range = c(.1, 24), name="Population (M)") +
  scale_fill_viridis(discrete=TRUE, guide=FALSE, option="A") +
  theme_ipsum() +
  theme(legend.position="bottom") +
  ylab("Life Expectancy") +
  xlab("Gdp per Capita") +
  theme(legend.position = "none")

flights |> 
  group_by(month, origin) |> 
  reframe(n = n()) |> 
  ggplot(aes(color = origin)) +
  geom_point(aes(x = factor(month), 
    y = origin, 
    size = n)) #+
  #scale_size(range = c(5, 20)) +
  #scale_color_viridis(discrete=TRUE, guide=FALSE, option="A") +
  #theme(legend.position = "none")
  

#
flights |> 
  group_by(month, origin) |> 
  reframe(n = n()) |> 
  ggplot(aes(x = origin, y = factor(month) |> fct_reorder(desc(month)), 
    fill = n)) +
  geom_tile() +
  geom_text(aes(label = comma(n)), color = "black", size = 5) +
  #scale_fill_gradient(low = "#abd9e9", high = "red")
  scale_fill_gradient(low = "#9d9d9d", high = "red") +
  labs(x = NULL, y = "month") +
  bbc_style() +
  theme(legend.position = "none")
  
#
diamonds |> 
  filter(y < 20) |> 
  ggplot(aes(x = cut, y = y)) +
  geom_point()

#
diamonds |> 
  filter(y < 20) |> 
  ggplot(aes(x = cut, y = y)) +
  #geom_point(position = "jitter")
  geom_jitter(width = .3, alpha = .5)

#
diamonds |> 
  ggplot(aes(x = cut, y = x)) +
  #geom_point() +
  geom_jitter(alpha = .9, 
    color = ifelse(diamonds$x == 0, "red", "black"))


#
#https://exts.ggplot2.tidyverse.org/gallery/
#https://r-graph-gallery.com/



#
coord_cartesian(ylim = c(0,200))
