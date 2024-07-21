#24-0720 sat 08:19

# 지난주 geom_point()
mpg |> 
  ggplot(aes(x = drv, y = cty)) +
  geom_point()

mpg |> 
  ggplot(aes(x = drv, y = cty)) +
  geom_point(position = position_jitter(width = .1))

#
library(ggplot2)
library(dplyr)
library(tidyverse)
library(showtext)
showtext_auto()

# data set install
#install.packages("nycflights")

# load
library(nycflights)

#1 데이터 확인 ---- 
nycflights::airlines
nycflights::airports
nycflights::flights
nycflights::planes
nycflights::weather

#2 데이터 복제
flights

#3 구조 파악
flights |> str()
flights |> glimpse()
flights |> 
  colnames()


#4 count ---- 
# 피벗 테이블 만들기
#4-1 year
flights |> 
  count(year) 

#4-2 month
flights |> 
  count(year, month) 

#4-3 day
flights |> 
  count(year, month, day) 

## 4-3-1 항공편이 가장 많은 날? ----
(flights |> 
  count(year, month, day) |> 
  arrange(desc(n)))[1,4]

##4-3-2 항공편이 가장 적은 날? ----
flights |> 
  count(year, month, day) |> 
  arrange(n)

##4-3-3 항공편이 가장 많은 날 하루 출력 ----
# 하나의 값만 노출하려면
(flights |> 
    count(year, month, day) |> 
    arrange(desc(n)))[1,4]

#5 막대그래프
flights |> 
  count(year, month, day) |> 
  ggplot(aes(x = month, y = n)) +
  geom_bar(stat = "identity")

# x축 팩터형
flights |> 
  count(year, month, day) |> 
  ggplot(aes(x = factor(month), y = n)) +
  geom_bar(stat = "identity")

# coord_cartesian
flights |> 
  count(year, month, day) |> 
  ggplot(aes(x = factor(month), y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000))

# label
flights |> 
  count(year, month) |> 
  ggplot(aes(x = factor(month), y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000)) +
  geom_label(aes(label = n))

# 건수, 콤마
flights |> 
  count(year, month) |> 
  ggplot(aes(x = factor(month), y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000)) +
  geom_label(aes(label = paste(scales::comma(n), "건")))

# 한글
library(showtext)
showtext_auto()

# 한글 보이기
flights |> 
  count(year, month) |> 
  ggplot(aes(x = factor(month), y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000)) +
  geom_label(aes(label = paste(scales::comma(n), "건")))

# 축 변경, 범례
flights |> 
  count(year, month) |> 
  ggplot(aes(x = factor(month), y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000)) +
  geom_label(aes(label = paste(scales::comma(n), "건"))) +
  coord_flip() +
  labs(x = "month", title = "nycflights13")

# 가장 많은 달
flights |> 
  count(year, month) |> 
  ggplot(aes(x = factor(month) |> 
      fct_reorder(n), 
    y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000)) +
  geom_label(aes(label = paste(scales::comma(n), "건"))) +
  coord_flip() +
  labs(x = "month", title = "nycflights13")

#
flights |> 
  count(year, month) |> 
  ggplot(aes(x = factor(month) |> 
      fct_reorder(desc(month)), 
    y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000)) +
  geom_label(aes(label = paste(scales::comma(n), "건"))) +
  coord_flip() +
  labs(x = "month", title = "nycflights13")

#
flights |> 
  count(year, month) |> 
  ggplot(aes(x = paste(factor(month),"월") |> 
      fct_reorder(desc(month)), 
    y = n)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0,45000),
    labels = scales::comma) +
  geom_label(aes(label = paste(scales::comma(n), "건"))) +
  coord_flip() +
  labs(x = "month", 
    title = "nycflights13") +
  theme(axis.title = element_blank(), 
    axis.text = element_text(size = 18), 
    axis.ticks = element_blank(), 
    panel.background = element_blank(),
    panel.grid.major.y = element_line(colour = "#cbcbcb"),
    plot.title = element_text(size = 28)) 

