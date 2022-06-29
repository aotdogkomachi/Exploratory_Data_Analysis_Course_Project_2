library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_emissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))
plot1 <- barplot(
  total_emissions$Emissions/1000, 
  names.arg = total_emissions$year, 
  xlab = "years", 
  ylab = "Total PM2.5 Emissions in kilotons", 
  main = "Total emissions from PM2.5 decreased in the United States from 1999 to 2008",
  col = "brown3",
  ylim = c(0,8000)
  )

dev.off()
