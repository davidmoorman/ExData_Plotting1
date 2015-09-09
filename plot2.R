# Program: plot2.R
# Description: This program assumes the input file 'household_power_consumption.txt' is in the
# working directory. This script reads that file, does some minor formatting of
# date and time variables, and creates a basic plot as described in the Readme.md file.
# The resulting plot is saved in the working directory as 'plot2.png'.

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

# Create Plot 2
# Open graphics device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Create line plot
with(df, plot(datetime, Global_active_power, 
              type = "l",
              xlab = "",
              ylab = "Global Active Power (kilowatts)"))

# Close graphics device
dev.off()