#24-0512 16:33

#
library(tidyverse)

data()
starwars
starwars |> colnames()

#1 몇 행 * 몇 열 ----
  #87 * 14

#2 gender
starwars$gender
starwars |> count(gender)
starwars$gender |> table()

#3 table(useNA)
?table()
starwars$gender |> table(useNA = "always")

#4 sex
starwars$sex |> table(useNA = "always")
starwars |> count(sex)

#5 변수 저장
starwars |> count(sex) -> temp01
temp01

#6 sex, gender count
(starwars |> count(sex, gender) -> temp02)

# 7 heatmap
temp02
ggplot(data = temp02, 
  aes(x = sex, 
    y = gender, 
    fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white", 
    size = 10)

# 8 na 제거
ggplot(temp02 |> filter(!is.na(sex)), 
  aes(x = sex, 
    y = gender, 
    fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white", 
    size = 10)

# 9 drop_na(sex)
temp02 |> 
  drop_na(sex) |> 
  ggplot(aes(x = sex, 
    y = gender, 
    fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white", 
    size = 10)


# 10 drop_na(sex, mass)
  #x = sex, y = gender
(starwars |> 
  count(sex, species) -> temp03)

# 11
temp03 |> 
  drop_na(sex) |> 
  ggplot(aes(x = sex, 
    y = species, 
    fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "white", 
    size = 5)

# 12 geom_bar(성별) 막대그래프
starwars |> 
  count(sex)

  # 실습
starwars |> 
  count(sex) |> 
  ggplot(aes(x = sex, y = n)) +
  geom_bar(stat = "identity") +
  #geom_text(aes(label = n), size = 10, color = "white")
  geom_label(aes(label = n), size = 5)

starwars #raw stat = "count
starwars |> count(sex) #stat = "identity"

# 13 ggtitle (제목 : "스타워즈 출연자 성별 정보")
    # "소제목 : NA 포함"
starwars |>
  count(sex) |>
  ggplot(aes(x = sex, y = n)) +
  #ggtitle(subtitle = "테스트", label = "") +
  labs(subtitle = "소제목") +
  geom_bar(stat = "identity") +
  #geom_text(aes(label = n), size = 10, color = "white")
  geom_label(aes(label = n), size = 5) +
  scale_y_continuous(limits = c(0,70),
    breaks = c(0,20,40,60,80)) +
  geom_hline(yintercept = 0,
    colour = "black", linewidth = 1)
  , #ylim(c(0,100))


#
library(showtext)
showtext_auto()

#
mpg |> summary(drv)
mpg |> count(drv, hwy) |> 
  summary()
?IQR

mpg |> count(drv)
mpg |> filter(drv == "f") |> 
  summary(hwy)

mpg |> 
  ggplot(aes(x =drv, y = hwy)) +
  geom_boxplot()


