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

hist(hpcsub$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()