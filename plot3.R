library(ggplot2)
library(plyr)

plot3 <- function() {

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which 
#of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in
#emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question

# Read RDS data set 
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

 baltimoredata <- NEI[(NEI$fips=="24510"),]
 
# Aggregate by sum the total emissions by year
 baltitype <- ddply(baltimoredata, .(type, year), summarize, Emissions = sum(Emissions))
 baltitype$Pollutant_Type <- baltitype$type
 
##Plot emissions per year using basic package

png("plot3.png",width=480,height=480,units="px",bg="transparent")


# Plot ggplot wher aes compress all plot based on each type 
print({
 qplot(factor(year), Emissions, data = baltitype, group = Pollutant_Type,  color = Pollutant_Type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "PM2.5 Emissions  by Type of Pollutant Baltimore")
})
dev.off()
  cat("plot3.png has been saved in", getwd())
}
plot3()