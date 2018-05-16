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

# Change class of Sub_metering_1, 2 and 3 to numeric
epow_subset$Sub_metering_1 <- as.numeric(epow_subset$Sub_metering_1)
epow_subset$Sub_metering_2 <- as.numeric(epow_subset$Sub_metering_2)
epow_subset$Sub_metering_3 <- as.numeric(epow_subset$Sub_metering_3)

# Combines 4 plots in one picture
par(mfcol=c(2,2))


## Makes first plot.
plot(epow_subset$Date.Time,epow_subset$Global_active_power,
     xlab = "",
     ylab = "Global Active Power",
     type = "n")

# Adds a line.
lines(epow_subset$Date.Time, epow_subset$Global_active_power)



## Makes second plot.
# setup for no margins on the legend
plot(epow_subset$Date.Time,epow_subset$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")

# Adds lines
lines(epow_subset$Date.Time, epow_subset$Sub_metering_1)
lines(epow_subset$Date.Time, epow_subset$Sub_metering_2, col = "red")
lines(epow_subset$Date.Time, epow_subset$Sub_metering_3, col = "blue")

# Adds legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"),
       lty = 1,
       col = c("black","red","blue"),
       cex = .8,
       bty = "n",
       y.intersp = 0.2)


## Makes third plot
plot(epow_subset$Date.Time, as.numeric(epow_subset$Voltage),
     xlab = "datetime",
     ylab = "Voltage",
     type = "n")

# Adds a line.
lines(epow_subset$Date.Time, as.numeric(epow_subset$Voltage))


## Makes fourth plot
plot(epow_subset$Date.Time, as.numeric(epow_subset$Global_reactive_power),
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "n")

# Adds a line.
lines(epow_subset$Date.Time, as.numeric(epow_subset$Global_reactive_power))

# Copy picture to png device
dev.copy(png, file="plot4.png", width=480, height=480)

# close png device
dev.off()

