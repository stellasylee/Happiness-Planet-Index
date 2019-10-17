library(dplyr)
library(tidyverse)
library(tidyr)

# Upload HPI data ----
HPI2009 <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/Raw%20Data/2009HPI.csv")
HPI2012 <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/Raw%20Data/2012HPI.csv")
HPI2016 <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/Raw%20Data/2016HPI.csv")

HPI2009 <- HPI2009[,c(2,3,8,9)]
HPI2012 <- HPI2012[,c(2,3,8,1)]
HPI2016 <- HPI2016[,c(2,3,11,1)]

# Match column name
colname <- c("Country", "Region", "HPI", "HPIRank")
colnames(HPI2009) <- colname
colnames(HPI2012) <- colname
colnames(HPI2012) <- colname

# Create "Year" column for merging dataset
HPI2009 <- dplyr::mutate(HPI2009, Year = 2009)
HPI2012 <- dplyr::mutate(HPI2009, Year = 2012)
HPI2016 <- dplyr::mutate(HPI2009, Year = 2016)

# Merge HPI dataset
HPI <- rbind.data.frame(HPI2009, HPI2012, HPI2016)
HPI$Country <- as.character(HPI$Country)

# Merge Internet Usage ----
Internet <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/Raw%20Data/Internet%20Usage.csv")
colnames(Internet) <- c("Country", "Code", "Internet", "2009", "2012", "2016")
Internet$Country <- as.character(Internet$Country)

# Correct country names from world bank (merged by https://countrycode.org)
HPI$Country[HPI$Country == "United States of America"] <- "United States" 
HPI$Country[HPI$Country == "Korea"] <- "Korea, Rep." 
HPI$Country[HPI$Country == "Burma"] <- "Myanmar"
HPI$Country[HPI$Country == "Republic of Congo"] <- "Congo, Rep." 
HPI$Country[HPI$Country == "Democratic Republic of the Congo"] <- "Congo, Dem. Rep."

needtofix <- dplyr::anti_join(HPI, Internet, by="Country")$Country
changeWorldBankCountry <- function (df){
  df$Country[df$Country == "Russian Federation"] <- "Russia"
  df$Country[df$Country == "Egypt, Arab Rep."] <- "Egypt"
  df$Country[df$Country == "Hong Kong SAR, China"] <- "Hong Kong"
  df$Country[df$Country == "Iran, Islamic Rep."] <- "Iran"
  df$Country[df$Country == "Kyrgyz Republic"] <- "Kyrgyzstan"
  df$Country[df$Country == "Lao PDR"] <- "Laos"
  df$Country[df$Country == "North Macedonia"] <- "Macedonia"
  df$Country[df$Country == "West Bank and Gaza"] <- "Palestine"
  df$Country[df$Country == "Slovak Republic"] <- "Slovakia"
  df$Country[df$Country == "Syrian Arab Republic"] <- "Syria"
  df$Country[df$Country == "Venezuela, RB"] <- "Venezuela"
  df$Country[df$Country == "Yemen, Rep."] <- "Yemen"
  return (df)
}

Internet <- changeWorldBankCountry(Internet)
Internet <- gather(data=Internet, key = Year, value = "Internet", "2009", "2012", "2016")

# Other WorldBank Variables ----
worldBank <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/Raw%20Data/WorldBankData.csv")
colnames(worldBank) <- c("Variable", "VariableCode", "Country", "Code", "2009", "2012", "2016")
worldBank$Country <- as.character(worldBank$Country)
worldBank <- changeWorldBankCountry(worldBank)
worldBank <- worldBank[1:2904,] # remove unneccessary rows
LifeExpect <- dplyr::filter(worldBank, VariableCode == "SP.DYN.LE00.IN")[,3:7] %>% 
  gather(data=., key = Year, value = "LifeExpect", "2009", "2012", "2016")
