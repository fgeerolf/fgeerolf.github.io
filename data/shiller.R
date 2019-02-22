pklist <- c("tidyverse", "gdata")
source("http://fgeerolf.com/code/load-packages.R")

# shiller -----------

shiller <- "http://www.econ.yale.edu/~shiller/data/ie_data.xls" %>%
  read.xls(skip = 6) %>%
  head(-1) %>% # remove last obs
  mutate_all(as.numeric) %>%
  mutate(year = Date %>% round,
         month = ((Date - year)*100) %>% round,
         date = paste0(year, "-", str_pad(month, 2, pad = "0"), "-01") %>% as.Date) %>%
  select(-year, -month, -Date) %>%
  select(date, everything())

save(shiller, file = "shiller.RData")
