
library(httr)
library(dplyr)
library(jsonlite)

# calls WPRDC's parking data API
# returns 10-min transactions from strip district since 1/1/2019

### my simple method

url <- "https://data.wprdc.org/api/action/datastore_search_sql?sql=SELECT%20*%20from%20%221ad5394f-d158-46c1-9af7-90a9ef4e0ce1%22%20WHERE%20zone%20=%27404%20-%20Strip%20Disctrict%27%20AND%20start%20BETWEEN%20'2019-01-01'%20AND%20NOW()"
response <- GET(url)

results <- fromJSON(content(response, "text"), flatten = TRUE)

data <- results$result$records %>%
  flatten


### using geoff's function

ckanSQL <- function(url) {
  r <- RETRY("GET", url)
  c <- content(r, "text")
  json <- gsub('NaN', '""', c, perl = TRUE)
  data.frame(jsonlite::fromJSON(json)$result$records)
}

df <- ckanSQL(url)
