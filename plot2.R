#Exploratory data analysis week 1 project

#load packages called by script

library(lubridate)
library(dplyr)
library(tidyr)

#download the Data Set and Unzip it #
filename<-"power_consumption.zip"
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(filename)){
  download.file(fileurl, filename)
}
unzip(zipfile = filename)


#read the text file into a dataframe

powerconsumption<-read.table("household_power_consumption.txt", sep = ";", header=TRUE)


#convert dates column into posix using lubridate

powerconsumption$Date<-dmy(powerconsumption$Date)

#convert time column into posix using lubridate

#powerconsumption$Time<-hms(powerconsumption$Time)

#subset the powerconsumption data frame to only contain the data from 2007-02-01 through 2007-02-02

powerconsumptionfeb1stand2nd<-filter(powerconsumption,Date >="2007-02-01", Date <= "2007-02-02")


#convert ? to "NA"
powerconsumptionfeb1stand2nd <- data.frame(lapply(powerconsumptionfeb1stand2nd, function(x) {
                    gsub("//?", "NA", x)
                }))

#figure 2: line graph of day of the week vs global active power

  # open png file device
    png(file = "plot2.png", width = 480, height = 480, units = "px")
    
  # format device parameters 
    par(mfrow = c(1,1))
  
  # convert data into numeric form and store in variables
    globalactive<-as.numeric(as.character(powerconsumptionfeb1stand2nd$Global_active_power))
  
  # combine and date and time column into a single column using lubridate
    datetime<-with(powerconsumptionfeb1stand2nd, ymd(Date)+hms(Time))

  # make plot
    plot(datetime, globalactive, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")

  # shut down device
    dev.off()