GovDebt <- dplyr::filter(worldBank, VariableCode == "GC.DOD.TOTL.GD.ZS")[,3:7] %>% 
  gather(data=., key = Year, value = "GovDebt", "2009", "2012", "2016")
FemaleOutSchool <- dplyr::filter(worldBank, VariableCode == "SE.PRM.UNER.FE.ZS")[,3:7] %>% 
  gather(data=., key = Year, value = "FemaleOutSchool", "2009", "2012", "2016")
GovHealth <- dplyr::filter(worldBank, VariableCode == "SH.XPD.GHED.PP.CD")[,3:7] %>% 
  gather(data=., key = Year, value = "GovHealth", "2009", "2012", "2016")
PriHealth <- dplyr::filter(worldBank, VariableCode == "SH.XPD.PVTD.PP.CD")[,3:7] %>% 
  gather(data=., key = Year, value = "PriHealth", "2009", "2012", "2016")
EduSecondaryFemale <- dplyr::filter(worldBank, VariableCode == "SE.SEC.CUAT.LO.FE.ZS")[,3:7] %>% 
  gather(data=., key = Year, value = "EduSecondaryFemale", "2009", "2012", "2016")
PPP <- dplyr::filter(worldBank, VariableCode == "NY.GDP.PCAP.PP.CD")[,3:7] %>% 
  gather(data=., key = Year, value = "PPP", "2009", "2012", "2016")
PopDensity <- dplyr::filter(worldBank, VariableCode == "EN.POP.DNST")[,3:7] %>% 
  gather(data=., key = Year, value = "PopDensity", "2009", "2012", "2016")
UnEmployment <- dplyr::filter(worldBank, VariableCode == "SL.UEM.TOTL.ZS")[,3:7] %>% 
  gather(data=., key = Year, value = "UnEmployment", "2009", "2012", "2016")

# Merge HPI, Internet, WorldBank variables ----
Internet$Year <- as.character(Internet$Year)
HPI$Year <- as.character(HPI$Year)
merged <- left_join (HPI, Internet, by=c("Country", "Year")) %>%
  left_join(., LifeExpect, by=c("Country", "Year", "Code")) %>%
  left_join(., GovDebt, by=c("Country", "Year", "Code")) %>%
  left_join(., FemaleOutSchool, by=c("Country", "Year", "Code")) %>%
  left_join(., GovHealth, by=c("Country", "Year", "Code")) %>%
  left_join(., PriHealth, by=c("Country", "Year", "Code")) %>%
  left_join(., EduSecondaryFemale, by=c("Country", "Year", "Code")) %>%
  left_join(., PPP, by=c("Country", "Year", "Code")) %>%
  left_join(., PopDensity, by=c("Country", "Year", "Code")) %>%
  left_join(., UnEmployment, by=c("Country", "Year", "Code"))

# Add variables from Happiness Report
otherV <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/Raw%20Data/OtherVariables.csv")
otherV <- otherV[,c(1,2,5,7,9)]
otherV <- filter(otherV, (year=='2009'|year=='2012'|year=='2016'))
colnames(otherV) <- c("Country", "Year", "SocialSupport", "FreedomToChoice", "Corruption")
otherV$Year <- as.character(otherV$Year)
otherV$Country <- as.character(otherV$Country)
full <- left_join (merged, otherV, by=c("Country", "Year"))

write.csv(full, "H:\\310\\finalDataset.csv")

# laborWomen <- read.csv("https://raw.githubusercontent.com/stellasylee/Happiness-Planet-Index/master/Raw%20Data/LaborForceFemale.csv")
# laborWomen <- laborWomen[,c(3,4,5,6,7)]
# colnames(laborWomen) <- c("Country", "Code", "2009", "2012", "2016")
# laborWomen <- gather(data=laborWomen, key=Year, value="Labor Force Percentage", "2009", "2012", "2016")
# laborWomen <- laborWomen[!(laborWomen$Country == ""), ]
# laborWomen <- laborWomen[!is.na(laborWomen$Country), ]

