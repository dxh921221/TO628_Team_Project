#Import all data of all months in 2019 
jan_bike <- read.csv("JC-201901-citibike-tripdata.csv")
feb_bike <- read.csv("JC-201902-citibike-tripdata.csv")
mar_bike <- read.csv("JC-201903-citibike-tripdata.csv")
apr_bike <- read.csv("JC-201904-citibike-tripdata.csv")
may_bike <- read.csv("JC-201905-citibike-tripdata.csv")
jun_bike <- read.csv("JC-201906-citibike-tripdata.csv")
jul_bike <- read.csv("JC-201907-citibike-tripdata.csv")
aug_bike <- read.csv("JC-201908-citibike-tripdata.csv")
sep_bike <- read.csv("JC-201909-citibike-tripdata.csv")
oco_bike <- read.csv("JC-201910-citibike-tripdata.csv")
nov_bike <- read.csv("JC-201911-citibike-tripdata.csv")
dec_bike <- read.csv("JC-201912-citibike-tripdata.csv")

#aggregate all data together 
bike <- rbind(jan_bike,feb_bike,mar_bike,apr_bike,may_bike,jun_bike,jul_bike,aug_bike,sep_bike,oco_bike,nov_bike,dec_bike)

##Extract year, month, date from bike data
bike$start_year <- as.factor(substr(bike$starttime,1,4))
bike$start_mth <- as.factor(substr(bike$starttime,6,7))
bike$start_day <- as.factor(substr(bike$starttime,9,10))

#Write a csv file with new columns year, month, date 

write.csv(bike,"C:\\Users\\Xuhao Dai\\OneDrive - Umich\\School\\Master Program - IOE\\Winter 2020\\TO 628\\Team Project\\TO628_Team_Project\\2019_withdate.csv")


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
bike_weather <- merge(bike,nycw_2019,by.x = c("start_year","start_mth","start_day"), by.y = c("start_year","start_mth", "start_day"))
str(bike_weather)
str(bike)

write.csv(bike_weather,"C:\\Users\\Xuhao Dai\\OneDrive - Umich\\School\\Master Program - IOE\\Winter 2020\\TO 628\\Team Project\\TO628_Team_Project\\traindata_2019.csv")
