fileName <- "household_power_consumption.txt"

#Download file if we don't already have it.
if(!file.exists(fileName)) {
  print("Downloading data...")
  zipFileName <- "household_power_consumption.zip"
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = zipFileName, method = "curl")
  unzip(zipFileName)
}

# Load the data using read.table
print("Loading data...")
consumptionData <- read.table(fileName, header = TRUE, 
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
png("plot2.png", height = 480, width = 480)
plot(consumptionData$datetime, consumptionData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
