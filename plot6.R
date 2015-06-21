library(ggplot2)
library(plyr)

## Proble:Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

plot6<- function() {

# Read RDS data set 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCmotor <- SCC[grep("motor", SCC$Short.Name, ignore.case = TRUE),]  ## First get the motor vehicle name in the shortname

## Match the identifier of Motor in SCC to NEI
NEImotor <- NEI[as.character(NEI$SCC) %in% as.character(SCCmotor$SCC), ]

 NEImororbaltimore <- NEImotor[(NEImotor$fips=="24510"),]
  NEImororCalifornia<- NEImotor[(NEImotor$fips=="06037"),]
 
 # Aggregate by sum the total emissions by year

aggBaltimore <-aggregate(Emissions ~ year ,NEImororbaltimore ,sum)
aggCalifornia <-aggregate(Emissions ~ year ,NEImororCalifornia ,sum)

aggBaltimore$city="Baltimore"
aggCalifornia$city="California"

groupagg<-rbind(aggBaltimore,aggCalifornia)

 ##Plot emissions per year using basic package for all year in Baltimore city for motor vehicle
 
png("plot6.png",width=480,height=480,units="px",bg="transparent")

print({
qplot(year,Emissions,data=groupagg,group=city, color=city, geom=c("point","line"),
      ylab = "Total Emissions, PM2.5", 
      xlab = "Year", main = "MV Tot Emissions - Baltimore Vs California")
})  
dev.off()
  cat("plot6.png has been saved in", getwd())
}
plot6()