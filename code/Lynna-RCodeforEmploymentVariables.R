##Employment Variables

##library(tidyverse)
#library(ipumsr)
#library(lubridate)


##Data from IPUMS
ddi <- read_ipums_ddi("/Users/lynnatran/Documents/MSBA/5300 - Econometrics/Data Translation Challenge/Git Repository/Group2DataTranslationChallenge5300/rawdata/LynnaCPSfiles/cps_00001.xml")

data <- read_ipums_micro(ddi) 


##IndustryCodes
RetailIndustryCodes20142019 <- read_csv('/Users/lynnatran/Documents/MSBA/5300 - Econometrics/Data Translation Challenge/Git Repository/Group2DataTranslationChallenge5300/data/20142019IndustryCodes.csv')

RetailIndustryCodes2020 <- read_csv('/Users/lynnatran/Documents/MSBA/5300 - Econometrics/Data Translation Challenge/Git Repository/Group2DataTranslationChallenge5300/data/2020IndustryCodes.csv')


data <-data %>%
  filter(!is.na(HWTFINL))


work_df <- data %>% 
  select(YEAR, SERIAL, MONTH, CPSIDP, PERNUM, HWTFINL, EMPSTAT, LABFORCE, OCC, OCC2010, IND,
         CLASSWKR, UHRSWORKT, UHRSWORK1, UHRSWORK2, AHRSWORKT, AHRSWORK1, AHRSWORK2,
         DURUNEMP, WHYUNEMP, WHYPTLWK, WNLOOK, WKSTAT, MULTJOB, NUMJOB) %>%
  rename(IndustryCode = 'IND' )



jobtenure_df <- data %>%
  select(YEAR, SERIAL, MONTH, CPSIDP, PERNUM, HWTFINL, JTYEARS, JTYEARAGO, JTSAME, JTYPE, JTCLASS,
         JTIND, JTOCC)


##Notes from tidying:
# -Occupation data might not be as useful as industry data 
# - I will add the usual/ actual hours worked later if we need more fluff but we might not not need it now 

##choosing to mutate most columns since a filter might drop rows with data we'd need
work_df <- work_df %>%
  mutate(employed = EMPSTAT == 01 | EMPSTAT == 10 | EMPSTAT == 12) %>%
  mutate(unemployed = EMPSTAT == 20 | EMPSTAT == 21 | EMPSTAT == 22 
         | EMPSTAT == 30 | EMPSTAT == 31 | EMPSTAT == 32 | EMPSTAT == 33
         | EMPSTAT == 34 | EMPSTAT == 35 | EMPSTAT == 36 ) %>%
  mutate(labor_force = LABFORCE == 2) %>%
  mutate(class_worker = (ifelse(CLASSWKR == 00 | CLASSWKR == 99, NA, CLASSWKR))) %>%
  mutate(num_weeks_employed =(ifelse(DURUNEMP == 999, NA, DURUNEMP))) %>%
  mutate(reason_unemployment =(ifelse(WHYUNEMP == 0, NA, WHYUNEMP))) %>%
  mutate(after2020 = YEAR > 2020 ) 

work_df <- work_df %>%
  left_join(RetailIndustryCodes20142019, by = 'IndustryCode') %>%
  left_join(RetailIndustryCodes2020, by = 'IndustryCode')  %>%
  mutate(retail = !is.na(Industry.x) | !is.na(Industry.y)) %>%
  mutate(work_industryname = ifelse(after2020 == TRUE, Industry.y, Industry.x ))

work_df <- work_df %>%
  select(YEAR, SERIAL, MONTH, CPSIDP, PERNUM, HWTFINL,
         EMPSTAT, unemployed,
         LABFORCE, labor_force, ##  OCC, OCC2010, not sure if we'd use occupation yet
         IndustryCode, retail, work_industryname, 
         CLASSWKR, class_worker,
         ##UHRSWORKT, UHRSWORK1, UHRSWORK2, AHRSWORKT, AHRSWORK1, AHRSWORK2, might add hours of work later
         DURUNEMP, num_weeks_employed,
         WHYUNEMP, reason_unemployment)
##WHYPTLWK, WNLOOK, WKSTAT, MULTJOB, NUMJOB, might look into later if we need more information)



#will have to merge with retail industry table to generate retail industry variable so will do that after tidying up work_df first 


jobtenure_df <- jobtenure_df %>%
  mutate(employment_year_ago = (ifelse(JTYEARAGO == 96 | JTYEARAGO == 97 |
                                         JTYEARAGO == 98 | JTYEARAGO == 99, 
                                       NA, JTYEARAGO))) %>%
  mutate(same_work_lastyear = (ifelse(JTSAME == 96 | JTSAME == 97 |
                                        JTSAME == 98 | JTSAME == 99, 
                                      NA, JTSAME))) %>%
  mutate(retail_lastyear = JTYPE == 02  ) %>%
  mutate(industry_lastyear = (ifelse(JTYPE == 96 | JTYPE == 97 |
                                       JTYPE == 98 | JTYPE == 99, 
                                     NA, JTYPE)))  %>%
  mutate(after2020 = YEAR > 2020 )  %>%
  mutate(IndustryCode = JTIND)

jobtenure_df <- jobtenure_df %>%
  left_join(RetailIndustryCodes20142019, by = 'IndustryCode' ) %>%
  left_join(RetailIndustryCodes2020, by = 'IndustryCode')  %>%
  mutate(retail_industry = !is.na(Industry.x) | !is.na(Industry.y)) %>%
  mutate(jt_industryname = ifelse(after2020 == TRUE, Industry.y, Industry.x ))

jobtenure_df <- jobtenure_df %>%
  select(YEAR, SERIAL, MONTH, CPSIDP, PERNUM,
         HWTFINL,
         ##JTYEARS, not sure if thats going to be useful yet
         JTYEARAGO, employment_year_ago,  JTSAME, same_work_lastyear,  JTYPE, retail_lastyear, industry_lastyear,
         JTIND,retail_industry, jt_industryname)
         #JTCLASS,JTOCC

##adding primary key to do joins 


work_df$household_personid <- paste(work_df$YEAR, work_df$MONTH, work_df$SERIAL, work_df$PERNUM, sep="-")

jobtenure_df$household_personid <- paste(jobtenure_df$YEAR, jobtenure_df$MONTH, jobtenure_df$SERIAL, jobtenure_df$PERNUM, sep="-")

employment_df <- inner_join(work_df, jobtenure_df, by = 'household_personid') %>%
  select(YEAR.x, SERIAL.x, MONTH.x, SERIAL.x, PERNUM.x, household_personid,
         HWTFINL.x, ##shared variables
         ##work_df variables
         unemployed, 
         labor_force, IndustryCode, retail, work_industryname, 
         class_worker, num_weeks_employed, reason_unemployment,
         ##jobtenure_df variables
         employment_year_ago, same_work_lastyear, 
         retail_lastyear, industry_lastyear, retail_industry, jt_industryname)

