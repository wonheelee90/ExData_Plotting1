setwd("~/Desktop/Coursera/Data/HPC Data")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
filename <- "household_power_consumption.txt"

if (!file.exists(filename)) {
    download.file(URL, zipfile, method = "curl")
    unzip(zipfile, overwrite = T)
}

hpc <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
hpcsub <- hpc[hpc$Date %in% c("1/2/2007" , "2/2/2007"), ]
settime <- strptime(paste(hpcsub$Date, hpcsub$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
hpcsub <- cbind(settime, hpcsub)

Sys.setlocale(category = "LC_ALL", locale = "C")
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2))
plot(hpcsub$settime, hpcsub$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(hpcsub$settime, hpcsub$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(hpcsub$settime, hpcsub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hpcsub$settime, hpcsub$Sub_metering_2, type="l", col="red")
lines(hpcsub$settime, hpcsub$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=columnlines, cex = 0.3)
plot(hpcsub$settime, hpcsub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file = "plot4.png")
dev.off()
