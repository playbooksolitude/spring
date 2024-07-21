#24-0330 sat 19:28
  # 첫  모임 ----

#0 library ----
library(tidyverse)
library(readxl)
library(googlesheets4)
library(showtext)
showtext_auto()

#library(hrbrthemes)
# 제목 ----
##1 제목 ----
###1 제목 ----


#
#1 read ----
library(readr)
airport_2402_Sheet <- read_csv("1st/airport_2402 - Sheet.csv")

#check
#View(airport_2402_Sheet)


## dataset ----
# 항공포탈

# https://www.airportal.go.kr/life/airinfo/FlightScheduleToExcel.jsp

# 단축키
# https://datadoctorblog.com/2021/08/17/R-update-rstudio-document-outline/

read_sheet("https://docs.google.com/spreadsheets/d/1Nnuxz2zZ-LSpOExT1gSjY11g30MUz4BROvi6-Cgcikc/edit#gid=1542860153") -> ap_1sheet

#
ap_1sheet #2월 한달
ap_1sheet #0207~0213

#
# ap_1sheet |> 
#   mutate(date = make_date(날짜), .before = 1)
# ap_1sheet |> 
#   mutate(날짜 = ymd(날짜)) 
# 
# ap_1sheet
# ap_1sheet |> 
#   transmute(hm(계획시간))
# ap_1sheet |> 
#   separate(col = 계획시간, into = c("계획_시간", "계획_분"), 
#            sep = ":") |> 
#   separate(col = 도착시간, into = c("도착_시간", "도착_분"),
#            sep = ":") -> temp1

#

## google sheet ----
# read_sheet("https://docs.google.com/spreadsheets/d/1Nnuxz2zZ-LSpOExT1gSjY11g30MUz4BROvi6-Cgcikc/edit#gid=1542860153") -> airport_2402_Sheet

#
airport_2402_Sheet
airport_2402_Sheet #2월 한달
airport_2402_Sheet #0207~0213
colnames(airport_2402_Sheet)

#2 data check ----
airport_2402_Sheet |> 
  count(출발공항명, 항공사,현황) |> 
  pivot_wider(names_from = 현황, 
              values_from = n) |> 
  arrange(desc(도착)) |> 
  head()

dim(ap_1sheet)

#
ap_1sheet |> 
  filter(날짜 == "20240207") #579

#
ap_1sheet |> 
count(출발공항명, 항공사, 현황, sort = T)

count(ap_1sheet, 출발공항명, 항공사, sort = T)
count(ap_1sheet, 항공사, 출발공항명, sort = T)
count(ap_1sheet, 출발공항명, sort = T)

count(ap_1sheet,, sort = T)

#
count(ap_1sheet, 출발공항명)
dim(ap_1sheet)
ap_1sheet
view(ap_1sheet)

# 0207
airport_2402_Sheet |> 
  filter(날짜 == "20240207") #579

# 높은 순서
ap_1sheet |> 
  count(출발공항명, sort = T)

# 홍콩 출발
ap_1sheet |> 
  filter(출발공항명 == "홍콩") |> 
  count(항공사, sort = T)

## 2-1  출발공항명
airport_2402_Sheet |> 
  count(출발공항명, 항공사, 현황, sort = T) |> 
  print(n = 30)

## 2-2 pivot_wider top 3
airport_2402_Sheet |> 
  count(출발공항명, 항공사, 현황, sort = T) |> 
  #filter(현황 == "지연")
  filter(출발공항명 %in% c("다낭", 
    "푸동", "홍콩")) |> 
  pivot_wider(names_from = "현황", 
              values_from = n) 
  
# 3 ggplot ----
## 3-1 geom_bar
airport_2402_Sheet |> 
  count(출발공항명,항공사, 현황, sort = T) |> 
  ggplot(aes(x = 현황, y = after_stat(count))) +
  geom_bar() +
  geom_label(aes(label = after_stat(count)), 
             stat = "count", size = 6) +
  theme(axis.text.x = element_text(size = 20), 
        axis.title = element_blank(), 
        axis.ticks = element_blank()) +
  ggtitle(label = "2024.02.07~13", 
          subtitle = "부제목")



## 3-2 ----
count(airport_2402_Sheet, 출발공항명, 구분) |> 
  filter(n < 6) |> 
  ggplot(aes(x = 출발공항명, y = 구분, 
             fill = n)) +
  geom_tile() +
  coord_flip() +
  facet_wrap(.~구분, scales = "free") +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient() +
  theme(legend.position = "none")


# 3-3 출발공항명, 구분
airport_2402_Sheet
count(airport_2402_Sheet, 출발공항명, 구분, sort = T) |>
  #count(airport_2402_Sheet, 출발공항명, 구분) |> 
  filter(n < 11) |> 
  ggplot(aes(x = 출발공항명, y = 구분, 
             fill = n)) +
  geom_tile() +
  coord_flip() +
  facet_wrap(.~구분, scales = "free") +
  geom_text(aes(label = n), color = "white") +
  scale_fill_gradient(low = "#ced4da", 
                      high = "red") +
  theme(legend.position = "none")


#
ap_1sheet |> 
  count(출발공항명, sort = T)

ap_1sheet |> 
  count(출발공항명,항공사, 현황, sort = T) |> 
  ggplot(aes(x = 현황, y = after_stat(count))) +
  geom_bar() +
  geom_label(aes(label = after_stat(count)), 
             stat = "count", size = 6) +
  theme(axis.text.x = element_text(size = 20), 
        axis.title = element_blank(), 
        axis.ticks = element_blank()) +
  ggtitle(label = "2024.02.07~13", subtitle = "부제목")

ap_1sheet |> 
  filter(출발공항명 == "홍콩") |> 
  count(항공사, sort = T)

=======
>>>>>>> 027e1dd7db512991461ecdc9da54aa1b1bd74e68
