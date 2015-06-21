
library(ggplot2)
library(plyr)

## Proble:How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
plot5 <- function() {

# Read RDS data set 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCCmotor <- SCC[grep("motor", SCC$Short.Name, ignore.case = TRUE),]  ## First get the motor vehicle name in the shortname

## Match the identifier of Motor in SCC to NEI
NEImotor <- NEI[as.character(NEI$SCC) %in% as.character(SCCmotor$SCC), ]

 NEImororbaltimore <- NEImotor[(NEImotor$fips=="24510"),]
 
 
 # Aggregate by sum the total emissions by year
 aggEmmbyYrMotor <-aggregate(Emissions ~ year ,NEImororbaltimore ,sum)

 ##Plot emissions per year using basic package for all year in Baltimore city for motor vehicle
 
png("plot5.png",width=480,height=480,units="px",bg="transparent")


# Plot ggplot wher aes compress all plot based on each type 
 barplot(
   (aggEmmbyYrMotor$Emissions),
   names.arg=aggEmmbyYrMotor$year, xlab="Year",
   ylab="Total PM2.5 Emissions Baltimore from motor vehicle ",
   main="Total PM2.5 Emissions for Baltimore from Motor Vehicle "
)


dev.off()
  cat("plot5.png has been saved in", getwd())
}
plot5()