#201603 Data preprocess
##set the data path
setwd("/Users/jasonlin/Documents/2015-2016 學習專案/2016 DSP資料科學冬令營/day 4/資料集")

##loading the data
table.1 <- read.csv("老人宜居.csv", sep = ",")
table.2 <- read.csv("志工隊.csv", sep = ",")

colnames(table.1)[1] <- "group" 


##Analysis the correlation within the data
cor(data[,5],data[,2])  # -0.329002
cor(data[,5],data[,3])  # -0.3719783
cor(data[,5],data[,4])  # -0.2193129
cor(data[,5],data[,6])  # 0.007239428
cor(data[,5],data[,7])  # -0.4154996
cor(data[,5],data[,8])  # -0.48685
cor(data[,5],data[,9])  # -0.4872428
cor(data[,5],data[,10]) # -0.09994881
cor(data[,5],data[,11]) # -0.06659426
cor(data[,5],data[,12]) # -0.2641749
cor(data[,5],data[,13]) # 0.007322323

x <- c(0.6709980, 0.6280217, 0.7806871, 0.9927606, 0.5845004, 0.5131500,
       0.5127572, 0.9000512, 0.9334057, 0.7358251, 0.9926777)
# 權重正規化
x1 <- x/sum(x) # 0.08138405 0.07617153 0.09468802 0.12041001 0.07089292 0.06223897 
#  0.06219133 0.10916546 0.11321097 0.08924680 0.12039995

# 散佈圖
library(ggplot2)
ggplot(data, aes(x=老年人口比例, y=病床, colour=地區, size=病床, label=地區))+
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=醫護人員, colour=地區, size=醫護人員, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=安養院, colour=地區, size=安養院, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=醫院, colour=地區, size=醫院, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=診所, colour=地區, size=診所, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=公園, colour=地區, size=10*公園, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=綠地面積.m., colour=地區, size=綠地面積.m., label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=慈善機構, colour=地區, size=慈善機構, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=計程車招呼站, colour=地區, size=計程車招呼站, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=志工隊, colour=地區, size=志工隊, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))

ggplot(data, aes(x=老年人口比例,y=wifi熱點, colour=地區, size=wifi熱點, label=地區)) +
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))


ggplot(data, aes(x=地區,y=指標, colour=地區, size=指標, label=地區))+
  geom_point() + geom_text(aes(label=地區),hjust=1, vjust=2) + scale_size(range=c(4,9))