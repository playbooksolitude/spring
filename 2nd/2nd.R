#24-0413 sat 15:39

# 0 library ----
library(tidyverse)
library(readxl)
library(googlesheets4)
library(showtext)
showtext_auto()
library(nord)
#https://github.com/playbooksolitude/spring/tree/main/2nd

#1 read csv
airport_2402_Sheet <- read_csv("1st/airport_2402 - Sheet.csv")

  # check
airport_2402_Sheet |> head()
airport_2402_Sheet |> tail()

##1-1 count ----
airport_2402_Sheet |> 
  count(출발공항명, sort = T) -> aptable

#2 wordcolud ----
library(wordcloud)

# wordcloud
wordcloud(words = aptable$출발공항명, 
          freq =aptable$n, 
          min.freq = 100,
          max.words = Inf, 
          random.order = F,
          random.color = F)

## RColorBrewer

?RColorBrewer
RColorBrewer::display.brewer.all()
display.brewer.all()
display.brewer.pal(n = 6, name = "Set2")
display.brewer.pal(n = 8, name = "Set2")
display.brewer.pal(n = 8, name = "Dark2")
display.brewer.pal(n = 10, name = "Dark2")
display.brewer.pal(n = 4, name = "Dark2")

##2-1 color ----
wordcloud(words = aptable$출발공항명, 
          freq =aptable$n, 
          min.freq = 100,
          max.words = Inf, 
          random.order = F,
          random.color = F,
          colors = brewer.pal(8, "Dark2"))

#3 colorspack ----
#install.packages("colorspace")
library(colorspace)

  #3-1 palettes ----
colorspace::hcl_palettes(plot = T)
colorspace::hcl_palettes(plot = T, type = "Diverging")
qualitative_hcl(n=5, palette='Harmonic')       
qualitative_hcl(n=2, palette='Harmonic')
diverging_hcl(n = 5, palette = "Blue-red 2")

#brewer.pal.info
#https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3

  ##3-2 colorspace ----
wordcloud(words = aptable$출발공항명, 
          freq =aptable$n, 
          min.freq = 100,
          max.words = Inf, 
          random.order = F,
          random.color = F, 
          colors = qualitative_hcl(n = 5, palette = "Dark 3"))

  ## 3-3 palettes 만들기 ----
colorspace::choose_palette()


#4 wordclou2 ----
#install.packages("wordcloud2")
library(wordcloud2)
wordcloud2(demoFreq, size = 1.0)

  ## 4-1 shape ----
# circle / cardioid / diamond / triangle-forward / triangle / pentagon / star
wordcloud2(demoFreq, size = 1,shape = 'star')
wordcloud2(demoFreq, size = 1,shape = 'pentagon')

  ## 4-2 인천공항 ----
wordcloud2(data = aptable,
           size = 1, shape = "star")

  ## 4-3 필터조합 ----
aptable |> 
  filter(n > 100) |> 
  wordcloud2(size = 1, 
             backgroundColor = "black", 
             shape = "diamond")

  ##4-4 backgroudcolor  ----
aptable |> filter(n > 200) |> 
  wordcloud2(size = 2, 
             #backgroundColor = "black", 
             shape = "star", 
             color = "random-light")


#5 nord() ----
#install.packages("nord")
library(nord)
nord_palettes

#https://cran.r-project.org/web/packages/nord/readme/README.html
#https://m.blog.naver.com/regenesis90/222204802284

# par(mfrow=c(8, 2), lheight = 2, mar=rep(1, 4), adj = 0)
# walk(names(nord_palettes), nord_show_palette)
# dev.off()

  ##5-1 nord ----
aptable |> filter(n > 100) |> 
  wordcloud2(size = .5, 
             #backgroundColor = "black", 
             shape = "star", 
             color = nord("aurora"))

  ##5-2 응용 ----
aptable |> filter(n > 100) |> 
  wordcloud2(size = .5, 
             #backgroundColor = "black", 
             shape = "star",
             color = nord("frost")
             #color = nord("afternoon_prarie")
            )

#6 통계 ----
#통계 #신뢰구간 #신뢰수준
#https://www.youtube.com/live/WFXnjLTf6Jc?si=kyhiY7PSQws050jN&t=4072

#https://www.youtube.com/live/KMIZPgEQNHk?si=WfLWlL8eRjfaL5Yh&t=1269

#https://www.youtube.com/live/Jaknww22xjk?si=PzsF57YchyW0fRKH&t=1255

#https://en.wikipedia.org/wiki/Confidence_interval


#7 stat = "count ----
airport_2402_Sheet |> 
  count(날짜) |> 
  ggplot(aes(x = 날짜, y = n)) +
  geom_bar(stat = "identity")


## 7-1 fill
airport_2402_Sheet |> 
  count(날짜, 구분) |> 
  ggplot(aes(x = 날짜, y = n, fill = 구분)) +
  geom_bar(stat = "identity")


## 7-2 coord_flip ----
airport_2402_Sheet |> 
  count(날짜, 구분, 현황) |> 
  ggplot(aes(x = 날짜, y = n, fill = 현황)) +
  geom_bar(stat = "identity") +
  coord_flip() 

## 7-3 theme ----
airport_2402_Sheet |> 
  count(날짜, 구분, 현황) |> 
  ggplot(aes(x = 날짜, y = n, fill = 현황)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme(legend.position = "top")

## 7-4 geom_text ----
airport_2402_Sheet |> 
  count(날짜, 구분, 현황) |> 
  ggplot(aes(x = 날짜, y = n, fill = 현황)) +
  geom_bar(stat = "identity") +
  geom_text(data = airport_2402_Sheet |> 
              count(날짜, 현황), 
            aes(label = n), 
            position = position_stack(.5)) +
  coord_flip() +
  theme(legend.position = "top")


  ## 7-5 nord ----
airport_2402_Sheet |> 
  count(날짜, 구분, 현황) |> 
  ggplot(aes(x = 날짜, y = n, fill = 현황)) +
  geom_bar(stat = "identity") +
  geom_text(data = airport_2402_Sheet |> 
              count(날짜, 현황), 
            aes(label = n), 
            position = position_stack(.5)) +
  coord_flip() +
  theme(legend.position = "top") +
  scale_fill_manual(values = nord("lumina"))
 

#8 heatmap ----
airport_2402_Sheet |> 
  count(날짜, 현황) |> 
  ggplot(aes(x = 현황, y = 날짜, 
             fill = n)) +
  geom_tile() +
  geom_text(aes(label = n), color = "black") 

##8-1 color ----
airport_2402_Sheet |> 
  count(날짜, 현황) |> 
  ggplot(aes(x = 현황, y = 날짜, 
             fill = n)) +
  #geom_tile() +
  geom_tile(color = "white") +
  geom_text(aes(label = n), color = "black") 


#9 scale_y_continuous ----
airport_2402_Sheet |> 
  count(날짜, 현황) |> 
  ggplot(aes(x = 현황, y = 날짜, 
             fill = n)) +
  #geom_tile() +
  geom_tile(color = "white") +
  geom_text(aes(label = n), color = "black") +
  scale_fill_gradient(low = '#e2e2e2', 
                      high = 'red') +
  ggtitle(label = "2024.2 도착현황", 
          subtitle = "인천공항") +
  scale_y_continuous(breaks = c(20240201, 
                                20240210,
                                20240220,
                                20240229)) +
  theme(legend.position = "none", 
        axis.title = element_blank(), 
        axis.text = element_text(size = 15))


