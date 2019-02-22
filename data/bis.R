pklist <- c("tidyverse", "curl", "readstata13", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

# long_pp ---------

curl_download("https://www.bis.org/statistics/full_bis_long_pp_csv.zip",
              destfile = "full_bis_long_pp_csv.zip",
              quiet = FALSE)

unzip('full_bis_long_pp_csv.zip')
unlink("full_bis_long_pp_csv.zip")

long_pp <- "WEBSTATS_LONG_PP_DATAFLOW_csv_col.csv" %>% 
  fread %>%
  gather(variable, value, contains("19"), contains("20")) %>%
  filter(!is.na(value)) %>%
  mutate(year = variable %>% substr(1, 4) %>% as.numeric,
         qtr = variable %>% substr(7, 7) %>% as.numeric,
         yearqtr = year + (qtr - 1)/4) %>%
  select(countryname = `Reference area`, yearqtr, HOUSE_long_pp = value)

unlink("WEBSTATS_LONG_PP_DATAFLOW_csv_col.csv")

save(long_pp, file = "long_pp.RData")

# selected_pp -------------

curl_download("https://www.bis.org/statistics/full_bis_selected_pp_csv.zip",
              destfile = "full_bis_selected_pp_csv.zip",
              quiet = FALSE)

unzip('full_bis_selected_pp_csv.zip')
unlink("full_bis_selected_pp_csv.zip")

selected_pp <- "WEBSTATS_SELECTED_PP_DATAFLOW_csv_col.csv" %>%
  fread %>%
  gather(variable, value, contains("19"), contains("20")) %>%
  filter(!is.na(value)) %>% 
  mutate(year = variable %>% substr(1, 4) %>% as.numeric,
         qtr = variable %>% substr(7, 7) %>% as.numeric,
         yearqtr = year + (qtr - 1)/4,
         variable = paste0("HOUSE_selected_pp_", VALUE, UNIT_MEASURE)) %>%
  select(countryname = `Reference area`, yearqtr, variable, value) %>%
  spread(variable, value)

unlink("WEBSTATS_SELECTED_PP_DATAFLOW_csv_col.csv")

save(selected_pp, file = "selected_pp.RData")

# total_credit ------------

curl_download("https://www.bis.org/statistics/full_bis_total_credit_csv.zip",
              destfile = "full_bis_total_credit_csv.zip",
              quiet = FALSE)

unzip('full_bis_total_credit_csv.zip')
unlink("full_bis_total_credit_csv.zip")

total_credit <- "WEBSTATS_TOTAL_CREDIT_DATAFLOW_csv_col.csv" %>%
  fread %>%
  gather(variable, value, contains("19"), contains("20")) %>%
  filter(!is.na(value)) %>% 
  mutate(year = variable %>% substr(1, 4) %>% as.numeric,
         qtr = variable %>% substr(7, 7) %>% as.numeric,
         yearqtr = year + (qtr - 1)/4,
         variable = paste0(TC_BORROWERS, TC_LENDERS, VALUATION, UNIT_TYPE, TC_ADJUST)) %>%
  select(countryname = `Borrowers' country`, yearqtr, variable, value) %>%
  spread(variable, value)

unlink("WEBSTATS_TOTAL_CREDIT_DATAFLOW_csv_col.csv")

save(total_credit, file = "total_credit.RData")

# credit_gap ------------

curl_download("https://www.bis.org/statistics/full_webstats_credit_gap_dataflow_csv.zip",
              destfile = "full_webstats_credit_gap_dataflow_csv.zip",
              quiet = FALSE)

unzip('full_webstats_credit_gap_dataflow_csv.zip')
unlink("full_webstats_credit_gap_dataflow_csv.zip")

credit_gap <- "WEBSTATS_CREDIT_GAP_DATAFLOW_csv_col.csv" %>% 
  fread %>%
  gather(variable, value, contains("19"), contains("20")) %>%
  filter(!is.na(value)) %>% 
  mutate(year = variable %>% substr(1, 4) %>% as.numeric,
         qtr = variable %>% substr(7, 7) %>% as.numeric,
         yearqtr = year + (qtr - 1)/4,
         variable = paste0(TC_BORROWERS, TC_LENDERS, CG_DTYPE)) %>%
  select(countryname = `Borrowers' country`, yearqtr, variable, value) %>%
  spread(variable, value)

unlink("WEBSTATS_CREDIT_GAP_DATAFLOW_csv_col.csv")

save(credit_gap, file = "credit_gap.RData")

# dsr ------------

curl_download("https://www.bis.org/statistics/full_bis_dsr_csv.zip",
              destfile = "full_bis_dsr_csv.zip",
              quiet = FALSE)

unzip('full_bis_dsr_csv.zip')
unlink("full_bis_dsr_csv.zip")

dsr <- "WEBSTATS_DSR_DATAFLOW_csv_col.csv" %>% 
  fread %>%
  gather(variable, value, contains("19"), contains("20")) %>%
  filter(!is.na(value)) %>% 
  mutate(year = variable %>% substr(1, 4) %>% as.numeric,
         qtr = variable %>% substr(7, 7) %>% as.numeric,
         yearqtr = year + (qtr - 1)/4,
         variable = paste0("DSR_", DSR_BORROWERS)) %>%
  select(countryname = `Borrowers' country`, yearqtr, variable, value) %>%
  spread(variable, value)

unlink("WEBSTATS_DSR_DATAFLOW_csv_col.csv")

save(dsr, file = "dsr.RData")

# cpi ------------

curl_download("https://www.bis.org/statistics/full_webstats_long_cpi_dataflow_csv.zip",
              destfile = "full_webstats_long_cpi_dataflow_csv.zip",
              quiet = FALSE)

unzip('full_webstats_long_cpi_dataflow_csv.zip')
unlink("full_webstats_long_cpi_dataflow_csv.zip")

cpi <- "WEBSTATS_LONG_CPI_DATAFLOW_csv_col.csv" %>% 
  fread %>%
  gather(variable, value, contains("16"), contains("17"), contains("18"), contains("19"), contains("20")) %>%
  filter(!is.na(value)) %>% 
  mutate(year = variable %>% substr(1, 4) %>% as.numeric,
         month = variable %>% substr(6, 7) %>% as.numeric,
         month = ifelse(is.na(month), 1, month),
         yearmonth = year + (month - 1)/12,
         variable = paste0("CPI_", FREQ, UNIT_MEASURE)) %>%
  select(countryname = `Reference area`, yearmonth, variable, value) %>%
  spread(variable, value)

unlink("WEBSTATS_LONG_CPI_DATAFLOW_csv_col.csv")

save(cpi, file = "cpi.RData")
