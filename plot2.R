#### Plot1 ####

library(data.table)
library(lubridate)

setwd("./")

# Read the file with data.table() package
epow <- fread("household_power_consumption.txt")

# Change Date class from character to Date
epow$Date <- as.Date( as.character(epow$Date), "%d/%m/%Y")

# Subset epow to include only data from 2007-02-01 to 2007-02-02
epow_subset <- subset(epow, 
                      (Date >= as.Date("2007-02-01")) &
                        (Date <= as.Date("2007-02-02")))

# Create a new variable by combining Date and Time
epow_subset$Date.Time <- paste(epow_subset$Date, epow_subset$Time, sep = " ")

# Transforms Date.Time to POSIXct
epow_subset$Date.Time <- ymd_hms(epow_subset$Date.Time)

# Change Global_active_power class to numeric
epow_subset$Global_active_power <- as.numeric(epow_subset$Global_active_power)

# Makes a plot.
plot(epow_subset$Date.Time,epow_subset$Global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "n")

# Adds a line.
lines(epow_subset$Date.Time, epow_subset$Global_active_power)

# Copy picture to png device
dev.copy(png, file="plot2.png", width=480, height=480)

# close png device
dev.off()

