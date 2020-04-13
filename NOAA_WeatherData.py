import csv
from time import sleep
import noaa_api_v2

key = 'rjNSsrhaTBFfmXUbCMbzvfGblmIsTDLP'

client = noaa_api_v2.NOAAData(key)
sid = "GHCND:USW00094728"# NYC Central Park data collection location
s = "2020-04-05" #start date includes the last line in the csv
e = "2020-04-12" #set end date to max 5-7 months past start date

# this code adds on weather data to csv called "nycweather.csv"


dat = client.fetch_data(datasetid="GHCND", stationid=sid, startdate=s, enddate=e, limit=1000)

currdate = dat[0]["date"]
currinfo = {"TMIN": None, "TMAX": None, "AWND": None, "PRCP": None, "SNOW": None}


with open("nycweather.csv", "a", newline = "") as f_out:
    writer = csv.writer(f_out)
    #writer.writerow(["Date", "TMIN", "TMAX", "AWND", "PRCP", "SNOW"])  #run this once at the start to put in headers
    
    for x in dat:
        if x["date"] != currdate:
            writer.writerow([x["date"], currinfo["TMIN"], currinfo["TMAX"], 
                             currinfo["AWND"], currinfo["PRCP"], 
                             currinfo["SNOW"]])
            currdate = x["date"]
            currinfo= {"TMIN": None, "TMAX": None, "AWND": None, "PRCP": None, "SNOW": None}
        if x["datatype"] in currinfo:
            currinfo[x["datatype"]] = x["value"]
