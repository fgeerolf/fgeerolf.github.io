pklist <- c("tidyverse", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

WEO <- "https://www.imf.org/external/pubs/ft/weo/2018/02/weodata/WEOOct2018all.xls" %>%
  fread(na.strings = "n/a") %>%
  melt(id.vars = c(1:9)) %>% 
  mutate(variable = variable %>% paste %>% substr(1, 4) %>% as.numeric,
         value = value %>% as.numeric) %>%
  rename(countryname = Country, year = variable, variable = `WEO Subject Code`) %>%
  select(countryname, year, variable, value, everything()) %>%
  arrange(countryname, year) %>%
  filter(countryname != "" & !is.na(value)) %>%
  mutate(countryname = countryname %>% as.factor)

save(WEO, file = "WEO.RData")
