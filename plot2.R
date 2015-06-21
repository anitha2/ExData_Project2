plot2 <- function() {

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
#plot answering this question.

# Read RDS data set 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

 baltimoredata <- NEI[(NEI$fips=="24510"),]
# Aggregate by sum the total emissions by year
aggBalti <-aggregate(Emissions ~ year ,baltimoredata ,sum)

##Plot emissions per year using basic package

png("plot2.png",width=480,height=480,units="px",bg="transparent")
# Plot the existing yr in table against the emission
barplot(
  (aggBalti$Emissions),
  names.arg=aggBalti$year, xlab="Year",
  ylab="Total PM2.5 Emissions Baltimore  ",
  main="Total PM2.5 Emissions for Baltimore against Year"
)

dev.off()
  cat("plot2.png has been saved in", getwd())
}
plot2()