p <- ggplot(data = animate_data, mapping = aes(
  x = income/1000,
  y = lifeexp,
  size = population/1000000,
  fill = continent)) +
  geom_point(shape = 21) +
  scale_x_log10() +
  scale_size_area(
    max_size = 30,
    name = "Population (millions)",
    breaks = c(10, 100, 500, 1000)) +
  scale_fill_manual(
    values = c("#FF265C", "#FFE700", "#4ED7E9", "#70ED02", "purple"),
    name = "Continent") +
  theme_minimal() +
  theme(panel.grid.minor = element_blank(),
        legend.position = "none") +
  labs(title = "Year: {frame_time}",
       x = "Income (GDP/capita, PPP (constant 2021 international $))",
       y = "Life expectancy (years)") +
  transition_time(year)

p_anim <- animate(p, renderer = gifski_renderer())
anim_save("animation_frames/my_animation.gif", animation = p_anim)
