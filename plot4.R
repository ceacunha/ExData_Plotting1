#initializes the lubridate library for date and time handling
library(lubridate)

# reads data for source indicating the missing value mark '?' and separator ';'
consumption <- read.table("household_power_consumption.txt",
                          na.strings = "?", sep = ";", header = TRUE,
                          stringsAsFactors = FALSE,
                          colClasses = c("character", "character", "numeric",
                                         "numeric", "numeric", "numeric", "numeric",
                                         "numeric", "numeric" ))

# filter the data based on assingment indication for date
consumption <- consumption[as.Date(consumption$Date, format = "%d/%m/%Y") == "2007-02-01" |
                             as.Date(consumption$Date, format = "%d/%m/%Y") == "2007-02-02",]

# combines the Date and Time columns in a single timestamp column
# for required graphics
consumption$Timestamp <- dmy_hms(
  paste(consumption$Date,
        consumption$Time,
        sep = " "))

# open/create the image file which will receive the graphic
png("plot4.png")

# establishing the 2 by 2 grid for displaying the graphics
par(mfrow=c(2,2))
#function for plotting the required graphic
with(consumption,{
  #graphic 1,1
  plot(Timestamp, Global_active_power, xlab = "",
       ylab = "Global Active Power", type = "l")
  #graphic 1,2
  plot(Timestamp, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  #graphic 2,1
  plot(Timestamp, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
  lines(Timestamp, Sub_metering_2, col = "red")
  lines(Timestamp, Sub_metering_3, col = "blue")
  legend("topright", lty = c(1,1,1), col = c("black","red","blue"),
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  #graphic 2,2
  plot(Timestamp, Global_reactive_power, xlab = "datetime",
       ylab = "Global_reactive_power", type = "l")
})

#closes the image's graphic device
dev.off()