##Employment Variables

##library(tidyverse)
#library(ipumsr)
#library(lubridate)


##Data from IPUMS
ddi <- read_ipums_ddi("/Users/lynnatran/Documents/MSBA/5300 - Econometrics/Data Translation Challenge/Git Repository/Group2DataTranslationChallenge5300/rawdata/LynnaCPSfiles/cps_00001.xml")

data <- read_ipums_micro(ddi) 

##IndustryCodes
##RetailIndustryCodes2020 <- read_csv('/Users/lynnatran/Documents/MSBA/5300 - Econometrics/Data Translation Challenge/Git Repository/Group2DataTranslationChallenge5300/data/2020IndustryCodes.csv')
RetailIndustryCodes <- read_csv('/Users/lynnatran/Documents/MSBA/5300 - Econometrics/Data Translation Challenge/Git Repository/Group2DataTranslationChallenge5300/data/indnames.csv')

data <- data %>%
 filter(!is.na(HWTFINL)) %>%
  select(-c(CPSID, ASECFLAG, ASECWTH, CPSIDP , ASECWT, CPSIDP, ASECWT, 
            OCC2010, UHRSWORKT, UHRSWORK1, UHRSWORK2,  AHRSWORKT, AHRSWORK1, AHRSWORK2,
            WHYPTLWK, WNFTLOOK, WKSTAT, MULTJOB
            # DWLOSTJOB, DWSTAT, DWREAS,
            # DWRECALL, DWNOTICE, DWLASTWRK, DWYEARS, DWFULLTIME, DWUNION, DWBEN, 
            # DWEXBEN, DWHI, DWCLASS, DWIND, DWOCC, DWMOVE, DWHINOW, DWJOBSINCE, 
            # DWWEEKC, DWWAGEC, DWHRSWKC, DWRESP, DWSUPPWT)
         ))

employment_variables <- data %>%
  rename(ind = 'IND') %>%
  mutate(employed = EMPSTAT == 01 | EMPSTAT == 10 | EMPSTAT == 12) %>%
  mutate(labor_force = LABFORCE == 2) %>%
  mutate(class_worker = (ifelse(CLASSWKR == 00 | CLASSWKR == 99, NA, CLASSWKR))) %>%
  mutate(num_weeks_employed =(ifelse(DURUNEMP == 999, NA, DURUNEMP))) %>%
  mutate(reason_unemployment =(ifelse(WHYUNEMP == 0, NA, WHYUNEMP))) %>%
  mutate(employment_year_ago = (ifelse(JTYEARAGO == 96 | JTYEARAGO == 97 |
                                         JTYEARAGO == 98 | JTYEARAGO == 99, 
                                       NA, JTYEARAGO))) %>%
  mutate(same_work_lastyear = (ifelse(JTSAME == 96 | JTSAME == 97 |
                                        JTSAME == 98 | JTSAME == 99, 
                                      NA, JTSAME))) %>%
  mutate(retail_lastyear = JTYPE == 02  ) %>%
  mutate(industry_lastyear = case_when(
    JTYPE == 01 ~ 'Manufacturing',
    JTYPE == 02 ~ 'Retail',
    JTYPE == 03 ~ 'Wholesale Trade',
    JTYPE == 04 ~ 'Something else',
    JTYPE == 96 ~ 'NA',
    JTYPE == 97 ~ 'NA',
    JTYPE == 98 ~ 'NA',
    JTYPE == 99 ~ 'NA'))
  
  

employment_df <- employment_variables %>%
  left_join(RetailIndustryCodes, by = 'ind')  %>%
  mutate(retail = indname == 'Retail Trade')


#employment_df$household_personid <- paste(employment_df$YEAR, employment_df$MONTH, employment_df$SERIAL, employment_df$PERNUM, sep="-")


employment_df_labels <- c(year = 'survey year', serial = 'household serial number', month = 'month',
                         ## household_personid = 'Year-month-household-person unique identifer',
                          employed = 'Employment status', 
                          labor_force = "labor force status", 
                          class_worker = 'class of worker', 
                          num_weeks_employed = '# of weeks employed',
                          reason_unemployment = 'reason for unemployment',
                          same_work_last_year = 'doing the same work last year',
                          retail_last_year = 'did the individual work in the retail industry last year ',
                          industry_last_year = 'industry one year ago',
                          indname = 'Industry Name',
                          retail = 'Whether the individual was employed in a retail industry')
label(employment_df) = as.list(employment_df_labels[match(names(employment_df), names(employment_df_labels))])



