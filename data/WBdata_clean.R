library(tidyverse)
WBdata <- read.csv("~/Dropbox/work/gog/data/WBdata.csv", header=FALSE)

names(WBdata) <- c("name","CC","SName","SCode","Value")

WBdata <- WBdata[-1,]

WBdata <- WBdata %>%
  mutate(SName = case_when(
    SName == "Population, total" ~ "population",
    SName == "Life expectancy at birth, total (years)" ~ "lifeexp" ,
    SName == "GDP per capita (current US$)" ~ "income"
  ))

WBdata <- WBdata[,-4]
WBdata <- WBdata[-c(652:669),]

## Let reshape data!
WBdata <- WBdata %>%
  pivot_wider(names_from = SName,
              values_from = Value)

# change characters to numeric
WBdata$population <- as.numeric(WBdata$population)
WBdata$lifeexp <- as.numeric(WBdata$lifeexp)
WBdata$income <- as.numeric(WBdata$income)

WBdata <- na.omit(WBdata)

# Add regional (continents) information

region <- read.csv("~/Dropbox/work/gog/data/all.csv")
region <- region[,c(3,6)]
names(region) <- c("CC", "continent")

WBdata <- left_join(WBdata, region, by ="CC" )
WBdata <- na.omit(WBdata)

write.csv(WBdata, "data/bubble.chart.data.csv", row.names = FALSE)


# Let's also clean data for animation

WBdata_animate <- read.csv("~/Dropbox/work/gog/data/WBdata_animate.csv", header=FALSE)

new_names <- paste0("Yr", 1990:2022)

names(WBdata_animate) <- c("name","CC","SName","SCode", new_names)

WBdata_animate <- WBdata_animate[-1,]

WBdata_animate <- WBdata_animate %>%
  mutate(SName = case_when(
    SName == "Population, total" ~ "population",
    SName == "Life expectancy at birth, total (years)" ~ "lifeexp" ,
    SName == "GDP per capita, PPP (constant 2021 international $)" ~ "income"
  ))

WBdata_animate <- WBdata_animate[,-4]
WBdata_animate <- WBdata_animate[-c(652:657),]

## Let reshape data! 2 stages
WBdata_animate <- WBdata_animate %>%
  pivot_longer(cols = Yr1990:Yr2022,
               names_to = "year",
               names_prefix = "Yr",
               values_to = "Values")

WBdata_animate <- WBdata_animate %>%
  pivot_wider(names_from = SName,
              values_from = Values)

# change characters to numeric
WBdata_animate$population <- as.numeric(WBdata_animate$population)
WBdata_animate$lifeexp <- as.numeric(WBdata_animate$lifeexp)
WBdata_animate$income <- as.numeric(WBdata_animate$income)
WBdata_animate$year <- as.numeric(WBdata_animate$year)

# drop if there is any missing observation within a country group

WBdata_animate <- WBdata_animate %>%
  group_by(CC) %>%      # Group by country
  filter(!any(is.na(across(everything())))) %>% # Drop if any NA exists in the group
  ungroup() 

# Add regional (continents) information

WBdata_animate <- left_join(WBdata_animate, region, by ="CC" )
WBdata_animate <- na.omit(WBdata_animate)

write.csv(WBdata_animate, "data/animate.csv", row.names = FALSE)