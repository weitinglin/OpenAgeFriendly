#201603 DSP team, code archive
#Beta
#plotMap

#====================================================================
#load the library
library(ggplot2)
library(maptools)
library(dplyr)
library(rgdal)
library(rgeos) # use the 'R CMD install' to install "rgeos_0.3-17.tgz"
library(wesanderson)
library(ggmap)
library(broom)
library("PBSmapping")
#====================================================================
#setting the data path

setwd("/Users/jasonlin/Documents/R_scripts/OpenAgeFriendly/data/rawdata/geodata")
data.path <- file.path("/Users/jasonlin/Documents/R_scripts/OpenAgeFriendly/data/rawdata/geodata",
                       file = "Town_MOI_1041215.shp")
#====================================================================
#read the GeoData information with the readOGR 
ogrInfo(dsn=data.path,layer = "Town_MOI_1041215", encoding = "big5")
y <- readOGR(dsn=data.path,layer = "Town_MOI_1041215")
summary(y)
ogrListLayers(dsn=data.path)
ogrFIDs(dsn=data.path,layer = "Town_MOI_1041215")
ogrDrivers()
plot(y)

#====================================================================
#Preprocessing the 
#Subseting the area to Taichung
Taichung <- y[y$C_Name == "臺中市",]
summary(Taichung)


#get the centroid information
centroids.df <- as.data.frame(coordinates(Taichung))
names(centroids.df) <- c("Longitude", "Latitude")
row.names(centroids.df) <- Taichung$group
centroids.df <- centroids.df %>% arrange(Longitude,Latitude)



#====================================================================
#Transform the data into tidy dataframe
summary(Taichung)
Taichung    <- tidy(Taichung, region = "T_Name")
Taichung$group <- gsub(".1","",Taichung$group)

Basic <- Taichung %>% 
  group_by(group) %>% 
  summarize( long = mean(long), lat = mean(lat),order = mean(order)) %>%
  arrange(long, lat)

combind.db <- data.frame(Basic, centroids.df)
combind.db <- combind.db[,c(1,5:6)]

plot.data<- left_join(combind.db,table.1, by = "group")

#====================================================================
#Plot 
thm <- function() theme(text=element_text(size=20, family="STHeiti"))
ggplot() + geom_map(data = plot.data, aes(map_id = plot.data$group, fill = 公園, alpha = 醫院), 
                    map = Taichung) + expand_limits(x = Taichung$long, y = Taichung$lat)+
  geom_text(aes(label = plot.data$group, x = plot.data$Longitude, y = plot.data$Latitude))+thm()+
  scale_alpha(range = c(0.2, 1), na.value = 0.1)
  
  
  
