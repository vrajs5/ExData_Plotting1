library(data.table)

#Reading processed file
reading = read.csv('reading.csv')
reading = data.table(reading)

#Creating new field Datetime graphs
reading$DateTime = as.POSIXlt(reading$Date, format='%Y-%m-%d') + as.ITime(reading$Time, format = '%H:%M:%S')

#Formatting remaining fields
reading$Date = as.IDate(reading$Date, format='%Y-%m-%d')
reading$Time = as.ITime(reading$Time, format = '%H:%M:%S')
reading$Global_active_power = as.numeric(reading$Global_active_power)
reading$Global_reactive_power = as.numeric(reading$Global_reactive_power)
reading$Voltage = as.numeric(reading$Voltage)
reading$Global_intensity = as.numeric(reading$Global_intensity)
reading$Sub_metering_1 = as.numeric(reading$Sub_metering_1)
reading$Sub_metering_2 = as.numeric(reading$Sub_metering_2)
reading$Sub_metering_3 = as.numeric(reading$Sub_metering_3)

#Providing graphical device as PNG with required resolution
png(filename = "plot4.png",width = 480, height = 480)

#Making partiction of graph in 2x2 matrix,
#Matrix will be filled  row wise
par(mfrow = c(2,2))

#Plot 1- Global_active_power v/s DateTime 
#line graph - Providing field of dataframe as vector
#And providing all necessary labels
plot(x = reading$DateTime,
     y = reading$Global_active_power, 
     type = 'l', xlab = '', ylab = 'Global Active Power')

#Plot 2- Voltage v/s Datetime
#line graph - Providing field of dataframe as vector
#And providing all necessary labels
plot(x = reading$DateTime,
     y = reading$Voltage, 
     type = 'l', xlab = 'datetime', ylab = 'Voltage')

#Plot 3 - Sub_metering v/s Datetime
#Creating line graph with Sub_meter_1
#Column of data frame are passed as Vector
plot(x = reading$DateTime, 
     y = reading$Sub_metering_1, col = 'black',
     type = 'l', xlab = '', ylab = 'Energy sub metering')
#Adding line for Sub_meter_2
lines(x = reading$DateTime, 
      y = reading$Sub_metering_2, col = 'red')
#Adding line for Sub_meter_3
lines(x = reading$DateTime, 
      y = reading$Sub_metering_3, col = 'blue')
#Adding legend for overall graph
legend('topright', legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       col=c('black',"red","blue"), bty = 'n')

#Plot 4- Global_reactive_power v/s Datetime
#line graph - Providing field of dataframe as vector
#And providing all necessary labels
plot(x = reading$DateTime,
     y = reading$Global_reactive_power, 
     type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power')


dev.off()
