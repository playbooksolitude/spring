#24-0630 #sun

#1 tsv 파일 불러오기에 필요한 패키지 ----
#install.packages("readr")
library(readr)

#2 tsv 파일 불러오기
(read_tsv("./season_3/1st/all-weeks-countries_240630.tsv") -> netflix_1countries)


#3 데이터 조회
#install.packages("drply")
library(dplyr)
filter(netflix_1countries, country_iso2 == "KR")
(filter(netflix_1countries, country_iso2 == "KR") -> netflix_2kr)


# 4 데이터 만들기
filter(netflix_2kr, category == "Films")
(netflix_2kr |> 
  filter(category == "Films", 
    week >= "2024-01-01",
    weekly_rank == "1") -> netflix_3rank)

# 5 데이터 만들기2
(netflix_3rank |> 
  count(show_title, sort = T) -> netflix_4rankorder)


# 6 그래프 그리기
#install.packages("ggplot2")
library(ggplot2)
ggplot(data = netflix_3rank) +
  geom_bar(aes(x = show_title, y = after_stat(count)),
    stat = "count")

# 6-1 x축- y축 전환
ggplot(data = netflix_3rank) +
  geom_bar(aes(x = show_title, y = after_stat(count)),
    stat = "count") +
  coord_flip()

# 7 그래프 라벨링
#install.packages("forcats")
library(forcats)
ggplot(data = netflix_4rankorder) +
  geom_bar(aes(x = show_title |> fct_reorder(n), 
    y = n), 
    stat = "identity") +
  coord_flip() +
  geom_label(aes(x = show_title, y = n,
      label = n), stat = "identity")

# 8 그래프 꾸미기
ggplot(data = netflix_4rankorder) +
  geom_bar(aes(x = show_title |> fct_reorder(n), 
    y = n), 
    stat = "identity",
    fill = "black") +
  coord_flip() +
  xlab(label = "Title") +
  geom_label(aes(x = show_title, y = n,
    label = n), stat = "identity") +
  ggtitle(label = "Netflix Films rank 1", 
    subtitle = "2024.01~06") +
  theme(axis.title = element_text(size = 22), 
    axis.text = element_text(size = 12))

# test
ggplot(data = netflix_4rankorder) +
  geom_bar(aes(x = show_title |> fct_reorder(n), 
    y = n), 
    stat = "identity",
    fill = "black") +
  coord_flip() +
  xlab(label = "Title") +
  geom_label(aes(x = show_title, y = n,
    label = n), stat = "identity") +
  ggtitle(label = "Netflix Films rank 1", 
    subtitle = "2024.01 ~ 2024.06") +
  theme(axis.title = element_text(size = 22), 
    axis.text = element_text(size = 12))





