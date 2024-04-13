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

##2-1 ----
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
          random.color = F,
          colors = brewer.pal(8, "Dark2"))


#3 wordclou2
library(wordcloud2)
wordcloud2(demoFreq, size = 1.0)

## 3-1 shape ----
# circle / cardioid / diamond / triangle-forward / triangle / pentagon / star
wordcloud2(demoFreq, size = 1,shape = 'star')
wordcloud2(demoFreq, size = 1,shape = 'pentagon')


wordcloud2(data = aptable,
           size = 1, shape = "star")

#
aptable |> 
  filter(n > 100) |> 
  wordcloud2(size = 1, 
             backgroundColor = "black", 
             shape = "diamond")


## color ----
  #random-light 

aptable |> filter(n > 200) |> 
  wordcloud2(size = 1, 
             #backgroundColor = "black", 
             shape = "circle")

aptable |> filter(n > 200) |> 
  wordcloud2(size = 2, 
             #backgroundColor = "black", 
             shape = "star", 
             color = "random-light", 
             ellipticity=1)
## nord()
#install.packages("nord")
library(nord)
nord_palettes

#https://cran.r-project.org/web/packages/nord/readme/README.html
#https://m.blog.naver.com/regenesis90/222204802284

#par(mfrow=c(8, 2), lheight = 2, mar=rep(1, 4), adj = 0)
#walk(names(nord_palettes), nord_show_palette)
# dev.off()

aptable |> filter(n > 100) |> 
  wordcloud2(size = .5, 
             #backgroundColor = "black", 
             shape = "star", 
             color = nord("aurora"), 
             #color = nord("frost"),
             #color = nord("afternoon_prarie")
             )



