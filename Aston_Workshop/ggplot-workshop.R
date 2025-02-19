#############################################################
### Aston University Using R ggplot for Graphics Workshop ###
#############################################################

# Install the required packages
install.packages("tidyverse")
install.packages("gganimate")
install.packages("gifski")

# Call the required library
library(tidyverse)
library(gganimate)
library(gifski)

###########################
### plots with mpg data ###
###########################

View(mpg)

# Create a canvas!
ggplot(mpg, aes(x = displ, y = hwy))

# Add scatterplot 
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() 

# Add a regression line (a line that fits best to the points on plot)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# Differentiate data points by class using colors
ggplot(mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point() 

# Adding a best fit line with class coloring
ggplot(mpg, aes(x = displ, y = hwy, colour = class)) +
  geom_point() +
  geom_smooth(method = "lm", se= FALSE)

# Adding a best fit line for the overall group of data points
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(method = "lm",se = FALSE)

# Faceting
ggplot(mpg, aes(displ,hwy)) +
  geom_point() +
  facet_wrap(~class)

##############################
### Plots with region_data ###
##############################

region_data <- read.csv("data/region_data.csv")
View(region_data)

# Line plot
ggplot(region_data, aes(x = year, y = GDHI_pc, colour = Region_name)) +
  geom_line()

# Exploring themes by a selected group of regions

# Import region_data_sel
region_data_sel <- read.csv("data/region_data_sel.csv")

ggplot(region_data_sel, aes(x = year, y = GDHI_pc, colour = Region_name)) +
  geom_line() 

ggplot(region_data_sel, aes(x = year, y = GDHI_pc, colour = Region_name)) +
  geom_line() +
  theme_bw()

ggplot(region_data_sel, aes(x = year, y = GDHI_pc, colour = Region_name)) +
  geom_line() +
  theme_dark()

ggplot(region_data_sel, aes(x = year, y = GDHI_pc, colour = Region_name)) +
  geom_line() +
  theme_linedraw()

#####################
### Bubble Charts ###
#####################

# Import bubble.chart.data
bubble.chart.data <- read.csv("data/bubble.chart.data.csv")

# Scatterplot of life expectancy and income
ggplot(data = bubble.chart.data, aes(x = income, y = lifeexp)) +
  geom_point()

# Add coloring by continent and change size of points using population
ggplot(data = bubble.chart.data, aes(x = income, y = lifeexp, size = population, colour = continent)) +
  geom_point()

# Change horizontal scale to logarithmic
ggplot(data = bubble.chart.data, aes(x = income, y = lifeexp, size = population, colour = continent)) +
  geom_point() +
  scale_x_log10()

# Add accurate re-sizing of points using population
ggplot(data = bubble.chart.data, aes(x = income, y = lifeexp, size = population, colour = continent)) +
  geom_point() +
  scale_x_log10() +
  scale_size_area(max_size = 30, name = "Population")

# Add legends
ggplot(data = bubble.chart.data, mapping = aes(
  x = income/1000,
  y = lifeexp,
  size = population/1000000,
  colour = continent)) +
  geom_point() +
  scale_x_log10() +
  scale_size_area(
    max_size = 30,
    name = "Population (millions)",
    breaks = c(10, 100, 500, 1000))

# Add black border to circles
ggplot(data = bubble.chart.data, mapping = aes(
  x = income/1000,
  y = lifeexp,
  size = population/1000000,
  fill = continent)) +
  geom_point(shape = 21) +
  scale_x_log10() +
  scale_size_area(
    max_size = 30,
    name = "Population (millions)",
    breaks = c(10, 100, 500, 1000))

# Add custom colors for circles
ggplot(data = bubble.chart.data, mapping = aes(
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
    name = "Continent")

# Change plot theme to minimal to remove background color
ggplot(data = bubble.chart.data, mapping = aes(
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
  theme_minimal()

# Add title and label axes
ggplot(data = bubble.chart.data, mapping = aes(
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
  labs(x ="Income (GDP/capita, in thousands of US dollars)",
       y ="Life expectancy (years)", title = "Strong correlation between economic development and life expectancy" ) 

#################
### Animation ###
#################

# Read data
animate_data <- read.csv("data/animate.csv")

# Animate plot
# plot data and store under name p (you may give any name you like)
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

# render plot
p_anim <- animate(p, renderer = gifski_renderer())

# save animated plot
anim_save("animation_frames/my_animation.gif", animation = p_anim)








