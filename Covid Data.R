library(tidyverse)
library(jtools)
library(car)
library(vtable)

cps_00002 <- read_dta("data/cps_00002.dta")

covid_data <- cps_00002 %>% select(-c(hwtfinl, asecflag, asecwt, asecwth, wtfinl, hrhhid, cpsid) ) %>% filter(year == 2020)

covid_data <- covid_data %>% na.omit()

vtable(covid_data)

spread <- lm(data = covid_data, month ~ factor(covidmed))

frick_frack <- covid_data %>% filter(covidmed == 99)

think_real <- covid_data %>% filter(covidmed <= 2)

vtable(think_real)

covid_score <- covid_data %>% mutate(covid_score = (covidtelew + covidunaw + covidlook +covidmed))
