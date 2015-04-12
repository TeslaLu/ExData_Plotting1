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

#plot the histogram of variable 'Global_active_power'
library(datasets)

#set global margin parameters
par(mar = c(4, 4, 1, 6))
with(power_sub,hist(Global_active_power,main = "Global Active Power", xlab = "Global Active Power (killowatts)", col = "red"))

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png") 
dev.off()
