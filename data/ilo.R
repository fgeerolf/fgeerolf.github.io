pklist <- c("tidyverse", "data.table", "R.utils")
source("http://fgeerolf.com/code/load-packages.R")

# List Datasets ---------

datasets <- "https://www.ilo.org/ilostat-files/WEB_bulk_download/indicator/table_of_contents_en.csv" %>%
  fread

save(datasets, file = "datasets.RData")

# Example 1 ---------

data_manuf <- "https://www.ilo.org/ilostat-files/WEB_bulk_download/indicator/EMP_TSRV_NOC_RT_A.csv.gz" %>%
  fread

save(data_manuf, file = "data_manuf.RData")

# Example 2 ----------

data_unemp <- "https://www.ilo.org/ilostat-files/WEB_bulk_download/indicator/UNE_TUNE_SEX_AGE_DUR_NB_Q.csv.gz" %>%
  fread

save(data_unemp, file = "data_unemp.RData")
