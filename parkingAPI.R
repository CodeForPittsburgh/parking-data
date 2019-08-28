library(httr)
library(dplyr)
library(jsonlite)
library(lubridate)

# calls WPRDC's parking data API
# returns 10-min transactions from strip district since 1/1/2019

url <- "https://data.wprdc.org/api/action/datastore_search_sql?sql=SELECT%20*%20from%20%221ad5394f-d158-46c1-9af7-90a9ef4e0ce1%22%20WHERE%20zone%20=%27404%20-%20Strip%20Disctrict%27%20AND%20start%20BETWEEN%20'2019-01-01'%20AND%20NOW()"
response <- GET(url)

results <- fromJSON(content(response, "text"), flatten = TRUE)

data <- results$result$records %>%
  flatten

# filter for Strip weekends, remove full_text
stripData <- data %>%
  filter(zone=='404 - Strip Disctrict') %>%
  select(-c(`_full_text`)) %>%
  filter(wday(utc_start) %in% c(1, 7))

head(stripData)
