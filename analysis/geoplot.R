#shaping the the geodata, implemented the geography with the transformation data
#====================================================================
library(maptools)
library(rgdal)
library(tidyr)
library(rgeos) # use the 'R CMD install' to install "rgeos_0.3-17.tgz"
library(broom)
library(plotly)

#====================================================================
#make a beautiful plot
data.path <- file.path("/Users/Weitinglin/Documents/R_scripts/OpenAgePractice/data/geodata",
                       file = "County_MOI_1041215.shp")
y <- readOGR(dsn=data.path,layer = "County_MOI_1041215")


#subset: to remove the small island area
y <- y[(y$C_Name != "連江縣" & y$C_Name != "金門縣" & y$C_Name != "澎湖縣"),]

#====================================================================
y    <- fortify(y, region = "C_Name")


Basic <- y %>%
  group_by(group) %>%
  summarize( long = mean(long), lat = mean(lat),order = mean(order)) %>%
  arrange(long, lat)

#font family problem
thm <- function() theme(text=element_text(size=24, lineheight = 10, family="STHeiti", colour ="Black"))


#clean the island region
y.sub <- y%>% filter(group %in% c("嘉義市.1"))
y <- y%>% filter(group %in% c("高雄市.1","花蓮縣.1","基隆市.1","嘉義縣.1",
                              "苗栗縣.1","南投縣.1","屏東縣.1","臺北市.1","臺東縣.1",
                              "臺南市.1","臺中市.1","桃園市.1","新北市.1","新竹市.1",
                              "新竹縣.1","宜蘭縣.1","雲林縣.1","彰化縣.1"))

Basic <- Basic %>% filter( group %in% c("高雄市.1","花蓮縣.1","基隆市.1","嘉義市.1","嘉義縣.1",
                                        "苗栗縣.1","南投縣.1","屏東縣.1","臺北市.1","臺東縣.1",
                                        "臺南市.1","臺中市.1","桃園市.1","新北市.1","新竹市.1",
                                        "新竹縣.1","宜蘭縣.1","雲林縣.1","彰化縣.1"))


#smooth the boundary of the county and city
y %>% group_by(group) %>% summarize(n = n())
y <- y[seq(from = 1, to = 214997, by = 3 ),]
y <- y[seq(from = 1, to = 71666, by = 3 ),]
y <- y[seq(from = 1, to = 23889, by = 2 ),]
y <- y[seq(from = 1, to = 11945, by = 2 ),]
y <- y[seq(from = 1, to = 5973, by = 2 ),]
ggplot(data = y, aes(x = long, y = lat))+
  geom_polygon(colour = "black", size = 0.5, aes(group = group))+
  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
  thm()+geom_polygon(data = y.sub, colour = "black", size = 0.5, aes(x =long,y =lat,group = group))

#y <- bind_rows(y,y.sub) %>% arrange(order)
#locally draw
#local <- geom_polygon(data = y.sub, colour = "black", size = 0.5, aes(x =long,y =lat,group = group))
#combine the data with integratData + Basic
colnames(integratData) <- c("id","equity",
                            "age_fridenly_physical_env","age_friendly_social_env",
                            "quality_of_life")

data_combine <- left_join(y,integratData, by = "id")

#change the character
name_trans <- data[,c(1,2)]
colnames(name_trans) <- c("group","name_en")
Basic$group  <- gsub("\\.1","",Basic$group)
Basic <- left_join(Basic,name_trans,by = "group")
colnames(Basic) <- c("name_ch","long","lat","order","group")

#shift the text position to avoid interrupt
#(120.5934,23.91997)
Basic[Basic$group == "Changhua County",]$long <- 120.4734
Basic[Basic$group == "Changhua County",]$lat  <- 24
#(120.5244,23.45374)
Basic[Basic$group == "Chiayi County",]$long <- 120.0201
Basic[Basic$group == "Chiayi County",]$lat  <- 23.48009
#(120.4501,23.48009)
Basic[Basic$group == "Chiayi City",]$long <- 120.5944
Basic[Basic$group == "Chiayi City",]$lat  <- 23.39574
#(120.5390,23.63883)
Basic[Basic$group == "Yunlin County",]$long <- 120.4390
Basic[Basic$group == "Yunlin County",]$lat  <- 23.72483
#(120.9861,24.53288)
Basic[Basic$group == "Miaoli County",]$long <- 120.9361
Basic[Basic$group == "Miaoli County",]$lat  <- 24.49000
#(121.1137,24.72026)
Basic[Basic$group == "Hsinchu County",]$long <- 121.1137
Basic[Basic$group == "Hsinchu County",]$lat  <- 24.65026
#(120.9655,24.77159)
Basic[Basic$group == "Hsinchu City",]$long <- 120.9055
Basic[Basic$group == "Hsinchu City",]$lat  <- 24.83
#(121.5653,25.06835)
Basic[Basic$group == "Taipei City",]$long <- 121.5653
Basic[Basic$group == "Taipei City",]$lat  <- 25.24
#(120.7387,22.36947)
Basic[Basic$group == "Pingtung County",]$long <- 121.0387
Basic[Basic$group == "Pingtung County",]$lat  <- 22.32947
#(121.1653,22.97835)
Basic[Basic$group == "Taitung County",]$long <- 121.2553
Basic[Basic$group == "Taitung County",]$lat  <- 23
#(120.5627,22.98784)
Basic[Basic$group == "Kaohsiung City",]$long <- 120.5627
Basic[Basic$group == "Kaohsiung City",]$lat  <- 22.75784
#(121.7002,24.68127)
Basic[Basic$group == "Yilan County",]$long <- 120.9627
Basic[Basic$group == "Yilan County",]$lat  <- 22.95784

#==========================================
#To test the text place
#==========================================
#ggplot(data = data_combine, aes(x = long, y = lat))+
#  geom_polygon(colour = "lightblue", size = 0.5, aes(group = id, fill = quality_of_life))+
#  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
#  thm()

#g <- ggplot(data = data_combine, aes(x = long, y = lat))+
#  geom_polygon(colour = "lightblue", size = 0.5, aes(group = id, fill = quality_of_life))+
#  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
#  thm()




==========================================
#       load new library: ggmap
#       to load the map as the layer for polygon
===========================================
library(ggmap)
#define the boundary of the map
myLocation <- c(120,21.91,122,25.3)
#myMap <- get_map(location= myLocation,
#                 source="osm", crop=FALSE)
#myMap2 <- get_map(location= myLocation,
#                 source="osm",color = "bw", crop=FALSE)
myMap3 <- get_map(location= myLocation,
                  source="stamen",maptype = "watercolor", crop=FALSE)

#style one: use the colour of light blue
ggmap(myMap3)+
  geom_polygon(data = data_combine ,colour = "lightblue",
               size = 0.5,alpha = 0.7,
               aes(x = long, y = lat, group = id, fill = quality_of_life))+
  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
  thm()

#style two: use the colour of lightgrey
g <- ggmap(myMap3)+
  geom_polygon(data = data_combine ,colour = "lightgrey",
               size = 0.5,alpha = 0.7,
               aes(x = long, y = lat, group = id, fill = quality_of_life))+
  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
  thm()+labs(title = "AgeFriendlyCity",x="",y="")+scale_fill_gradient(low ="red", high = "green")
