#201603 Data preprocess
#set working directory
setwd("/Users/Weitinglin/Documents/R_scripts/OpenAgePractice/data")

#load library
library(dplyr)
library(readr)
library(magrittr)
library(ggplot2)
library(tidyr)

#data input
data <- read_csv("raw.csv")

#data exploratory
str(data)


#data normalization
normalizedData <- data %>% transmute(name_ch = name_ch,
                                     av_family_number = (av_family_number - min(av_family_number) )/(max(av_family_number)-min(av_family_number)),
                                     av_family_income = (av_family_income - min(av_family_income) )/(max(av_family_income)-min(av_family_income)) ,
                                     family_income_SD = (family_income_SD - min(family_income_SD))/(max(family_income_SD)-min(family_income_SD)),
                                     house_income_ratio = (house_income_ratio - min(house_income_ratio))/(max(house_income_ratio)-min(house_income_ratio)),
                                     public_transportation_usage_rate = (public_transportation_usage_rate - min(public_transportation_usage_rate))/(max(public_transportation_usage_rate)-min(public_transportation_usage_rate)),
                                     av_green_space_per_person = (av_green_space_per_person - min(av_green_space_per_person))/(max(av_green_space_per_person)-min(av_green_space_per_person)),
                                     av_family_spending_healthcare = (av_family_spending_healthcare - min(av_family_spending_healthcare))/(max(av_family_spending_healthcare)-min(av_family_spending_healthcare)),
                                     av_family_spending_leisure = (av_family_spending_leisure - min(av_family_spending_leisure))/(max(av_family_spending_leisure)-min(av_family_spending_leisure)),
                                     av_family_spending_IT_communicate = (av_family_spending_IT_communicate - min(av_family_spending_IT_communicate))/(max(av_family_spending_IT_communicate)-min(av_family_spending_IT_communicate)),
                                     number_of_healcare_institutes = (number_of_healcare_institutes - min(number_of_healcare_institutes))/(max(number_of_healcare_institutes)-min(number_of_healcare_institutes)),
                                     number_doctors_per_tenthouand = (number_doctors_per_tenthouand - min(number_doctors_per_tenthouand))/(max(number_doctors_per_tenthouand)-min(number_doctors_per_tenthouand)),
                                     number_doctors_per_tenthousand_elder = (number_doctors_per_tenthousand_elder - min(number_doctors_per_tenthousand_elder))/(max(number_doctors_per_tenthousand_elder)-min(number_doctors_per_tenthousand_elder)),
                                     best_retired_place_rated_national_voted = (best_retired_place_rated_national_voted - min(best_retired_place_rated_national_voted))/(max(best_retired_place_rated_national_voted)-min(best_retired_place_rated_national_voted))
)
#data transformation
transData <- normalizedData %>% transmute(name_ch = name_ch,
                                          av_family_number = av_family_number,
                                          av_family_income = av_family_income,
                                          family_income_SD = 1 - family_income_SD,
                                          house_income_ratio = 1 - house_income_ratio,
                                          public_transportation_usage_rate = public_transportation_usage_rate,
                                          av_green_space_per_person = av_green_space_per_person,
                                          av_family_spending_healthcare = av_family_spending_healthcare,
                                          av_family_spending_leisure = av_family_spending_leisure,
                                          av_family_spending_IT_communicate = av_family_spending_IT_communicate,
                                          number_of_healcare_institutes = number_of_healcare_institutes,
                                          number_doctors_per_tenthousand_elder = number_doctors_per_tenthousand_elder,
                                          best_retired_place_rated_national_voted = best_retired_place_rated_national_voted
)




#data integration
# 4 indicator : equity, age_friendly_physical_env, age_friendly_social_env, quality_of_life
integratData <- transData %>% transmute( name_ch = name_ch,
                                         equity = (av_family_number + av_family_income + family_income_SD)/3,
                                         age_friendly_physical_env = (house_income_ratio + public_transportation_usage_rate + av_green_space_per_person )/3,
                                         age_friednly_social_env = (av_family_spending_healthcare + av_family_spending_leisure + av_family_spending_IT_communicate + number_of_healcare_institutes + number_doctors_per_tenthousand_elder)/5,
                                         quality_of_life = best_retired_place_rated_national_voted )
integratData %>% transmute( name_en = name_en, index = (equity + age_friednly_social_env + age_friendly_physical_env + quality_of_life)/4 ) %>% arrange(index)
