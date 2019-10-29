# STA310 MidTerm Project Graphs and Analysis
# Packages
library(dplyr)
library(ggplot2)
library(mosaic)
library(stringr)

# Load final dataset
HPIdata <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/finalDataset.csv")[-1]
# Change columns into numeric
HPIdata$RegionNum <- as.numeric(substring(HPIdata$Region, 1, 1))
HPIdata$GovHealth <- as.numeric(as.character(HPIdata$GovHealth))
HPIdata$PriHealth <- as.numeric(as.character(HPIdata$PriHealth))
HPIdata$PPP <- as.numeric(as.character(HPIdata$PPP))
HPIdata$PopDensity <- as.numeric(as.character(HPIdata$PopDensity))
HPIdata$WomenParliamant <- as.numeric(as.character(HPIdata$WomenParliamant))

# Happiness Score Distribution
ggplot(data = HPIdata, aes(x = HPI, y = HPIRank)) + geom_point()  +
  aes(colour = Region) + theme(legend.position = "right") + labs(title = "")

# Full model
model <- lm (HPI ~ factor(Region) + factor(Year) + Internet + LifeExpect + GovHealth + PriHealth + PPP +
               PopDensity + UnEmployment + FreedomToChoice + Corruption,
                  data = HPIdata)
anova(model)
res <- model$residuals
plot(res)
qqnorm(res)
mplot(HPIdata)

HPI$Region <- as.character(HPI$Region)
group1 <- filter(HPI, Region[1] == '1')

# Extra Sum of Squares for WomenParliamant and LaborForceFemale
