#24-0526 

#
library(palmerpenguins)

#
penguins |> view()

#https://allisonhorst.github.io/palmerpenguins/

#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm)) +
  geom_point()


#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm,
    color = species)) +
  geom_point() 

#
penguins |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm,
    color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

#
penguins |> 
  drop_na(sex) |> 
  ggplot(aes(x = bill_length_mm, 
    y = bill_depth_mm,
    color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  #facet_wrap(.~sex) 
  facet_grid(sex~island)
