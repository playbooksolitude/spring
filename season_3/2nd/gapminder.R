#24-0705 #sat 13:25

# 
library(dplyr)
library(ggplot2)

# data()
data()
install.packages("gapminder")
install.packages('gapminder')
library(gapminder)

#
gapminder |> view()
gapminder |> dim() #dataset size
gapminder |> nrow() #행
gapminder |> ncol() #열

#생략된 함수
gapminder |> view()
flights |> view()
gapminder |> head()
gapminder |> tail()
gapminder #101번째~110번째
gapminder |> slice(101:110) #201~201
gapminder
flights |> print(n = 1000)
flights |> print(width = Inf)

#
gapminder
gapminder |> 
  colnames()

library(readxl)
read_excel()
read_tsv("./season_3/2nd/")
read_tsv("./season_3/1st/all-weeks-countries_240630.tsv") -> netflix_1countries

dim(netflix_1countries)

netflix_1countries |> dim()
netflix_1countries

# 원하는 변수만 지우는 명령어
rm(all_weeks_countries_240630)

# 모든 변수를 지우는 명령어
rm(list = ls())


#
?gapminder
?ggplot


# 1 gapminder ----
gapminder
gapminder |> #갭마인더 데이터 셋을 가지고
  ggplot(    #그래프를 그릴거야
    aes(     #동적인 요소를 지정
      x = gdpPercap, #가로축은 gdpPercap 
    y = lifeExp)) +  #세로축은 lifeExp
geom_point()

#
gapminder |> 
  ggplot(aes(x = gdpPercap, 
    y = lifeExp)) +
  geom_point() +
  ggtitle(label = "lifeExp * gdpPercap",
    subtitle = "Gapminder")


#
gapminder |> 
  ggplot(
    aes(
      x = gdpPercap,
      y = lifeExp)) +
  geom_point() +
  ggtitle(label = "lifeExp * gdpPercap")
gapminder |> colnames()
gapminder

# 2 continent color ----
gapminder |> 
  ggplot(
    aes(
      x = gdpPercap,
      y = lifeExp,
      color = continent)) +
  geom_point() +
  ggtitle(label = "lifeExp * gdpPercap") 

# 2 edit
gapminder |> 
  ggplot(aes(
      x = gdpPercap,
      y = lifeExp,
      color = continent)) +
  geom_point() +
  ggtitle(label = "lifeExp * gdpPercap") +
  facet_wrap(.~continent, 
    nrow = 2, scales = "free_x") +
  #theme(legend.position = "top") 
  #theme(legend.position = "bottom")
  theme(legend.position = "left")

#
gapminder |> 
  ggplot(aes(
    x = gdpPercap,
    y = lifeExp, 
    color = continent)) +
  geom_point() 



# 3 facet_wrap ----
gapminder |> 
  ggplot(
    aes(
      x = gdpPercap,
      y = lifeExp,
      color = continent)) +
  geom_point() +
  ggtitle(label = "lifeExp * gdpPercap") +
  facet_wrap(.~continent)
#scale_x_log10(labels = scales::dollar)  

# 4 goem_smooth
gapminder |> 
  ggplot(
    aes(
      x = gdpPercap,
      y = lifeExp,
      color = continent)) +
  geom_point() +
  ggtitle(label = "lifeExp * gdpPercap") +
  geom_smooth()
#scale_x_log10(labels = scales::dollar)  


# 10년 단위# 10년 단위labels()
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

# 5
gapminder_1edit |> 
  ggplot(
    aes(
      x = gdpPercap,
      y = lifeExp)) +
  geom_point()

# 6 geom_boxplot----
gapminder |> 
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  #geom_jitter(width = .2)
  geom_point()

#
install.packages("plotly")
library(plotly)
gapminder_1edit |> 
  ggplot(aes(x = gdpPercap, 
    y = lifeExp, 
    color = country)) +
  geom_point() -> gapminder_1edit_p
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
gapminder_2editmean |> view()

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


gapminder |> 
  ggplot(aes(x = continent, 
    y = lifeExp)) +
  geom_boxplot() +
  geom_violin()
  geom_jitter(width = .1, height = .3)

