
#24-0511 #08:20

#
library(tidyverse)

#태현님 질문

#
read_csv("./QnA/hiphop2.txt", 
  locale=locale(encoding="euc-kr"), 
  col_names = "song") -> hiphop_1csv

#
hiphop_1csv
hiphop_1csv |> view()

#
str(hiphop_1csv)
glimpse(hiphop_1csv)
hiphop_1csv

#
ggplot(data = mpg, 
  aes(x = ageg, 
    y = mean_income, 
    fill = sex)) + 
  geom_col(position = "dodge")
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

#
?geom_col()

#

#

