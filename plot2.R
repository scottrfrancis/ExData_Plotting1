## plot1.R
#
# reads file and generates plot1.png

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

png( "plot2.png", width=480, height=480 )
plot( x=data$DateTime, y=data$Global_active_power,
      type="l", ylab="Global Active Power (kilowatts)", xlab="" )
dev.off()
