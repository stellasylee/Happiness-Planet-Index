# World Happiness Planet Index

This research will examine what determines the happiness of a country and will focus on developing our own model to predict happiness of country. Our response variable is the Happiness Planet Index (https://worldhappiness.report/ed/2018/?fbclid=IwAR37naSOvjBPwztHvARL7I3J4F60H7yD2-9DUuO98Xrb1HJsBsk2U0_EdQs) rank based on different values of the explanatory variables. The HPI value is collected in 2009, 2012, 2016. The index is based partly on information gathered by Gallup Poll but also on census data such as life expectancy, GPD, population, etc. In this research, we will develop regression model to assess the best explanatory variables to predict the happiness index of the country. Furthermore, we are planning to compare HPI between region. The sample size of 2009 is 143, 2012 is 150, and 2016 is 140. Therefore, we have total 433 observations.  

Our explanatory variables include:
  * Region
  * Year
  * Life Expectancy at birth (in years)
  * Population Density (people/$km^2$ land area)
  * Purchasing Power Parity (PPP)
  * Government Debt
  * Unemployment
  * Health Expenditure for government and private
  * Perceptions of corruption
  * Freedom to make life choices
  * Social Support
  
After building our final model, we want to focus if the following factors produce better prediction by Extra Sum of Squares:
  * Children out of primary school at school age (% female)
  * Percentage of individuals using the Internet (% of population)
  
  
## Data Resources
1. Happy Planet Index (http://happyplanetindex.org/)
  * Happy Planet Index Score
  * HPI rank
2. World Happiness Report (http://worldhappiness.report/ed/2018/?fbclid=IwAR37naSOvjBPwztHvARL7I3J4F60H7yD2-9DUuO98Xrb1HJsBsk2U0_EdQs) 
  * Perceptions of corruption
  * Freedom to make life choices
  * Social Support
3. WorldBank
  * Percentage of individuals using the Internet (% of population)
  * Population Density (people/$km^2$ land area)
  * Purchasing Power Parity (PPP)
  * Total Unemployment Rate (modeled ILO estimate)
  * Government Health Expenditure
  * Domestic private health expenditure
  * Central Government Debt
  * Children out of primary school at school age (% female)
