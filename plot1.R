#initializes the lubridate library for date and time handling
library(lubridate)

# reads data for source indicating the missing value mark '?' and separator ';'
consumption <- read.table("household_power_consumption.txt",
                          na.strings = "?", sep = ";", header = TRUE,
                          stringsAsFactors = FALSE)

# filter the data based on assingment indication for date
consumption <- consumption[consumption$Date == "1/2/2007" |
                             consumption$Date == "2/2/2007",]

# combines the Date and Time columns in a single timestamp column
# for required graphics
consumption$Timestamp <- dmy_hms(
  paste(consumption$Date,
        consumption$Time,
        sep = " "))

# open/create the image file which will receive the graphic
png("plot1.png")

#function for plotting the required graphic
hist(consumption$Global_active_power, col = 2,
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#closes the image's graphic device
dev.off()