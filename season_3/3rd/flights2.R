
# left_join
flights |> count(year, month) |> 
  left_join(flights23 |> count(year, month), 
    by = "month")

# full_join
flights |> count(year, month) |> 
  full_join(flights23 |> 
      count(year, month)) |> 
  print(n = Inf)

# full_join
(flights |> count(year, month) |> 
    full_join(flights23 |> 
        count(year, month)) -> flights_all)

# 
flights_all



#
flights_all |> 
  ggplot(aes(x = year, y = n)) +
  geom_bar(stat = "identity")

#
flights_all |> 
  ggplot(aes(x = year, y = n, fill = month)) +
  geom_bar(stat = "identity", position = "dodge")


#

# 히트맵
flights_all |> 
  ggplot(aes(x = year, y = month, fill = n)) +
  geom_tile() +
  geom_text(aes(label = n)) +
  scale_fill_gradient(low = "white", high = "red")

