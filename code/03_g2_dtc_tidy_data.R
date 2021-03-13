# load libraries and read data
source("../code/01_g2_dtc_libraries.R")
source("../code/02_g2_dtc_read_data.R")

# tidy data for years 2016-2021 only, sort by person ID (PERID) made up by HRHHID2_PERNUM
record_displ_workers <- cps_displ_workers %>%
  rename_with(toupper)%>%
  unite("PERID", c("HRHHID2", "PERNUM"), sep = "_")  %>%
  select('PERID','YEAR', 'CPSIDP', 'HRHHID2', 'PERNUM', 'SERIAL', 'MONTH', 'DWLOSTJOB', 'DWSTAT', 
         'DWREAS', 'DWRECALL', 'DWBEN', 'DWHI', 
         'DWIND', 'DWOCC') %>%
  filter(YEAR > '2015')

#change all N/A's to zeros
record_displ_workers[is.na(record_displ_workers)] = 0
  
    
# displaced workers only (DWSTAT == 01)
# DWSTAT == 00 Not a displaced worker
# DWSTAT == 01 Displaced Worker
# DWSTAT == NIU Armed forces
displ_workers <- record_displ_workers %>%  
  filter(DWSTAT == 01)
  
# reason for displaced worker
# DWSTAT == 1 closed or moved
# DWSTAT == 2 insufficient work
# DWSTAT == 3 position abolished
# DWSTAT == 4 seasonal job complete
# DWSTAT == 5 self-operated business failed
# DWSTAT == 6 other
# DWSTAT == 96 refused
# DWSTAT == 97 don't know
# DWSTAT == 98 no response
# DWSTAT == 99 NIU
reason_insuf_work <- displ_workers %>%
  filter(DWREAS == 2)
  
reason_pos_abolished <- displ_workers %>%
  filter(DWREAS == 3)

reason_failed_busin <- displ_workers %>%
  filter(DWREAS == 5)