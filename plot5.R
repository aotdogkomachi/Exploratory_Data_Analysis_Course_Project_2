library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]
baltimore_vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510",]

plot5 <- ggplot(
  baltimore_vehicles_NEI, 
  aes(x = factor(year), y = Emissions)) +
  geom_bar(stat = "identity", fill = "brown3") +
  theme_bw() +
  guides(fill = FALSE) +
  labs(x = "year", y = "PM2.5 Emissions in Tons") + 
  labs(title = "Total emissions from motor vehicle sources changed from 1999–2008 in Baltimore City") +
  ylim(c(0, 400))

plot5

dev.off()
