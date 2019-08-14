library(tidyverse)
library(lubridate)
library(gganimate)

theme_set(theme_bw())

df <- read_csv("strip2018.csv") %>% 
  mutate(hour = hour(payment_start_utc),
         wday = wday(payment_start_utc, label = TRUE))
df_geo <- read_csv("https://data.wprdc.org/datastore/dump/db139ccd-6753-48ad-b3ff-118fe2223d55")

df %>% 
  count(meter_id, sort = TRUE)

glimpse(df)

df %>% 
  count(zone, sort = TRUE)

df <- df %>% 
  left_join(df_geo, by = c("meter_id" = "id"))

df_trend <- df %>% 
  #filter(!str_detect(location_type, "Virtual")) %>% 
  count(location_type, meter_id, wday, hour) %>% 
  arrange(desc(n))

df_trend %>% 
  count(location_type, sort = TRUE)

df_trend %>% 
  ggplot(aes(hour, n)) +
  geom_jitter() +
  facet_wrap(~location_type, scales = "free_y", ncol = 1)

df %>% 
  count(meter_id, longitude, latitude) %>% 
  ggplot(aes(longitude, latitude, size = n)) +
  geom_point()
