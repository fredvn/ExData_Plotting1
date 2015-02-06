library(lubridate)
library(dplyr)

plot_3 <- function( ){
# first, create a directory to put data if not exist

if(!file.exists("data")){
  dir.create("data")
}

setInternet2(use = TRUE)
# link to the archive containing the project data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download the archive
##download.file(fileUrl, destfile = "./data/power_consumption.zip")
##unzip("./data/power_consumption.zip",exdir="./data")

hpc <- read.csv("./data/household_power_consumption.txt",sep=";",na.strings=c("?"),stringsAsFactors=FALSE)
newnames <- tolower(names(hpc))
newnames <- gsub("_","",newnames,)

colnames(hpc) <- newnames

date_filter <- filter(hpc,grepl( "^1/2/2007|^2/2/2007",date))

date_filter <- within(date_filter , stamp <- paste(date,time,sep=" "))

date_filter$stamp <- dmy_hms(date_filter$stamp)


png(filename = "plot3.png",width = 480, height = 480)
	
plot(date_filter$stamp,date_filter$submetering1,ylim=c(0,40),type="n",ylab="Energy sub meetering",xlab=" ")
lines(date_filter$stamp,date_filter$submetering1,col="black")
lines(date_filter$stamp,date_filter$submetering2,col="red")
lines(date_filter$stamp,date_filter$submetering3,col="blue")
legend("topright",lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	
dev.off()

date_filter

}
