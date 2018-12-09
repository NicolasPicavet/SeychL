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

mai <- readOGR("mai.shp")

places_points <- readOGR("lieux_vacs.shp", use_iconv = TRUE, encoding = "UTF-8")
hebergement <- readOGR("hebergement.shp", use_iconv = TRUE, encoding = "UTF-8")
hebergement <- as.data.frame(hebergement)
colnames(hebergement)[3] <- "lng"
colnames(hebergement)[4] <- "lat"

# fonctions

createmap <- function () {
  ## Initialisation 
  m <- leaflet(padding = 0, hebergement) %>% addMarkers(~lng, ~lat, icon = makeIcon("house.png", iconWidth = 15), group= "hebergements")
  
  m <- m %>% addTiles()%>% fitBounds(     lng1 = 55.25,#55.1977,
                                               lat1 = -4.6555,#-4.5292,
                                               lng2 = 55.68,#55.7367, 
                                               lat2 = -4.6560)#-4.8471)
  ## Ajout des iles
#  m <- addPolygons(map = m, data = iles,  opacity = 100,    color = "#454545", 
#                   weight = 0.25,popup = NULL,  options = list(clickable = FALSE),           fill = T, fillColor = "#B3C4B3",      fillOpacity = 100)
  return(m)
}

addroad <- function(m, data, group) {
  m <- addPolylines(map = m, data = data, group = group)#,            highlightOptions = highlightOptions(color = "white", weight = 2,                                                        bringToFront = TRUE))
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



groupes <- c("Mahe - Nord", "Mahe - Pêche", "Mahe - Centre", "Mahe - Sud", "Praslin", "La Digue", "hebergements")
lesroutes <- c("routesj1", "routesj2", "routesj3", "routesj4", "routes_Praslin", "routes_Digue")


addsequences <- function(ind, m) {
  group <- groupes[ind]

  b <- places_points[places_points$jour == ind,]  
  m <- addplace(m, b, group)
  
  data <- eval(as.name(lesroutes[ind]))
  m <- addroad(m, data, group)
  return(m)   
}

m <- createmap()
m <- addsequences(1, m)
m <- addsequences(2, m)
m <- addsequences(3, m)

m <- addPolygons(map = m, data = mai, group= "Praslin",
                 opacity = 100, 
                 color = "#454545", 
                 weight = 0.25,popup = NULL,
                 options = list(clickable = FALSE), 
                 fill = T, fillColor = "#00FF33", 
                 fillOpacity = 100)
m <- addsequences(4, m)
m <- addsequences(5, m)


m <- addLayersControl(m, 
      overlayGroups = groupes,
      options = layersControlOptions(collapsed = FALSE))

m <- hideGroup(m, groupes)


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

