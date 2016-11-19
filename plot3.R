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
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(hpcsub$settime, hpcsub$Sub_metering_1, type="l", col=columnlines[1], xlab="", ylab="Energy sub metering")
lines(hpcsub$settime, hpcsub$Sub_metering_2, col=columnlines[2])
lines(hpcsub$settime, hpcsub$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")

dev.copy(png, file = "plot3.png")
dev.off()
