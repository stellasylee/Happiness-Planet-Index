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
