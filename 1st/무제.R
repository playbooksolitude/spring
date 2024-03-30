#24-0324 fri 12:10

#
library(tidyverse)
tidyverse_packages()
library(googlesheets4)
library(scales)
library(bbplot)
library(showtext)
showtext.auto()
library(nord)
#
read.csv("./1st/preview/KOBIS_2024-03-24.xls")
read_sheet("https://docs.google.com/spreadsheets/d/1Q4munFHTzzrjFxUNmunKMwURDjVdNLxOMn1OVlNg1W8/edit#gid=143743275", skip = 6, col_names = T) -> kobis_1csv

kobis_1csv |> view()
kobis_1csv |> glimpse()


# kobis
read_csv("../cine21/csv/kobis_all0523.csv") -> kobis_all_1csv


# thx
kobis_all_1csv |> 
  filter(연도 %in% c(2019, 2020)) |> 
  drop_na(월) |> 
  group_by(연도, 월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), 
             y = 월별관객수/10000, fill = factor(연도))) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = comma(round(월별관객수/10000,0))), 
            position = position_dodge(.9), vjust = -.2,
            size = 5) +
  scale_y_continuous(labels = comma) +
  labs(title = "Covid-19 전/후 극장관객수 비교", 
       subtitle = "단위: 만 명") +
  bbc_style() +
  scale_fill_nord("afternoon_prarie")



#
kobis_all_1csv |> 
  filter(연도 %in% c(2017, 2018)) |> 
  drop_na(월) |> 
  group_by(연도, 월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), 
             y = 월별관객수/10000, fill = factor(연도))) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = comma(round(월별관객수/10000,0))), 
            position = position_dodge(.9), vjust = -.2,
            size = 5) +
  scale_y_continuous(labels = comma) +
  labs(title = "극장관객수 2017년, 2018년 비교", 
       subtitle = "단위: 만 명") +
  bbc_style() +
  scale_fill_nord("afternoon_prarie")

#
kobis_all_1csv |> 
  filter(연도 %in% c(2015, 2016)) |> 
  drop_na(월) |> 
  group_by(연도, 월) |> 
  summarise(월별관객수 = sum(관객수)) |> 
  ggplot(aes(x = factor(월), 
             y = 월별관객수/10000, fill = factor(연도))) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = comma(round(월별관객수/10000,0))), 
            position = position_dodge(.9), vjust = -.2,
            size = 5) +
  scale_y_continuous(labels = comma) +
  labs(title = "극장관객수 2015년, 2016년 비교", 
       subtitle = "단위: 만 명") +
  bbc_style() +
  scale_fill_nord("afternoon_prarie")
