library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


baltmore_city <- NEI[NEI$fips == "24510", ]
total_emissions <- summarise(group_by(baltmore_city, year, type), Emissions=sum(Emissions))
plot2 <- ggplot(
  total_emissions,
  aes(x = factor(year), y = Emissions, fill = type, label = round(Emissions))) +
  geom_bar(stat = "identity") +
  theme_bw() + 
  guides(fill = FALSE)+
  facet_grid(. ~ type, scales = "free",space = "free") +
  labs(x = "year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title = "Total PM2.5 emissions from 1999–2008 for Baltimore City")

plot2

dev.off()
