# use select() for both datasets
# merge(data frameA,data frameB,by="Country")
# drop_na(name_of_the_column), cause we are prob gonna have some na values, or we can just filter out NA
# values later when we are actually creating the website


#data wrangling for final project 
#drawing in data
library("dplyr")
install.packages("tidyverse")
vaccination_df <- read.csv("~/Downloads/infoDataSet1.csv")
mortality_df <- read.csv("~/Downloads/InfoDataSet2.csv")

#merging our two data frames together 
vaccination_df %>% select("Country")
vaccination_df %>% select("DTP3")
mortality_df %>% select("Country")
mortality_df %>% select("Postneonatal")

merged_df <- merge(vaccination_df, mortality_df, by="Country")
print(merged_df)

#reducing number of rows from 145000 rows to 25000 rows
#use the variable new_merged_df

new_merged_df <- merged_df %>% drop_na(4)
new_merged_df <- merged_df %>% drop_na(5)
new_merged_df <- merged_df %>% drop_na(6)
new_merged_df <- merged_df %>% drop_na(7)
new_merged_df <- merged_df %>% drop_na(8)
new_merged_df <- merged_df %>% drop_na(9)
new_merged_df <- merged_df %>% drop_na(11)
new_merged_df <- merged_df %>% drop_na(12)
new_merged_df <- merged_df %>% drop_na(13)


#new categorical variable 



#new continuous/numerical variable



#summarization data frame
