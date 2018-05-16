#### Plot1 ####

library(data.table)

setwd("./")

# Read the file with data.table() package
epow <- fread("household_power_consumption.txt")

# Change Date class from character to Date
epow$Date <- as.Date( as.character(epow$Date), "%d/%m/%Y")

# Subset epow to include only data from 2007-02-01 to 2007-02-02
epow_subset <- subset(epow, 
                      (Date >= as.Date("2007-02-01")) &
                      (Date <= as.Date("2007-02-02")))

# Change Global_active_power class to numeric
epow_subset$Global_active_power <- as.numeric(epow_subset$Global_active_power)

# Change upper margin in order to y ticks show from 0 to 1200 in a 200 interval
par(mar=c(5.1, 4.1, 1.1, 2.1))

# Makes an histogram without a blank y axis.
hist(epow_subset$Global_active_power, 
     main = "Global Active Power", 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     ylim = range(0:1300),
     yaxt = "n")

# Creates y ticks
ticks <- seq(0, 1200, 200)

# Draw y axis     
axis (side = 2,
      at = ticks, 
      labels = ticks,
      cex.axis=0.8)

# Copy picture to png device
dev.copy(png, file="plot1.png", width=480, height=480)

# close png device
dev.off()
  
