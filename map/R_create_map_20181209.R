#####################
#### SIG ####
#####################

#install.packages('rgdal')
#install.packages('leaflet')
library(rgdal)
library(leaflet)
library("htmlwidgets")
library(dplyr)
library(htmltools)

setwd("C:/Users/Myriam/Documents/0- Myriam/Projets/SeychL/map")

# Ouvrir un shapefile
iles <- readOGR("iles_vacs.shp")
plages <- readOGR("plages_vacs.shp")
plages <- plages[plages$explore== 1,]
#buildings <- readOGR("buildings.shp")


routes <- readOGR("routes_pst_vacances4326.shp")
routes_avion <- readOGR("routes_avion.shp")
routesj1 <- readOGR("routes_j1.shp")
routesj2 <- readOGR("routes_j2.shp")
routesj3 <- readOGR("routes_j3.shp")
routesj4 <- readOGR("routes_j4.shp")
routes_Praslin <- readOGR("routes_Praslin.shp")
chemin_mai <- readOGR("chemin_mai.shp")
routes_Digue <- readOGR("routes_Digue.shp")

mai <- readOGR("mai.shp")

places_points <- readOGR("lieux_vacs.shp", use_iconv = TRUE, encoding = "UTF-8")
places_points <- as.data.frame(places_points)
places_points <- places_points %>% filter(explore != 0)
colnames(places_points)[8] <- "lng"
colnames(places_points)[9] <- "lat"

hebergement <- readOGR("hebergement.shp", use_iconv = TRUE, encoding = "UTF-8")
hebergement <- as.data.frame(hebergement)
colnames(hebergement)[3] <- "lng"
colnames(hebergement)[4] <- "lat"

groupes <- c("Mahe - Nord", "Mahe - Pêche", "Mahe - Centre", "Mahe - Sud", "Praslin", "La Digue", "Avion", "Hébergements")
lesroutes <- c("routesj1", "routesj2", "routesj3", "routesj4", "routes_Praslin", "routes_Digue", "routes_avion")



# fonctions
createmap <- function () {
  ## Initialisation 
  m <- leaflet(padding = 0)
  
  ## Ajout des iles
  m <- m %>% addTiles(group = "OSM", options = providerTileOptions(maxZoom = 17))
  m <- m %>% addProviderTiles(providers$OpenTopoMap, group = "ESRI")
  m <- m %>% addProviderTiles(providers$Stamen.TonerLite, group = "Stamen")
  m <- addPolygons(map = m, data = iles,  group = "Iles",
                   opacity = 100,    color = "#454545", 
                   weight = 0.25, fill = T, fillColor = "#B3C4B3",   fillOpacity = 100)
  m <- addPolylines(map = m, data = routes, group = "Iles", color = "#FFCC00", opacity = 0.8)
  
  return(m)
}

addroad <- function(m, data, group, weight = 4) {
  m <- addPolylines(map = m, data = data, group = group, 
                    #options = list(clickable = FALSE),
                    weight = weight, 
                    color= "#0099FF",
                    opacity = 1)#,            highlightOptions = highlightOptions(color = "white", weight = 2,                                                        bringToFront = TRUE))
  return(m)
}

addplace <- function(m, data, group, color = "#3399FF") {
  m <- m %>% addCircleMarkers(data = data, ~lng, ~lat, group = group, 
                              stroke = FALSE, color = color, fillOpacity = 0.7,label = ~htmlEscape(name))#,          labelOptions(lapply(1:nrow(data), function (x) {labelOptions()})))#,
                             # clusterOptions = markerClusterOptions(removeOutsideVisibleBounds = F))
  return(m)
}


addsequences <- function(ind, m) {
  group <- groupes[ind]

  b <- places_points[places_points$jour == ind,]  
  if (nrow(b) > 0) {
    m <- addplace(m, b, group)    
  }

  data <- eval(as.name(lesroutes[ind]))
  m <- addroad(m, data, group)
  return(m)   
}

m <- createmap()

#m <- m %>% addMarkers(data = hebergement, ~lng, ~lat, icon = makeIcon("house.png", iconWidth = 15), group= groupes[length(groupes)])
m <- addplace(m, hebergement, groupes[length(groupes)], "red")
m <- addsequences(7, m)
m <- addsequences(1, m)
m <- addsequences(2, m)
m <- addsequences(3, m)

m <- addPolygons(map = m, data = mai, group= "Praslin",
                 opacity = 100, color = "#006600", 
                 weight = 1, popup = NULL,
                 options = list(clickable = FALSE), 
                 fill = F)
#m <- m %>%  addPolylines(data = chemin_mai, group = "Praslin", color = "#00CCFF",  weight = 3,  opacity = 100)
m <- addroad(m, chemin_mai, "Praslin", weight = 2)
m <- addsequences(4, m)
m <- addsequences(5, m)
m <- addsequences(6, m)

m <- addPolygons(map = m, data = plages,  group = "Avion",
                 opacity = 100,    color = "#FF6600", 
                 weight = 1, fill = T, fillColor = "#B3C4B3",   fillOpacity = 100)


m <- addLayersControl(m, 
      baseGroups = c("OSM","ESRI", "Stamen", "Iles"),
      overlayGroups = c(groupes[(length(groupes)-1)], groupes[1:(length(groupes)-2)]), #groupes[length(groupes)], 
      options = layersControlOptions(collapsed = FALSE))

m <- hideGroup(m, groupes[1:6])

m


saveWidget(m, "map.html", selfcontained = TRUE)
