library(data.table)

#Reading processed file
reading = read.csv('reading.csv')
reading = data.table(reading)

#Formatting fields
reading$Date = as.IDate(reading$Date, format = '%Y-%m-%d')
reading$Time = as.ITime(reading$Time, format = '%H:%M:%S')
reading$Global_active_power = as.numeric(reading$Global_active_power)
reading$Global_reactive_power = as.numeric(reading$Global_reactive_power)
reading$Voltage = as.numeric(reading$Voltage)
reading$Global_intensity = as.numeric(reading$Global_intensity)
reading$Sub_metering_1 = as.numeric(reading$Sub_metering_1)
reading$Sub_metering_2 = as.numeric(reading$Sub_metering_2)
reading$Sub_metering_3 = as.numeric(reading$Sub_metering_3)

#Providing graphical device as PNG with required resolution
png(filename = "plot1.png",width = 480, height = 480)

#Plotting histograph of Global_active_power with red colour
hist(reading$Global_active_power, col = 'Red', 
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency')

#Closing and saving graphical output
dev.off()