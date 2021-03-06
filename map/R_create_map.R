#####################
#### SIG ####
#####################

# Vecteur
#install.packages('rgdal')
#install.packages('leaflet')
library(rgdal)
library(leaflet)
library("htmlwidgets")
library(dplyr)

setwd("C:/Users/Myriam/Documents/0- Myriam/Projets/SeychL/map")

# Dreparation du systÃ¨me de projection de notre couche 
thecrs <- CRS("+init=epsg:4326")

# Ouvrir un shapefile
iles <- readOGR("iles_vacs.shp")
#proj4string(iles) <- thecrs

routes <- readOGR("routes_pst_vacances4326.shp")
routesj1 <- readOGR("routes_j1.shp")
routesj2 <- readOGR("routes_j2.shp")
routesj3 <- readOGR("routes_j3.shp")
routesj4 <- readOGR("routes_j4.shp")
routes_Praslin <- readOGR("routes_Praslin.shp")
routes_Digue <- readOGR("routes_Digue.shp")

places_points <- readOGR("lieux_vacs.shp", use_iconv = TRUE, encoding = "UTF-8")

# fonctions

createmap <- function () {
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
  return(m)
}

addroad <- function(m, data, group) {
  m <- addPolylines(map = m, data = data, group = group,
                    highlightOptions = highlightOptions(color = "white", weight = 2,
                                                        bringToFront = TRUE))
  return(m)
}

addplace <- function(m, data, group) {
  m <- m %>% addLabelOnlyMarkers(data = data,
                                 label = ~name, group=group,
                                 labelOptions = labelOptions(noHide = T, 
                                                             direction = 'top', 
                                                             textOnly = TRUE))
  return(m)
}


m <- createmap()

groupes <- c("Mahe - Nord", "Mahe - Pêche", "Mahe - Centre", "Mahe - Sud")
#j1
group <- groupes[1]
b <- places_points[places_points$jour == 1,]
m <- addplace(m, b, group)
data <- eval(as.name("routesj1"))
m <- addroad(m, data, group)


#j2
group <- 

b <- places_points[places_points$jour == 2,]
m <- addplace(m, b, group)
m <- addroad(m, routesj2, group)

#j3
group <- 

b <- places_points[places_points$jour == 3,]
m <- addplace(m, b, group)
m <- addroad(m, routesj3, group)

#j4
group <- 

b <- places_points[places_points$jour == 4,]
m <- addplace(m, b, group)
m <- addroad(m, routesj4, group)


#Praslin
group <- "Praslin"

b <- places_points[places_points$jour == 5,]
m <- addplace(m, b, group)
m <- addroad(m, routes_Praslin, group)

#La Digue
group <- "La Digue"

b <- places_points[places_points$jour == 6,]
m <- addplace(m, b, group)
m <- addroad(m, routes_Digue, group)



m <- addLayersControl(m, 
      overlayGroups = c("J1", "J2", "J3"),
      options = layersControlOptions(collapsed = FALSE)
)

m


saveWidget(m, "map.html", selfcontained = TRUE)

#######################
#m <- m %>% addMarkers(data = places_points, label = ~name,
#                     #icone="none",
#                     clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = T),
#                    labelOptions = labelOptions(noHide = T, direction = 'auto'))#~sqrt(Pop) * 30, popup = ~City)

m <- m %>% addLabelOnlyMarkers(data = a,
                               label = ~name, group="Lieux",
                               labelOptions = labelOptions(noHide = T, 
                                                           direction = 'top', 
                                                           textOnly = TRUE))

m <- addPolylines(map = m, data = routes, opacity = 100, 
                  color = "#000000", 
                  weight = 0.5)
a <- places_points[!is.na(places_points$explore),]

