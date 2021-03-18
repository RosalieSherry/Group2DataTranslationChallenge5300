############### Load libraries
# library(tidyverse)
# library(jtools)
# library(vtable)
# library(haven)
# library(lubridate)
# library(tidylog)
# library(estimatr)
# library(ggplot)
# library(srvyr) # install.packages("srvyr")
# library(zoo) # dates library with yearmo
# options(scipen=999) # remove scientific notation

df <- read_dta('/Users/lynnatran/Documents/MSBA/5300 - Econometrics/Data Translation Challenge/Git Repository/Group2DataTranslationChallenge5300/rawdata/cps_00004.dta')

df <- df %>% 
   mutate(
    female = case_when(
    sex == 1 ~ 0, # 1 - Male
    sex == 2 ~ 1), # 2 - Female
  racialCategories = case_when(
    race == 100 ~ "white",
    race == 200 ~ "Black",
    race == 651 ~ "Asian"),
  coveredByHealthInsurance = case_when(
    anycovnw == 1  ~ "covered",
    anycovnw == 2 ~ "not covered"),
  highestEducationlevel = case_when(
    educ99 == 1 ~ "No school",
    educ99 == 4 ~ "1st-4th grade",
    educ99 == 5 ~ "5th-8th grade",
    educ99 == 6 ~ "9th 'grade",
    educ99 == 7 ~ "10th grade",
    educ99 == 8 ~ "11th grade",
    educ99 == 9 ~ "12th grade but no diploma",
    educ99 == 10 ~ "High School graduate or GED",
    educ99 == 11 ~ "Some college but no degree",
    educ99 == 13 ~ "Associate degree or occupational program",
    educ99 == 14 ~ "Associate degree or academic program",
    educ99 == 15 ~ "Bachelors degree",
    educ99 == 16 ~ "Masters degree",
    educ99 == 17  ~ "Professional degree",
    educ99 == 18 ~ "Doctorate degree"),
  ageGeneration = case_when( #Going by generation will make it easier to look at everything without getting overwhelmed
    age %in% c(16:22) ~ "Generation Z",
    age %in% c(23:38) ~  "Millennial",
    age %in% c(39:54) ~ "Generation",
    age %in% c(55:73) ~ "Baby Boomers")
  )

  
