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


#figure 4: panel of 4 graphs
    # open png file device
      png(file = "plot4.png", width = 480, height = 480, units = "px")
   
    # format device parameters 
      par(mfrow = c(2,2))
    
      # upper left hand graph of Global Active Power vs Datetime
        globalactive<-as.numeric(as.character(powerconsumptionfeb1stand2nd$Global_active_power))
    
        datetime<-with(powerconsumptionfeb1stand2nd, ymd(Date)+hms(Time))
    
        plot(datetime, globalactive, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
    
      # upper right hand corner
        voltage<-as.numeric(as.character(powerconsumptionfeb1stand2nd$Voltage))
      
        plot(datetime,voltage, ylab= "Voltage", type = "l")
    
      #lower left hand corner
        sub1<-as.numeric(as.character(powerconsumptionfeb1stand2nd$Sub_metering_1))
    
        sub2<-as.numeric(as.character(powerconsumptionfeb1stand2nd$Sub_metering_2))
    
        sub3<-as.numeric(as.character(powerconsumptionfeb1stand2nd$Sub_metering_3))
    
        plot(datetime,sub1, type="l", ylab = "Energy sub metering", xlab = "")
    
        lines(datetime,sub2, col = "red")
    
        lines(datetime, sub3, col = "blue")
    
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1,1),bty = "n" )
    
    
      # lower right hand corner
        reactive<-as.numeric(as.character(powerconsumptionfeb1stand2nd$Global_reactive_power))
    
        plot(datetime,reactive, ylab= "Global_reactive_power", type = "l")
    
      # shut down device
        dev.off()
    