#Set working directory
getwd()
setwd("C:/DataScientist/ExploratoryDataAnalysis/project1")

#Read raw data into data frame called 'power'
power <- read.table("household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";")

#Convert the date to yyyy-mm-dd format.
power$Date <- strptime(power$Date, "%d/%m/%Y")
power$Date <- as.Date (power$Date)

#Subset data only from 2007-02-01 and 2007-02-02
power_sub <- subset (power, Date == "2007-02-01" | Date == "2007-02-02")
power_sub$DateTime <- as.POSIXct(paste(power_sub$Date, power_sub$Time))

#open a pnc device and prepare to write chart into it
png(filename = "plot4.png", width=480, height=480)

#plot the four charts into the pnc device
library(datasets)
#set global parameters
par(mfrow = c(2, 2),mar = c(5, 4.1, 4.1, 1), oma = c(0, 0, 0, 0))
with(power_sub,{
  plot(DateTime, Global_active_power, type = 'l', main = "", ylab = "Global Active Power", xlab = "", col = "black")
  plot(DateTime, Voltage, type = 'l', main = "", ylab = "Voltage", xlab = "", col = "black")
  {with(power_sub,plot(DateTime, Sub_metering_1, type = 'l', main = "", ylab = "Energy sub metering", xlab = "", col = "black"))
   with(power_sub,lines(DateTime,Sub_metering_2, col = "red"))
   with(power_sub,lines(DateTime,Sub_metering_3, col = "blue"))
   legend("topright", lty = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.4)}
  plot(DateTime, Global_reactive_power, type = 'l', main = "", ylab = "Global_reactive_power", xlab = "", col = "black")
})

#close the device
dev.off()