#
flights |> 
  colnames()
flights |> head()
flights |> head(20) |> view()
?flights

#
flights |> 
  select(month, day, dep_time, arr_time, 
    dep_delay, arr_delay, origin, dest, 
    carrier, flight,tailnum, distance) |> 
  slice(1:100) |> view()

#
flights |> 
  select(month, day, dep_time, arr_time, 
    dep_delay, arr_delay, origin, dest, 
    carrier, flight,tailnum, distance)

# dep_delay ~ distance
flights |> 
  filter(month == "1") |> 
  ggplot(aes(x = distance, y = dep_delay)) +
  geom_point() -> deptodistance

# arr_delay ~ distance
flights |> 
  filter(month == "1") |> 
  ggplot(aes(x = distance, y = arr_delay)) +
  geom_point() -> arrtodistance

# 2개 그래프 같이 보기
library(patchwork)
deptodistance / arrtodistance 
deptodistance | arrtodistance 

# dep_delay to arr_delay
# dep_delay ~ distance
flights |> 
  filter(month == "1") |> 
  ggplot(aes(x = dep_delay, y = arr_delay)) +
  geom_point()

# geom_smooth
flights |> 
  filter(month ==1,
    is.na(dep_delay) | is.na(arr_delay)) |> 
  select(dep_delay) #573 NA

flights |> 
  filter(month == "1") |> 
  ggplot(aes(x = dep_delay, y = arr_delay)) +
  geom_point() +
  geom_smooth() #573 NA

# 딜레이가 가장 많았던 항공편
flights |> head(100) |> view()
flights |> 
  mutate(gap = (arr_delay - dep_delay), .before = 1) |> 
  arrange(desc(gap)) |> head() |> view()

# 딜레이를 줄였던 항공편
flights |> 
  mutate(gap = (dep_delay - arr_delay), .before = 1) |> 
  arrange(desc(gap)) |> head() |> view()

# 검산
flights |> 
  mutate(gap = (dep_time - arr_time), .before = 1) |> 
  select(dep_time, arr_time, gap, air_time, distance)

# 나누기, 몫, 나머지
7/3
7%/%3
7%%3

# air_time을 시,분으로 
flights |> 
  mutate(gap = (dep_time - arr_time), .before = 1) |> 
  select(dep_time, arr_time, gap, air_time, distance) |> 
  mutate(hour = air_time%/%60, 
    min = air_time%%60) |> 
  print(n = 300)

# 
flights |> 
  filter(month == "1") |> 
  filter(!is.na(dep_delay), !is.na(arr_delay)) |> #35447
  ggplot(aes(x = dep_delay, y = arr_delay)) +
  geom_point() +
  facet_wrap(.~origin)

#
flights |> 
  #filter(month == "1") |> 
  filter(!is.na(dep_delay), !is.na(arr_delay)) |> #35447
  ggplot(aes(x = distance, y = dep_delay)) +
  geom_point()

#
flights |> 
  #filter(month == "1") |> 
  filter(!is.na(dep_delay), !is.na(arr_delay)) |> #35447
  ggplot(aes(x = distance, y = dep_delay)) +
  geom_point() +
  facet_wrap(.~origin, ncol = 1)

#
flights |> 
  group_by(year, month, day) |> 
  reframe(mean_delay = mean(arr_delay, na.rm = T),
    mean_distance = mean(distance, na.rm = T),
    n = n()) |> 
  ggplot(aes(x = mean_distance, y = mean_delay)) +
  geom_point(position = position_jitter(width = .2)) + 
  geom_smooth()

#

#
flights |> 
  filter(month == 1)

#
flights |> 
  filter(month == "1", arr_delay == 0)
  
#
flights |> 
  ggplot(aes(x = distance, y = arr_delay)) +
  geom_point() +
  facet_wrap(.~origin)






