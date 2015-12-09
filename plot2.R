# COURSERA - Exploratory Data Analysis - Course Project 1 - plot2.R
rm(list = ls())

## DOWNLOAD AND UNZIP THE DATASET IN THE CURRENT WORK DIRECTORY
zipFile <- "exdata_data_household_power_consumption.zip"

if(!file.exists(zipFile)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, zipFile, method = 'curl')
}
## UNZIP THE FILE
if(!file.exists("household_power_consumption.txt")){
  unzip(zipFile)
}

## LOAD THE SUBSET OF THE DATASET
data <- subset(
  read.table("household_power_consumption.txt"
             ,sep = ';'
             ,header = TRUE
             ,na.strings = "?"
             ,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
  )
  ,Date == '1/2/2007' | Date == '2/2/2007'
)

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Date <- paste(data$Date, data$Time)
data$Date <- as.POSIXct(strftime(data$Date, "%Y-%m-%d %H:%M:%S"))

## CHANGE DEFAULT PLOT BACKGROUND COLOR TO "TRANSPARENT"
par(bg = "transparent", mfrow = c(1,1)) 

## PLOT
plot(data$Global_active_power ~ data$Date
     ,type = 'l'
     ,xlab = ""
     ,ylab = "Global Active Power (kilowatts)")

## CREATE PNG FILE
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
