mpg |> 
  head

mpg %>% head()

#
# Library
library(tidyverse)

# Create data
data <- data.frame(
  x=LETTERS[1:26],
  y=abs(rnorm(26)))

# plot
ggplot(data, aes(x=x, y=y)) +
  geom_segment( aes(x=x, xend=x, y=0, yend=y)) +
  geom_point(size=5, 
    color="blue", 
    #fill=alpha("orange", 0.1), alpha=0.7, 
    shape=1, stroke=2) 
