library(tidyverse)
#
#birth year column might not be useful and can have outliers 
#keep single focus of analysis - effect of weather on the system 
#capacity data - just focus on demand prediction for each station 
#don't use JC data 
#do one year 1-12 then extract a sample like 5% of total data for preliminary work 

#Import all data of all months in 2019 
jan_bike <- read.csv("201901-citibike-tripdata.csv")
feb_bike <- read.csv("201902-citibike-tripdata.csv")
mar_bike <- read.csv("201903-citibike-tripdata.csv")
apr_bike <- read.csv("201904-citibike-tripdata.csv")
may_bike <- read.csv("201905-citibike-tripdata.csv")
jun_bike <- read.csv("201906-citibike-tripdata.csv")
jul_bike <- read.csv("201907-citibike-tripdata.csv")
aug_bike <- read.csv("201908-citibike-tripdata.csv")
sep_bike <- read.csv("201909-citibike-tripdata.csv")
oco_bike <- read.csv("201910-citibike-tripdata.csv")
nov_bike <- read.csv("201911-citibike-tripdata.csv")
dec_bike <- read.csv("201912-citibike-tripdata.csv")

#combine data and get train&test data
bike_total_2019<- rbind(jan_bike,feb_bike,mar_bike,apr_bike,may_bike,jun_bike,jul_bike,aug_bike,sep_bike,oco_bike,nov_bike,dec_bike)
set.seed(12345)
bike_index <- sample(1:nrow(bike_total_2019),nrow(bike_total_2019))

#extract 5% of total dataset for modeling so that data size is not too big
bike_part_5perc <- bike_total_2019[bike_index[1:(0.05*nrow(bike_total_2019))],]
bike_train <- bike_part_5perc[1:(0.8*nrow(bike_part_5perc)),]
bike_test <- bike_part_5perc[(0.8*nrow(bike_part_5perc)):nrow(bike_part_5perc),]

##Extract year, month, day, hour and min to be used for relational keys to match with weather data
bike_train$start_year <- as.factor(substr(bike_train$starttime,1,4))
bike_train$start_mth <- as.factor(substr(bike_train$starttime,6,7))
bike_train$start_day <- as.factor(substr(bike_train$starttime,9,10))
bike_train$start_hr <- as.factor(substr(bike_train$starttime,12,13))
bike_train$start_min <- as.factor(substr(bike_train$starttime,15,16))

bike_test$start_year <- as.factor(substr(bike_test$starttime,1,4))
bike_test$start_mth <- as.factor(substr(bike_test$starttime,6,7))
bike_test$start_day <- as.factor(substr(bike_test$starttime,9,10))
bike_test$start_hr <- as.factor(substr(bike_test$starttime,12,13))
bike_test$start_min <- as.factor(substr(bike_test$starttime,15,16))

##Extract year, month, date for end day
bike_train$stop_year <- as.factor(substr(bike_train$stoptime,1,4))
bike_train$stop_mth <- as.factor(substr(bike_train$stoptime,6,7))
bike_train$stop_day <- as.factor(substr(bike_train$stoptime,9,10))
bike_train$stop_hr <- as.factor(substr(bike_train$stoptime,12,13))
bike_train$stop_min <- as.factor(substr(bike_train$stoptime,15,16))

bike_test$stop_year <- as.factor(substr(bike_test$stoptime,1,4))
bike_test$stop_mth <- as.factor(substr(bike_test$stoptime,6,7))
bike_test$stop_day <- as.factor(substr(bike_test$stoptime,9,10))
bike_test$stop_hr <- as.factor(substr(bike_test$stoptime,12,13))
bike_test$stop_min <- as.factor(substr(bike_test$stoptime,15,16))

#convert birth year before 1920 to median of the data set since we assume no one who is over 100 years old would ride the bike. the data point might be mis-entry 
train_index_1920 <- bike_train$birth.year <= 1920
bike_train_birth <- bike_train
bike_train_birth$birth.year[train_index_1920] <- median(bike_train_birth$birth.year)

test_index_1920 <- bike_test$birth.year <= 1920
bike_test_birth <- bike_test
bike_test_birth$birth.year[test_index_1920] <- median(bike_test_birth$birth.year)

#Check weather data
nycw <- read.csv("nycweather.csv")

nycw$start_year <- as.numeric(substr(nycw$Date,1,4))
nycw_2019 <- subset(nycw,start_year == 2019)

nycw_2019$start_year <- as.factor(nycw_2019$start_year)
nycw_2019$start_mth <- as.factor(substr(nycw_2019$Date,6,7))
nycw_2019$start_day <- as.factor(substr(nycw_2019$Date,9,10))

#remove duplicates
library(tidyverse)
nycw_2019 <-distinct(nycw_2019)
nycw_2019 <- nycw_2019[-181,] #found two rows for 6/30/2019
str(nycw_2019)

#merge bike data with weather data 
bike_weather_train <- merge(bike_train,nycw_2019,by.x = c("start_year","start_mth","start_day"), by.y = c("start_year","start_mth", "start_day"))
str(bike_weather_train)

bike_weather_test <- merge(bike_test,nycw_2019,by.x = c("start_year","start_mth","start_day"), by.y = c("start_year","start_mth", "start_day"))
str(bike_weather_test)

#clean up the data 
bike_weather_train$bikeid <- as.factor(bike_weather_train$bikeid)
bike_weather_test$bikeid <- as.factor(bike_weather_test$bikeid)

#write train and test data to CSV file 
write.csv(bike_weather_train,"D:\\School\\Master Program - IOE\\Winter 2020\\Team project\\bike_weather_train_5perc_new.csv")
write.csv(bike_weather_test,"D:\\School\\Master Program - IOE\\Winter 2020\\Team project\\bike_weather_test_5perc.csv")


