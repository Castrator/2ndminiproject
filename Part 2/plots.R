library(dplyr)

data <- read.table("./specdata/household_power_consumption.txt", sep = ";", header = TRUE)

# Read only dates from 2007-02-01 and 2007-02-02
filtered_data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
filtered_data$Date <- as.Date(filtered_data$Date, "%d/%m/%Y")
filtered_data$DateTime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time))
View(filtered_data)

# Plot 1
plot1 <- function(){
  png("plot1.png", width = 640, height = 640)
  hist(filtered_data$Global_active_power, 
       main = "Global Active Power", 
       col = "red", 
       xlab = "Global Active Power (kilowatts)")
  dev.off() 
}
plot1()

# Plot 2
plot2 <- function(){
  png("plot2.png", width = 640, height = 640)
  
  plot(filtered_data$DateTime, 
       filtered_data$Global_active_power, 
       type = "l", 
       xlab = "",
       ylab = "Global Active Power (kilowatts)",
       )
  
  dev.off() 
}
plot2()

# Plot 3
plot3 <- function(){
  png("plot3.png", width = 640, height = 640)
  
  plot(filtered_data$DateTime, 
       filtered_data$Sub_metering_1, 
       type = "l", 
       xlab = "",
       ylab = "Energy sub metering",
       col = "black")
  
  lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
  lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")
  
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lty = c(1, 1,1))
  
  dev.off() 
}
plot3()

# Plot 4
plot4 <- function(){
  png("plot4.png", width = 640, height = 640)
  
  par(mfcol = c(2,2))
  
  #row 1 col 1
  plot(filtered_data$DateTime, 
       filtered_data$Global_active_power, 
       type = "l", 
       xlab = "",
       ylab = "Global Active Power (kilowatts)",
  )
  
  #row 1 col 2
  plot(filtered_data$DateTime, 
       filtered_data$Sub_metering_1, 
       type = "l", 
       xlab = "",
       ylab = "Energy sub metering",
       col = "black")
  
  lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
  lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")
  
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lty = c(1, 1,1),
         bty = "n")
  
  plot(filtered_data$DateTime, 
       filtered_data$Voltage, 
       type = "l", 
       xlab = "datetime",
       ylab = "Voltage",
  )
  
  plot(filtered_data$DateTime, 
       filtered_data$Global_reactive_power, 
       type = "l", 
       xlab = "datetime",
       ylab = "Global_reactive_power",
  )
  
  dev.off()
}
plot4()
