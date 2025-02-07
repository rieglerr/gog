# Load and clean Excel data

library(tidyverse)
library(readxl)

# Load data
region_data <- read_excel("data/regionalgrossdisposablehouseholdincomeallitlregions20221.xlsx", sheet = "Table 3", col_names = FALSE)

#Tidy up data!

## drop first line and empty columns
region_data <- region_data[-1,(1:29)]

## rename variables
names(region_data) <- c("ITL", "ITL_code", "Region_name", "yr1997", "yr1998", "yr1999", "yr2000", "yr2001", "yr2002", "yr2003", "yr2004", "yr2005", "yr2006", "yr2007", "yr2008", "yr2009", "yr2010", "yr2011", "yr2012", "yr2013", "yr2014", "yr2015", "yr2016", "yr2017", "yr2018", "yr2019", "yr2020", "yr2021", "yr2022")

## We won't need first row anymore
region_data <- region_data[-1,]

## We only want ITL1 aggregation levels.

region_data <- region_data %>%
  filter(ITL == "ITL1")

## remove unnecessary variables
region_data <- region_data[,-(1:2)]

## Let reshape data!
region_data <- region_data %>%
  pivot_longer(cols = yr1997:yr2022,
               names_to = "year",
               names_prefix = "yr",
               values_to = "GDHI_pc")

## save as csv file
write.csv(region_data, "region_data.csv", row.names = FALSE)


