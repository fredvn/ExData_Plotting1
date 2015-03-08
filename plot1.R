library(lubridate)
library(dplyr)

plot_1 <- function( ){
# first, create a directory to put data if not exist

if(!file.exists("data")){
  dir.create("data")
}

setInternet2(use = TRUE)
# link to the archive containing the project data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download the archive
download.file(fileUrl, destfile = "./data/power_consumption.zip")
unzip("./data/power_consumption.zip",exdir="./data")

hpc <- read.csv("./data/household_power_consumption.txt",sep=";",na.strings=c("?"),stringsAsFactors=FALSE)
newnames <- tolower(names(hpc))
newnames <- gsub("_","",newnames,)

colnames(hpc) <- newnames

date_filter <- filter(hpc,grepl( "^1/2/2007|^2/2/2007",date))

hist_gap <- hist(date_filter$globalactivepower)

png(filename = "plot1.png",
    width = 480, height = 480)
	
	plot(hist_gap,,col="red",main="Global Active Power",xlab="global active power (kilowatts)")
	
dev.off()
}
