library(tidyverse)
library(haven)
library(jtools)
library(car)
library(vtable)
library(Hmisc)

cps_00002 <- read_dta("data/cps_00002.dta")

covid_data <- cps_00002 %>% select(-c(hwtfinl, asecflag, asecwt, asecwth, wtfinl, hrhhid, cpsid) ) %>% filter(year == 2020)

covid_data <- covid_data %>% na.omit()

vtable(covid_data)

spread <- lm(data = covid_data, month ~ factor(covidmed))

frick_frack <- covid_data %>% filter(covidmed == 99)

think_real <- covid_data %>% filter(covidmed <= 2)

vtable(think_real)

factor_covid <- covid_data %>% mutate(covidtelew = as.factor(covidtelew)) %>%
  mutate(covidpaid = as.factor(covidpaid)) %>% mutate(covidlook = as.factor(covidlook)) %>% 
  mutate(covidmed = as.factor(covidmed)) %>% mutate(covidunaw = as.factor(covidunaw))

covid_score <- covid_data %>% mutate(covid_score = (covidtelew + covidunaw + covidlook +covidmed))

numeric_covid <- covid_data %>% mutate(covidtelew = as.numeric(covidtelew)) %>%
  mutate(covidpaid = as.numeric(covidpaid)) %>% mutate(covidlook = as.numeric(covidlook)) %>% 
  mutate(covidmed = as.numeric(covidmed)) %>% mutate(covidunaw = as.numeric(covidunaw))

covid_data_v2 <- numeric_covid %>% mutate(covidtelew = case_when(covidtelew == 99 ~ 0,TRUE ~ covidtelew)) %>%
  mutate(covidunaw = case_when(covidunaw == 99 ~ 0,TRUE ~ covidunaw)) %>%
  mutate(covidpaid = case_when(covidpaid == 99 ~ 0,TRUE ~ covidpaid)) %>%
  mutate(covidlook = case_when(covidlook == 99 ~ 0,TRUE ~ covidlook)) %>%
  mutate(covidmed = case_when(covidmed == 99 ~ 0,TRUE ~ covidmed))

vtable(covid_data_v2)

covid_data_v2_labels <- c(year = 'survey year', serial = 'household serial number', month = 'month',
                          hrhhid2 = 'household id, part 2', pernum = 'person number in sample unit',
                          cpsidp = 'cpsid, person record',
                          covidtelew = "worked remotely for pay due to covid-19 pandemic", 
                          covidunaw = 'unable to work due to covid-19 pandemic', 
                          covidpaid = 'received pay for hours not worked due to the covid-19 pandemic',
                          covidlook = 'prevented from looking for work due to covid-19 pandemic',
                          covidmed = 'did not get needed medical care for condition other than covid-19 due to the covid-19 pandemic')
label(covid_data_v2) = as.list(covid_data_v2_labels[match(names(covid_data_v2), names(covid_data_v2_labels))])

vtable(covid_data_v2)

covid_score <- covid_data_v2 %>% mutate(covid_score = (covidtelew + covidunaw + covidlook +covidmed))
