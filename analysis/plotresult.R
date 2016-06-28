#Plot the result
#index plotting for 4 indexes
#====================================================================
localdata <- integratData %>% filter(name_ch =="嘉義市")
name_trans <- data[,c(1,2)][20,]
colnames(name_trans) <- c("name_ch","name_en")
localdata$name_en <- name_trans[,2]

y.sub$Equity               <- localdata$equity
y.sub$AgeFriendlyPhysical  <- localdata$age_friendly_physical_env
y.sub$AgeFriendlySocial    <- localdata$age_friednly_social_env
y.sub$QualityOfLife        <- localdata$quality_of_life


local_equity <- geom_polygon(data = y.sub, colour = "lightgrey", size = 0.5, aes(x =long,y =lat,group = group, fill = Equity))
local_social <- geom_polygon(data = y.sub, colour = "lightgrey", size = 0.5, aes(x =long,y =lat,group = group, fill = AgeFriendlySocial))
local_physical <- geom_polygon(data = y.sub, colour = "lightgrey", size = 0.5, aes(x =long,y =lat,group = group, fill = AgeFriendlyPhysical))
local_quality <- geom_polygon(data = y.sub, colour = "lightgrey", size = 0.5, aes(x =long,y =lat,group = group, fill = QualityOfLife))

#equity
ggmap(myMap3)+
  geom_polygon(data = data_combine ,colour = "lightgrey",
               size = 0.5,alpha = 0.7,
               aes(x = long, y = lat, group = id, fill = equity))+
  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
  thm()+labs(title = "AgeFriendlyCity: Equity",x="",y="")+scale_fill_gradient(low ="red", high = "green")+
  local_equity
#age_fridenly_physical_env
ggmap(myMap3)+
  geom_polygon(data = data_combine ,colour = "lightgrey",
               size = 0.5,alpha = 0.7,
               aes(x = long, y = lat, group = id, fill = age_fridenly_physical_env))+
  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
  thm()+labs(title = "AgeFriendlyCity: Physical Environment",x="",y="")+scale_fill_gradient(low ="red", high = "green")+
  local_physical
#age_friendly_social_env
ggmap(myMap3)+
  geom_polygon(data = data_combine ,colour = "lightgrey",
               size = 0.5,alpha = 0.7,
               aes(x = long, y = lat, group = id, fill = age_friendly_social_env))+
  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
  thm()+labs(title = "AgeFriendlyCity: Social Environment",x="",y="")+scale_fill_gradient(low ="red", high = "green")+
  local_social
#quality_of_life
ggmap(myMap3)+
  geom_polygon(data = data_combine ,colour = "lightgrey",
               size = 0.5,alpha = 0.7,
               aes(x = long, y = lat, group = id, fill = age_friendly_social_env))+
  geom_text(data = Basic, aes(label = Basic$group,x = Basic$long,y=Basic$lat)) +
  thm()+labs(title = "AgeFriendlyCity: Quality of life",x="",y="")+scale_fill_gradient(low ="red", high = "green")+
  local_quality

#Total Heat Map======================================================
#data reshape

name_trans <- data[,c(1,2)]
colnames(name_trans) <- c("name_ch","name_en")
integratData <- left_join(integratData,name_trans, by = "name_ch")
integratData <- integratData[,c(1,6,2,3,4,5)]
colnames(integratData) <- c("name_ch",
                            "name_en",
                            "Equity",
                            "AgeFriendlyPhysical",
                            "AgeFriendlySocial",
                            "QualityOfLife")
reshapeData <- integratData %>% gather("Indicator","Value",3:6)
#data visualization
ggplot(data = reshapeData, aes( x = Indicator, y = name_en)) +
  geom_tile(aes(fill = Value),colour ="black",size = 2) +
  scale_fill_gradient( low = "#FF3300" , high = "#006600")+
  labs(title = "The 4 Core Indicators For Age-Friendly City",x="",y="")


ggplot(data = reshapeData, aes( x = Indicator, y = name_en)) +
  geom_tile(aes(fill = Value),colour ="black",size = 1.8) +
  scale_fill_gradient( low = "#FF3300" , high = "#00FF00")+
  labs(title = "The 4 Core Indicators For Age-Friendly City",x="",y="")+
  theme(axis.text = element_text(size = 14,lineheight =2),
        plot.title = element_text(size = 18, vjust = 2,lineheight = 20))

ggplot(data = reshapeData, aes( x = Indicator, y = name_en)) +
  geom_tile(aes(fill = Value),colour ="black",size = 1.8) +
  scale_fill_gradient( low = "#FF3300" , high = "#00FF00")+
  labs(title = "The 4 Core Indicators For Age-Friendly City",x="",y="")+
  theme(axis.text = element_text(size = 14,lineheight =2),
        plot.title = element_text(size = 18, vjust = 2,lineheight = 20))+
  geom_text(aes(x = reshapeData$Indicator,
                y = reshapeData$name_en,
                label = round(reshapeData$Value,1)))
