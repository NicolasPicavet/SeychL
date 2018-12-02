#####################
#### SIG ####
#####################

# Vecteur
#install.packages('rgdal')
#install.packages('leaflet')
library(rgdal)
library(leaflet)
library("htmlwidgets")

setwd("C:/Users/Myriam/Documents/0- Myriam/Projets/SeychL/map")

# Dreparation du systÃ¨me de projection de notre couche 
thecrs <- CRS("+init=epsg:4326")

# Ouvrir un shapefile
iles <- readOGR("iles_vacs.shp")
#proj4string(iles) <- thecrs

routesj1 <- readOGR("routes_j1.shp")
routes <- readOGR("routes_pst_vacances4326.shp")

places_points <- readOGR("places_points.shp", use_iconv = TRUE, encoding = "UTF-8")

## Initialisation 
m <- leaflet(padding = 0) %>% fitBounds(     lng1 = 55.1977,
                                             lat1 = -4.5292,
                                             lng2 = 55.7367, 
                                             lat2 = -4.8471)
## Ajout des iles
m <- addPolygons(map = m, data = iles,
                 opacity = 100, 
                 color = "#454545", 
                 weight = 0.25,popup = NULL,
                 options = list(clickable = FALSE), 
                 fill = T, fillColor = "#B3C4B3", 
                 fillOpacity = 100)


#m <- m %>% addMarkers(data = places_points, label = ~name,
#                     #icone="none",
#                     clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = T),
 #                    labelOptions = labelOptions(noHide = T, direction = 'auto'))#~sqrt(Pop) * 30, popup = ~City)

m <- m %>% addLabelOnlyMarkers(data = places_points,
                               label = ~name, group="Lieux",
                          labelOptions = labelOptions(noHide = T, 
                                                      direction = 'top', 
                                                      textOnly = TRUE))

m <- addPolylines(map = m, data = routes, opacity = 100, 
                  #label= ~name,
                  color = "#000000", 
                  weight = 0.5)

m <- addPolylines(map = m, data = routesj1, group = "J1",
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE))



m <- addLayersControl(m, 
      overlayGroups = c("J1", "Lieux"),
      options = layersControlOptions(collapsed = FALSE)
)

m


saveWidget(m, "map.html", selfcontained = TRUE)

