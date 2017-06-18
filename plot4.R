##Download the file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()
download.file(fileurl, temp)
unzip(temp, exdir = "~/Data_Science_Files")
rm(temp)

##Read the file into R
hpc <- read.table("~/Data_Science_Files/household_power_consumption.txt", header = TRUE, sep = ";", 
                  na.strings = "?", skip = 66636, nrows = 2880, 
                  col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                                "Sub_metering_3"))

##Set the date and time classes
hpc$Date <- as.Date(hpc$Date, format = '%d/%m/%Y')
hpc$Time <- strptime(paste(hpc$Date, hpc$Time, sep = " "), format = '%Y-%m-%d %H:%M:%S')

##Creating Plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(hpc$Time, hpc$Global_active_power, type = "l" , ylab = "Global Active Power", xlab = "")
plot(hpc$Time, hpc$Voltage, type = "l" , ylab = "Voltage", xlab = "datetime")
plot(hpc$Time, hpc$Sub_metering_1, type = "l" , ylab = "Energy sub metering", xlab = "")
lines(hpc$Time, hpc$Sub_metering_2, type = "l" , col = "red")
lines(hpc$Time, hpc$Sub_metering_3, type = "l" , col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
plot(hpc$Time, hpc$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()