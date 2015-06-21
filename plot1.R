plot1 <- function() {

# Read RDS data set 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Aggregate by sum the total emissions by year
aggEmmbyYr <-aggregate(Emissions ~ year ,NEI ,sum)

##Plot emissions per year using basic package

png("plot1.png",width=480,height=480,units="px",bg="transparent")
# Plot the existing yr in table against the emission
barplot(
  (aggEmmbyYr$Emissions)/10^5,
  names.arg=aggEmmbyYr$year, xlab="Year",
  ylab="Total PM2.5 Emissions  (10^5 Tons)",
  main="Total PM2.5 Emissions From All US Sources against Year"
)

dev.off()
  cat("plot1.png has been saved in", getwd())
}
plot1()