## plot3.R
#
# reads file and generates plot3.png

# subset orig file 
# $> grep "[1,2]/2/2007" household_power_consumption.txt >household_power_consumption-20070201_20070202.txt
system( 'grep "^[1,2]/2/2007" household_power_consumption.txt >./data/household_power_consumption-20070201_20070202.txt' )

data.orig1<- read.csv( "household_power_consumption.txt", sep=";", nrow=1 )

data.filename<- "./data/household_power_consumption-20070201_20070202.txt"

data<- read.csv( data.filename, sep=";",  na.strings="?" )

# copy colnames from the original data
colnames( data )<- colnames( data.orig1 )

# merge Date and Time into a single DateTime column
data$DateTime<- strptime( paste( data$Date, data$Time ),
                          format="%d/%m/%Y %H:%M:%S" )

png( "plot4.png", width=480, height=480 )
  # setup 2x2 layout    
  par( mfrow=c(2, 2) )

  # TL - copy from 'plot2'
  plot( x=data$DateTime, y=data$Global_active_power,
      type="l", ylab="Global Active Power", xlab="" )

  # TR
  plot( x=data$DateTime, y=data$Voltage,
        type="l", ylab="Voltage", xlab="datetime" )

  # BL - copy from 'plot3'
  plot( x=data$DateTime, y=data$Sub_metering_1, type="l",
        ylab="Energy sub metering", xlab="" )
  lines( x=data$DateTime, y=data$Sub_metering_2, col="red" )
  lines( x=data$DateTime, y=data$Sub_metering_3, col="blue" )
  
# TODO: remove box outline on legend
  legend( "topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        lwd=2, col=c("black", "red", "blue"), bty="n")

  # BR
  plot( x=data$DateTime, y=data$Global_reactive_power,
      type="l", ylab="Global_reactive_power", xlab="datetime" )

dev.off()
