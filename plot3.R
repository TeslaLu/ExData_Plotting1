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

png(filename = "plot3.png", width=480, height=480)

#plot the line chart with Sub_metering_1/2/3 and DateTime values into the pnc device
library(datasets)
with(power_sub,plot(DateTime, Sub_metering_1, type = 'l', main = "", ylab = "Energy sub metering", xlab = "", col = "black"))
with(power_sub,lines(DateTime,Sub_metering_2, col = "red"))
with(power_sub,lines(DateTime,Sub_metering_3, col = "blue"))

#Adding legend
legend("topright", lty = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.7)

#close the device
dev.off()
