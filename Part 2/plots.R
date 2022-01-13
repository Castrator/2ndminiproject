library(dplyr)

# LOADING and MANIPULATING the data set
#   read.table() loads the data in household_power_consumption.txt
#     'na.string' specifies the representation for missing values in the data set
#     'sep' specifies the string to separate the data
#     'header' specifies if there is a header in the data or not
data <- read.table("./specdata/household_power_consumption.txt", 
                   na.string = "?",
                   sep = ";", 
                   header = TRUE)

# READING only the dates from 2007-02-01 and 2007-02-02
#   subset() creates a subset of the data with specific dates
filtered_data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

#   as.Date() converts a string to class "Date" representing calendar dates
filtered_data$Date <- as.Date(filtered_data$Date, "%d/%m/%Y")

# DateTime
#   as.POSIXct() converts the input into date-time format representing calendar dates and times
#   paste() concatenates filtered_data$Date and filtered_data$Time into one character string
filtered_data$DateTime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time))

# PLOTTING Functions
#   png() allows for generating PNG images
#   dev.off  closes the current device (plot)

# Plot 1
plot1 <- function(){
  png("plot1.png", width = 640, height = 640)
  
  # GENERATING the plot
  #   hist() generates a histogram of Global_active_power
  #     'col' specifies the color of the bars
  #     'xlab' specifies the label on the x-axis
  hist(filtered_data$Global_active_power, 
       main = "Global Active Power", 
       col = "red", 
       xlab = "Global Active Power (kilowatts)")
  
  dev.off() 
}

# Function call
plot1()

# Plot 2
plot2 <- function(){
  png("plot2.png", width = 640, height = 640)
  
  # GENERATING the plot
  #   plot() generates the plot for Global_active_power
  #     'type' specifies the type of graph e.g. l or line 
  #     'xlab' specifies the label on the x-axis
  #     'ylab' specifies the label on the y-axis
  plot(filtered_data$DateTime, 
       filtered_data$Global_active_power, 
       type = "l", 
       xlab = "",
       ylab = "Global Active Power (kilowatts)",
       )
  
  dev.off() 
}

# Function call
plot2()

# Plot 3
plot3 <- function(){
  png("plot3.png", width = 640, height = 640)
  
  # GENERATING the plot
  #   plot() generates the plot for Global_active_power
  #     'type' specifies the type of graph 
  #     'col' specifies the color of the lines
  #     'xlab' specifies the label on the x-axis
  #     'ylab' specifies the label on the y-axis
  plot(filtered_data$DateTime, 
       filtered_data$Sub_metering_1, 
       type = "l", 
       col = "black"
       xlab = "",
       ylab = "Energy sub metering")
  
  # ADDING the additional lines
  #   lines() generates a line plot to add to the current graph
  lines(filtered_data$DateTime, filtered_data$Sub_metering_2, col = "red")
  lines(filtered_data$DateTime, filtered_data$Sub_metering_3, col = "blue")
  
  # ADDING the legend
  #   legend() generates a legend to a specified location
  #     'legend' specifies the labels 
  #     'col' specifies the color of the lines
  #     'lty' specifies the type of line e.g. 1 = solid, 2 = dashed
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lty = c(1, 1,1))
  
  dev.off() 
}

# Function call
plot3()

# Plot 4
plot4 <- function(){
  png("plot4.png", width = 640, height = 640)
  
  # par() allows for creation of multiple plots 
  par(mfcol = c(2,2))
  
  # GENERATING the plot in Row 1 Col 1
  # Same as Plot 2
  plot(filtered_data$DateTime, 
       filtered_data$Global_active_power, 
       type = "l", 
       xlab = "",
       ylab = "Global Active Power (kilowatts)",
  )
  
  #  GENERATING the plot in Row 2 Col 1
  # Same as Plot 3
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
  
  #  GENERATING the plot in Row 1 Col 2
  # Similar to Plot 2 but with Voltage
  plot(filtered_data$DateTime, 
       filtered_data$Voltage, 
       type = "l", 
       xlab = "datetime",
       ylab = "Voltage",
  )
  
  #  GENERATING the plot Row 1 Col 2
  # Similar to Plot 2 but with Global_reactive_power
  plot(filtered_data$DateTime, 
       filtered_data$Global_reactive_power, 
       type = "l", 
       xlab = "datetime",
       ylab = "Global_reactive_power",
  )
  
  dev.off()
}

# Function call
plot4()
