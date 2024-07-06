#24-0705 #sat 13:25

#
library(tidyverse)
library(gapminder)
gapminder |> 
  colnames()
?gapminder
gapminder |> 
  group_by(year) |> 
  reframe(n = n())

# 10년 단위
gapminder |> 
  filter(year %in% c("1957", "1967", "1977", "1987", 
    "1997", "2007")) -> gapminder_1edit

gapminder_1edit
  # left_join(
  #   gapminder_1edit |> 
  #     group_by(continent) |> 
  #     reframe(meanlife = mean(lifeExp),
  #       medianlife = median(lifeExp)), by = "continent"
  # )

# geom_boxplot
gapminder_1edit |> 
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot()

#
library(plotly)
gapminder_1edit |> 
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot() -> gapminder_1edit_p

ggplotly(gapminder_1edit_p)


# 연도별 평균 수명 ----   
gapminder_1edit |> 
  group_by(continent, year) |> 
  reframe(meanlife = mean(lifeExp),
  medianlife = median(lifeExp))
    
# join
gapminder_1edit |> 
  left_join(
    gapminder_1edit |> 
      group_by(continent, year) |> 
      reframe(meanlife = mean(lifeExp),
        medianlife = median(lifeExp)), 
    by = c("continent", "year")
  ) -> gapminder_2editmean

# gapminder_2editmean
gapminder_2editmean

gapminder |> 
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_point()

# facet_wrap
gapminder_2editmean |> 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_point(aes(y = meanlife), 
    color = "red",size = 3) +
  facet_wrap(.~continent) +
  scale_x_continuous(breaks = c(1957, 1967, 1977, 1987, 
    1997, 2007, 2017))


# facet_wrap
gapminder_2editmean |> 
  ggplot(aes(x = year, y = lifeExp)) +
  geom_point() +
  geom_point(aes(y = meanlife), 
    color = "red",size = 3) +
  facet_wrap(.~continent) +
  scale_x_continuous(breaks = c(1957, 1967, 1977, 1987, 
    1997, 2007, 2017)) +
  geom_smooth(method = "lm", se = F)

# korea 찾기
str_detect(gapminder$country, "orea")
str_detect(gapminder$country, "orea") |> sum()
filter(
  gapminder, 
  str_detect(gapminder$country, "orea")
      ) 

