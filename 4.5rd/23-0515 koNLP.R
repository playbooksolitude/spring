#24-0519 sun 20:00

#
library(tidyverse) # base

#install.packages("tidytext")
library(tidytext) 

#install.packages("multilinguer")
library(multilinguer)

#install_jdk()

# install.packages(c("stringr", "hash", "tau", 
#                    "Sejong", 
#                    "RSQLite", 
#                    "devtools"), type = "binary")

#install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP",
                        upgrade = "never",
                        INSTALL_opts = c("--no-multiarch"))
library(KoNLP)
useNIADic()

#
(tibble(
  value = c("동해물과 백두산이 마르고 닳도록",
            "하나님이 보우하사 우리 나라만세")) -> text)

text
extractNoun(text$value)

text |> 
  unnest_tokens(input = value,
                output = words,
                token = extractNoun)

#
(read_csv("./4.5rd/soap2.csv") -> soap)
soap |> view()

(soap |> 
  unnest_tokens(input = value,
                output = words,
                token = extractNoun) |> 
  count(words, sort = T) -> soap2)


(soap2 |> 
    filter(str_count(soap2$words) > 1) -> soap3_edit1)
(soap2 |> 
  filter(str_count(soap2$words) > 2) -> soap3_edit2)
(soap2 |> 
  filter(str_count(soap2$words) > 3) -> soap3_edit3)

library(showtext)
showtext_auto()
soap3_edit1 |> 
  slice(1:20) |> 
  ggplot(aes(x = words |> fct_reorder(n), 
             y = n)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  geom_label(aes(label = n)) +
  ggtitle("동구밭")
  


