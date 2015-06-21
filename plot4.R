library(ggplot2)
library(plyr)

plot4 <- function() {

## Problem:Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Read RDS data set 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCCcoal <- SCC[grep("coal", SCC$SCC.Level.Three, ignore.case = TRUE),] 

## Match the identifier of Motor in SCC to NEI
NEIcomb <- NEI[as.character(NEI$SCC) %in% as.character(SCCcoal$SCC), ]

 
 
 # Aggregate by sum the total emissions by year
 aggEmmbyYrcomb <-aggregate(Emissions ~ year ,NEIcomb ,sum)


png("plot4.png",width=480,height=480,units="px",bg="transparent")
print ({ ## becuase when call qq plot from function need to use print statement
g = ggplot(aggEmmbyYrcomb, aes(factor(year), Emissions/10^4))
g +  geom_bar(stat="identity") +  labs(title="Total PM 2.5 Emission from Coalcombustion related", x="Year",y="Total PM2.5 Emissions /10^4")
})
  dev.off()
  cat("plot4.png has been saved in", getwd())
}
plot4()