# Program: plot4.R
# Description: This program assumes the input file 'household_power_consumption.txt' is in the
# working directory. This script reads that file, does some minor formatting of
# date and time variables, and creates a basic plot as described in the Readme.md file.
# The resulting plot is saved in the working directory as 'plot4.png'.

# Set date range of interest
stdt <- "1/2/2007" # Date range start date
endt <- "2/2/2007" # Date range end date

# Read raw data
raw <- read.table(file = "household_power_consumption.txt", 
                  header = TRUE, sep = ";", na.strings = "?")

# Subset data to date range of interest
raw <- subset(raw, (Date == stdt) | (Date == endt))

# Convert date and time variables into datetime  class and subset data to date range of interest
df <- cbind(data.frame(datetime = strptime(paste(raw$Date, raw$Time), "%d/%m/%Y %H:%M:%S")),
            raw)

# Create Plot 4
# Open graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Set-up 2 x 2 grid
par(mfrow = c(2, 2))

##################################################
# Plot top left line plot
# Generate line plot
with(df, plot(datetime, Global_active_power, 
              type = "l",
              xlab = "",
              ylab = "Global Active Power"))

##################################################
# Plot top right line plot
# Generate line plot
with(df, plot(datetime, Voltage,
              type = "l",
              ylab = "Voltage"))

##################################################
# Plot bottom left line plot
# Initialize line plot
with(df, plot(datetime, Sub_metering_1, 
              type = "n",
              xlab = "",
              ylab = "Energy sub metering"))

# Add sub metering 1-3
with(df, lines(datetime, Sub_metering_1, type = "l", col = "black"))
with(df, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(df, lines(datetime, Sub_metering_3, type = "l", col = "blue"))

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       bty = "n",
       lty = "solid")

##################################################
# Plot bottom right line plot
with(df, plot(datetime, Global_reactive_power,
              type = "l"))

# Close graphics device
dev.off()