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
png("plot3.png")
plot(consumptionData$datetime, consumptionData$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub meeting")
lines(consumptionData$datetime, consumptionData$Sub_metering_2, col = "red")
lines(consumptionData$datetime, consumptionData$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, lwd=2.5 )
dev.off()