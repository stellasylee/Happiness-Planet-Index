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

# Main effect without manipulation
ggplot(data = HPIdata, aes(x = Internet, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Internet")
ggplot(data = HPIdata, aes(x = LifeExpect, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Life Expectency (yr)")
ggplot(data = HPIdata, aes(x = GovHealth, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Government Health Expenditure")
ggplot(data = HPIdata, aes(x = PriHealth, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Private Health Expenditure")
ggplot(data = HPIdata, aes(x = PPP, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Purchasing Power")
ggplot(data = HPIdata, aes(x = PopDensity, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Population Density")
ggplot(data = HPIdata, aes(x = UnEmployment, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Unemployment")
ggplot(data = HPIdata, aes(x = FreedomToChoice, y = HPI)) + geom_point()  +
  aes(colour = factor(RegionNum)) + theme(legend.position = "right") + labs(title = "Main Effect of Freedom to Choice")

## According to main effect plots, we can see that PopDensity is very skewed with extreme values
plot(HPIdata$PopDensity)
plot(log(HPIdata$PopDensity))


# Full model
model <- lm (HPI ~ factor(Region) + factor(Year) + Internet + LifeExpect + GovHealth + PriHealth + PPP +
               PopDensity + UnEmployment + FreedomToChoice + Corruption,
                  data = HPIdata)
anova(model)
# plot(model)

model_transform <- lm (HPI ~ factor(Region) + factor(Year) + Internet + LifeExpect + GovHealth + PriHealth + PPP +
               log(PopDensity) + UnEmployment + FreedomToChoice + Corruption,
             data = HPIdata)
anova(model_transform)

# Extra Sum of Squares for WomenParliamant and LaborForceFemale
