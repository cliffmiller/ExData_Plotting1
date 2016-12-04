# Load the data using read.table into a variable named 'data'
print("Loading data...")
consumptionData <- read.table("household_power_consumption.txt", header = TRUE, 
                              sep = ";", na.strings = "?")

#Convert date strings to actual date objects
print("Converting dates and times to DataTime objects...")
consumptionData$Date <- as.Date(consumptionData$Date, format = "%d/%m/%Y")

# Subset the data based on date range
print("Subsetting data to defined date range...")
consumptionData <- subset(consumptionData, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times to Date/Time objects
consumptionData$datetime <- strptime(paste(consumptionData$Date, consumptionData$Time), "%Y-%m-%d %H:%M:%S")

#Build the graph
print("Building graph...")
png("plot4.png")
par(mfcol = c(2,2), cex = .8)

print("Create plot 1...")
plot(consumptionData$datetime, consumptionData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

print("Create plot 2...")
plot(consumptionData$datetime, consumptionData$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub meeting")
lines(consumptionData$datetime, consumptionData$Sub_metering_2, col = "red")
lines(consumptionData$datetime, consumptionData$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, lwd=2.5, bty = "n")

print("Create plot 3...") 
plot(consumptionData$datetime, consumptionData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

print("Create plot 4...")
plot(consumptionData$datetime, consumptionData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


dev.off()