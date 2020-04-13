#To combine bike data with weather data
s
#Extract year, month, date from bike data
jan_bike <- read.csv("JC-201901-citibike-tripdata.csv")

jan_bike$start_year <- substr(jan_bike$starttime,1,4)

jan_bike$start_mth <- substr(jan_bike$starttime,6,7)
str(jan_bike$start_mth)

jan_bike$start_day <- substr(jan_bike$starttime,9,10)
str(jan_bike$start_day)

str(jan_bike)


#Write a csv file with new columns year, month, date 

write.csv(jan_bike,"C:\\Users\\Xuhao Dai\\OneDrive - Umich\\School\\Master Program - IOE\\Winter 2020\\TO 628\\Team Project\\TO628_Team_Project\\jan_withdate.csv")

#Check weather data
nycw <- read.csv("nycweather.csv")
str(nycw)

nycw$start_year <- substr(nycw$starttime,1,4)

nycw$start_mth <- substr(nycw$starttime,6,7)
str(jan_bike$start_mth)

nycw$start_day <- substr(jan_bike$starttime,9,10)
str(jan_bike$start_day)

#Write a csv file with new columns year, month, date 

write.csv(jan_bike,"C:\\Users\\Xuhao Dai\\OneDrive - Umich\\School\\Master Program - IOE\\Winter 2020\\TO 628\\Team Project\\TO628_Team_Project\\nyc_weather.csv")
