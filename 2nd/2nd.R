#24-0413 sat 15:39

# 0 library ----
library(tidyverse)
library(readxl)
library(googlesheets4)
library(showtext)
showtext_auto()
library(nord)

#1 read csv
airport_2402_Sheet <- read_csv("1st/airport_2402 - Sheet.csv")

#
airport_2402_Sheet |> head()
airport_2402_Sheet |> tail()

#2 wordcolud ----
library(wordcloud)

airport_2402_Sheet |> 
  count(출발공항명, sort = T) -> aptable

# wordcloud
wordcloud(words = aptable$출발공항명, 
          freq =aptable$n, 
          min.freq = 100,
          max.words = Inf, 
          random.order = F,
          random.color = F,
          colors = brewer.pal(8, "Dark2"))


#3 wordclou2
library(wordcloud2)
wordcloud2(data = aptable,
           size = 2, shape = "star")

#
aptable |> filter(n > 100) |> 
  wordcloud2(size = 1, 
             backgroundColor = "black", 
             shape = "cardioid")

  ##응용 ----
aptable |> filter(n > 200) |> 
  wordcloud2(size = 1, 
             backgroundColor = "black", 
             shape = "circle")


## shape ----
# circle / cardioid / diamond / triangle-forward / triangle / pentagon / star

## color ----
  #random-light 

aptable |> filter(n > 200) |> 
  wordcloud2(size = 2, 
             backgroundColor = "black", 
             shape = "star", 
             color = "random-light", 
             ellipticity=1)
#
aptable |> filter(n > 300) |> 
  wordcloud2(size = 1, 
             #backgroundColor = "black", 
             shape = "circle", 
             #color = nord("aurora"), 
             #color = nord("frost"),
             color = nord("lumina"),
             ellipticity=1)

#
wordcloud2(aptable, figPath = "./2nd/aa.png")


#
#letterCloud(data = aptable, word = abc, size = 2)



mpg |> 
  count(manufacturer) |> 
  letterCloud(word = "R", size = 1, fontFamily='나눔바른고딕')

letterCloud(demoFreq, word='R')

