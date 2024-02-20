#data wrangling for final project 
#drawing in data
library("dplyr")
install.packages("tidyverse")
vaccination_df <- read.csv("~/infoDataSet1.csv")
mortality_df <- read.csv("~/InfoDataSet2.csv")

#merging our two data frames together 
vaccination_df <- vaccination_df %>% select("Country", "DTP3") %>% drop_na()
mortality_df <- mortality_df %>% select("Country", "Postneonatal") 

merged_df <- merge(vaccination_df, mortality_df, by="Country")

#reducing number of rows from 145000 rows to 25000 rows
#use the variable new_merged_df

vaccine_mortality_df <- merged_df %>% 
  group_by(Country) %>% 
  summarise(Postneonatal = mean(Postneonatal), DTP3 = mean(DTP3))

#new categorical variable 
# https://www.aafp.org/news/health-of-the-public/kindergarten-vaccine-rates-2023-report.html#:~:text=National%20vaccination%20coverage%20rates%20for,in%20the%20previous%20school%20year.
# source for finding that 93.1% is good national vaccination coverage rates
# adding a new col that is a bool value for if above the national vaccination coverage rates or not
vaccine_mortality_df <- vaccine_mortality_df %>%
  mutate(AboveAvgVaccination = (DTP3 >= 93.1))

#new continuous/numerical variable
# calculating the ratio of how many people died per not taking the shot, DTP3, out of 100 people in that country 
vaccine_mortality_df <- vaccine_mortality_df %>%
  mutate(died_per_shot_not_taken = round((round(Postneonatal)/(100-round(DTP3)))))

#summarization data frame
# average DTP shot rate for the world overall
countries_avg_DTP_rate <- summarize(vaccine_mortality_df, DTP_rate = mean(DTP3))
