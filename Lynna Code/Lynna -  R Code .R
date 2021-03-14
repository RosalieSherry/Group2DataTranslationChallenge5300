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
