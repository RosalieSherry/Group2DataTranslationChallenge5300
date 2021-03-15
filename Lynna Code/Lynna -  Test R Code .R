#Lynna Tran
#OSMBA 5300 - Econometrics
#Data Translation Challenge

library(tidyverse)
library(ipumsr)


##employment_df <- readRDS("cps_0001.dat")
ddi <- read_ipums_ddi("cps_00001.xml")
data <- read_ipums_micro(ddi)


##testing work hours variables 
test_workhours_variables <- work_df %>%
  select(UHRSWORKT,hours_alljobs_week, UHRSWORK1, hours_mainjobs_week, 
         UHRSWORK2, hours_usual_otherjobs_week)

view(test_workhours_variables)


ds_count <- employment_df %>%
  count(household_personid)

view(ds_count)
####  
ds_test <- employment_df %>%
  filter(household_personid == '2020-3-1-1')

ds_testworkdf <- work_df %>%
  filter(household_personid == '2020-3-1-1')

ds_testjtdf <- jobtenure_df %>%
  filter(household_personid == '2020-3-1-1')

data_test <- data %>%
  filter(YEAR  == '2020' & MONTH == 3 & SERIAL == 1 & PERNUM == 1)

data_ds_test <- data %>%
  filter(!is.na(HWTFINL))


data_ds_test$household_personid <- paste(data_ds_test$YEAR, data_ds_test$MONTH, data_ds_test$SERIAL, data_ds_test$PERNUM, sep="-")


data_test <- data_ds_test %>%
  count(household_personid)
 ## count(YEAR  == '2020' & MONTH == 3 & SERIAL == 1 & PERNUM == 1)
 ## filter(YEAR  == '2020' & MONTH == 3 & SERIAL == 1 & PERNUM == 1)


remove( ds_testworkdf)

