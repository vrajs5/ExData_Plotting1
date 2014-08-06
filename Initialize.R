library(data.table)
library(sqldf)

#Reading main file
f<-file('household_power_consumption.txt')
temp <- sqldf("select * from f",dbname=tempfile(),file.format = list(header = T, row.names = F, colClasses = "character", sep = ';'))
close(f)

#Converting only data field to proper format
temp$Date = as.IDate(temp$Date, format = '%d/%m/%Y')

#Subsetting only required range (2007-02-01 to 2007-02-02) of data
#also converting that data to data.table format
reading  = data.table(temp[temp$Date %in% as.IDate(c('2007-02-01', '2007-02-02')),])

#Removing the data which is not required
rm(f,temp)
gc()

#Conversion of other field
reading$Time = as.ITime(reading$Time)
reading$Global_active_power = as.numeric(reading$Global_active_power)
reading$Global_reactive_power = as.numeric(reading$Global_reactive_power)
reading$Voltage = as.numeric(reading$Voltage)
reading$Global_intensity = as.numeric(reading$Global_intensity)
reading$Sub_metering_1 = as.numeric(reading$Sub_metering_1)
reading$Sub_metering_2 = as.numeric(reading$Sub_metering_2)
reading$Sub_metering_3 = as.numeric(reading$Sub_metering_3)

#Storing data to reading.csv file which can be used in plot*.R scripts
write.csv(reading, 'reading.csv', row.names = FALSE)