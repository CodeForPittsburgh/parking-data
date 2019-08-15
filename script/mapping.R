###mapping meters to street features

#OSM
#https://dominicroye.github.io/en/2018/accessing-openstreetmap-data-with-r/

library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)

q <- getbb("Pittsburgh")%>%
  opq()%>%
  add_osm_feature("amenity", "cinema")

cinema <- osmdata_sf(q)
cinema

pgh_map <- get_map(getbb("Pittsburgh"),maptype = "toner-background")

#final map
ggmap(pgh_map)+
  geom_sf(data=cinema$osm_points,
          inherit.aes =FALSE,
          colour="#238443",
          fill="#004529",
          alpha=.5,
          size=4,
          shape=21)+
  labs(x="",y="")
