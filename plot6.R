library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]
baltimore_vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510",]
baltimore_vehicles_NEI$city <- "Baltimore City"
vehicles_LA_NEI <- vehicles_NEI[vehicles_NEI$fips=="06037",]
vehicles_LA_NEI$city <- "Los Angeles County"
combine_NEI <- rbind(baltimore_vehicles_NEI,vehicles_LA_NEI)


plot6 <- ggplot(
  combine_NEI, 
  aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(stat = "identity") +
  facet_grid(scales = "free", space = "free", . ~ city) +
  guides(fill = FALSE) + 
  theme_bw() +
  labs(x = "year", y = "Total PM2.5 Emissions in Tons") + 
  labs(title = "Motor vehicle emission variation in Baltimore and Los Angeles in tons") +
  ylim(c(0, 7000))

plot6

dev.off()