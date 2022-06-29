library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

combustion_related <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal_related <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_combustion <- (combustion_related & coal_related)
combustion_SCC <- SCC[coal_combustion,]$SCC
combustion_NEI <- NEI[NEI$SCC %in% combustion_SCC,]

plot4 <- ggplot(
  combustion_NEI,
  aes(x = factor(year), y = Emissions/1000, fill = year)) +
  geom_bar(stat = "identity", fill = "brown3") +
  theme_bw() +
  guides(fill = FALSE) +
  labs(x = "year", y = "PM2.5 Emissions in Kilotons") + 
  labs(title = "Emissions from coal combustion-related sources changed from 1999–2008") +
  ylim(c(0, 600))

plot4

dev.off()
