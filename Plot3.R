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
par(bg = "transparent") 


## PLOT

plot(data$Date,data$Sub_metering_1, 
     type = 'l',
     col = "black",
     xlab = "",
     ylab = "Energy sub metering"
     )
lines(data$Date,data$Sub_metering_2, col = "red")
lines(data$Date,data$Sub_metering_3, col = "blue")
legend("topright"
       ,text.width = strwidth("Sub_metering_1")
       ,cex = 0.7
       ,lty = 1
       ,col = c("black","red","blue")
       ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

## CREATE PNG FILE
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()