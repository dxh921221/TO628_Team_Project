library(tidyverse)

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

bike_part_5perc <- bike_total_2019[bike_index[1:(0.05*nrow(bike_total_2019))],]
bike_train <- bike_part_5perc[1:(0.8*nrow(bike_part_5perc)),]
bike_test <- bike_part_5perc[(0.8*nrow(bike_part_5perc)):nrow(bike_part_5perc),]

##Extract year, month, date from bike data
bike_train$start_year <- as.factor(substr(bike_train$starttime,1,4))
bike_train$start_mth <- as.factor(substr(bike_train$starttime,6,7))
bike_train$start_day <- as.factor(substr(bike_train$starttime,9,10))

bike_test$start_year <- as.factor(substr(bike_test$starttime,1,4))
bike_test$start_mth <- as.factor(substr(bike_test$starttime,6,7))
bike_test$start_day <- as.factor(substr(bike_test$starttime,9,10))

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


#write train and test data to CSV file 
write.csv(bike_weather_train,"D:\\School\\Master Program - IOE\\Winter 2020\\Team project\\bike_weather_train_5perc.csv")
write.csv(bike_weather_test,"D:\\School\\Master Program - IOE\\Winter 2020\\Team project\\bike_weather_test_5perc.csv")






####################################################################################################################################
#separate data into train and test data set 
set.seed(12345)
jan_index <- sample(1:nrow(jan_bike),nrow(jan_bike))
jan_train <- jan_bike[jan_index[1:round((0.8*length(jan_index)))],]
jan_test <- jan_bike[jan_index[round((0.8*length(jan_index))):nrow(jan_bike)],]

set.seed(12345)
feb_index <- sample(1:nrow(feb_bike),nrow(feb_bike))
feb_train <- feb_bike[feb_index[1:round((0.8*length(feb_index)))],]
feb_test <- feb_bike[feb_index[round((0.8*length(feb_index))):nrow(feb_bike)],]

set.seed(12345)
mar_index <- sample(1:nrow(mar_bike),nrow(mar_bike))
mar_train <- mar_bike[mar_index[1:round((0.8*length(mar_index)))],]
mar_test <- mar_bike[mar_index[round((0.8*length(mar_index))):nrow(mar_bike)],]

set.seed(12345)
apr_index <- sample(1:nrow(apr_bike),nrow(apr_bike))
apr_train <- apr_bike[apr_index[1:round((0.8*length(apr_index)))],]
apr_test <- apr_bike[apr_index[round((0.8*length(apr_index))):nrow(apr_bike)],]

set.seed(12345)
may_index <- sample(1:nrow(may_bike),nrow(may_bike))
may_train <- may_bike[may_index[1:round((0.8*length(may_index)))],]
may_test <- may_bike[may_index[round((0.8*length(may_index))):nrow(may_bike)],]

set.seed(12345)
jun_index <- sample(1:nrow(jun_bike),nrow(jun_bike))
jun_train <- jun_bike[jun_index[1:round((0.8*length(jun_index)))],]
jun_test <- jun_bike[jun_index[round((0.8*length(jun_index))):nrow(jun_bike)],]

set.seed(12345)
jul_index <- sample(1:nrow(jul_bike),nrow(jul_bike))
jul_train <- jul_bike[jul_index[1:round((0.8*length(jul_index)))],]
jul_test <- jul_bike[jul_index[round((0.8*length(jul_index))):nrow(jul_bike)],]

set.seed(12345)
aug_index <- sample(1:nrow(aug_bike),nrow(aug_bike))
aug_train <- aug_bike[aug_index[1:round((0.8*length(aug_index)))],]
aug_test <- aug_bike[aug_index[round((0.8*length(aug_index))):nrow(aug_bike)],]

set.seed(12345)
sep_index <- sample(1:nrow(sep_bike),nrow(sep_bike))
sep_train <- sep_bike[sep_index[1:round((0.8*length(sep_index)))],]
sep_test <- sep_bike[sep_index[round((0.8*length(sep_index))):nrow(sep_bike)],]

set.seed(12345)
oco_index <- sample(1:nrow(oco_bike),nrow(oco_bike))
oco_train <- oco_bike[oco_index[1:round((0.8*length(oco_index)))],]
oco_test <- oco_bike[oco_index[round((0.8*length(oco_index))):nrow(oco_bike)],]

set.seed(12345)
nov_index <- sample(1:nrow(nov_bike),nrow(nov_bike))
nov_train <- nov_bike[nov_index[1:round((0.8*length(nov_index)))],]
nov_test <- nov_bike[nov_index[round((0.8*length(nov_index))):nrow(nov_bike)],]

set.seed(12345)
dec_index <- sample(1:nrow(dec_bike),nrow(dec_bike))
dec_train <- dec_bike[dec_index[1:round((0.8*length(dec_index)))],]
dec_test <- dec_bike[dec_index[round((0.8*length(dec_index))):nrow(dec_bike)],]

#aggregate all data together 
bike_train <- rbind(jan_train,feb_train,mar_train,apr_train,may_train,jun_train,jul_train,aug_train,sep_train,oco_train,nov_train,dec_train)
bike_test <- rbind(jan_test,feb_test,mar_test,apr_test,may_test,jun_test,jul_test,aug_test,sep_test,oco_test,nov_test,dec_test)


##Extract year, month, date from bike data
bike_train$start_year <- as.factor(substr(bike_train$starttime,1,4))
bike_train$start_mth <- as.factor(substr(bike_train$starttime,6,7))
bike_train$start_day <- as.factor(substr(bike_train$starttime,9,10))

bike_test$start_year <- as.factor(substr(bike_test$starttime,1,4))
bike_test$start_mth <- as.factor(substr(bike_test$starttime,6,7))
bike_test$start_day <- as.factor(substr(bike_test$starttime,9,10))

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

#Write a csv file with new columns year, month, date 
write.csv(nycw_2019,"C:\\Users\\Xuhao Dai\\OneDrive - Umich\\School\\Master Program - IOE\\Winter 2020\\TO 628\\Team Project\\TO628_Team_Project\\weather2019.csv")

#merge bike data with weather data 
bike_weather_train <- merge(bike_train,nycw_2019,by.x = c("start_year","start_mth","start_day"), by.y = c("start_year","start_mth", "start_day"))
str(bike_weather_train)

bike_weather_test <- merge(bike_test,nycw_2019,by.x = c("start_year","start_mth","start_day"), by.y = c("start_year","start_mth", "start_day"))
str(bike_weather_test)

write.csv(bike_weather_train,"C:\\Users\\Xuhao Dai\\OneDrive - Umich\\School\\Master Program - IOE\\Winter 2020\\TO 628\\Team Project\\TO628_Team_Project\\bike_weather_train_2019.csv")
write.csv(bike_weather_test,"C:\\Users\\Xuhao Dai\\OneDrive - Umich\\School\\Master Program - IOE\\Winter 2020\\TO 628\\Team Project\\TO628_Team_Project\\bike_weather_test_2019.csv")
