pklist <- c("tidyverse", "lubridate", "data.table", "curl")
source("http://fgeerolf.com/code/load-packages.R")

# z1_csv_files.zip -----

curl_download("https://www.federalreserve.gov/releases/z1/20180607/z1_csv_files.zip", 
              "z1_csv_files.zip", 
              quiet = FALSE)

unzip("z1_csv_files.zip")

# nipa -----

frb_z1 <- data_frame(filename = dir("csv", pattern = "*.csv")) %>%
  mutate(data = map(filename, ~ read_csv(file.path("csv", .)) %>%
                      gather(series, value, -date) %>%
                      filter(value != "ND") %>%
                      mutate(date = date %>% as.character,
                             value = value %>% as.numeric,
                             series = series %>% as.character))) %>%
  # Dataframe of tibbles to Dataframe
  unnest %>%
  # Remove duplicates
  mutate(series = series %>% substr(1, 13)) %>%
  unique %>%
  # Factor: all but value
  arrange(filename, series, date) %>%
  mutate_at(vars(-value), funs(as.factor))

save(frb_z1, file = "frb_z1.RData")

# nipa_annual -----

frb_z1_list <- data_frame(filename = dir("data_dictionary", pattern = "*.txt")) %>%
  mutate(data = map(filename, ~ read.delim(file.path("data_dictionary", .), header = FALSE) %>%
                      mutate_all(paste))) %>%
  unnest %>%
  rename(series = V1, series.title = V2, pos = V3, title = V4, unit = V5) %>%
  unique

save(frb_z1_list, file = "frb_z1_list.RData")

# Clean ----

unlink("z1_csv_files.zip")
unlink("csv", recursive = TRUE)
unlink("data_dictionary", recursive = TRUE)
