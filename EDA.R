library(tidyverse)
df <- read_csv("strip2018.csv")
df_geo <- read_csv("https://data.wprdc.org/datastore/dump/db139ccd-6753-48ad-b3ff-118fe2223d55")

df %>% 
  count(meter_id, sort = TRUE)

glimpse(df)

df %>% 
  count(zone, sort = TRUE)

df %>% 
  left_join(df_geo, by = c("meter_id" = "id"))

