# load libraries and read data
source("../code/01_g2_dtc_libraries.R")
source("../code/02_g2_dtc_read_data.R")

# tidy data for years 2016-2021 only, sort by person ID (PERID) made up by HRHHID2_PERNUM
record_displ_workers <- cps_displ_workers %>%
  select('year', 'cpsidp', 'hrhhid2', 'pernum', 'serial', 'month', 'dwlostjob', 'dwstat', 
         'dwreas', 'dwrecall', 'dwben', 'dwhi', 'dwind', 'dwocc') %>%
  filter(year > '2015')

##record_displ_workers <- labeltable(record_displ_workers)
##vtable(record_displ_workers)

#change all N/A's to zeros
record_displ_workers[is.na(record_displ_workers)] = 0
  
displ_workers <- record_displ_workers %>%
# displaced workers who lost or left their job
# DWLOSTJOB == 1	No 
# DWLOSTJOB == 2	Yes 
# DWLOSTJOB == 96	Refused 
# DWLOSTJOB == 97	Don't Know 
# DWLOSTJOB == 98	No response 
# DWLOSTJOB == 99	NIU
  mutate(lost_job = case_when(
    dwlostjob == 1 ~ 'No',
    dwlostjob == 2 ~ 'Yes',
    dwlostjob == 96 ~ 'Null',
    dwlostjob == 97 ~ 'Null',
    dwlostjob == 98 ~ 'Null')) %>%
  
# displaced workers status
# DWSTAT == 00 Not a displaced worker
# DWSTAT == 01 Displaced Worker
# DWSTAT == NIU Armed forces
  mutate(displ_worker_stat = dwstat == 01) %>%

# reason for displaced worker
# DWREAS == 1 closed or moved
# DWREAS == 2 insufficient work
# DWREAS == 3 position abolished
# DWREAS == 4 seasonal job complete
# DWREAS == 5 self-operated business failed
# DWREAS == 6 other
# DWREAS == 96 refused
# DWREAS == 97 don't know
# DWREAS == 98 no response
# DWREAS == 99 NIU
  mutate(reason_displ = case_when(
      dwreas == 1 ~ 'Closed or Moved',
      dwreas == 2 ~ 'Insufficient Work',
      dwreas == 3 ~ 'Position Abolished',
      dwreas == 4 ~ 'Seasonal Job Complete',
      dwreas == 5 ~ 'Seasonal Job Complete',
      dwreas == 6 ~ 'Other',
      dwreas == 96 ~ 'Null',
      dwreas == 97 ~ 'Null',
      dwreas == 98 ~ 'Null',
      dwreas == 99 ~ 'Null'))

