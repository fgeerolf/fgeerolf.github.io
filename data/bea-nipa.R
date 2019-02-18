pklist <- c("tidyverse", "lubridate", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

# nipa_series -----

nipa_series <- "https://bea.gov/national/Release/TXT/SeriesRegister.txt" %>%
  fread(col.names = c("seriescode", "serieslabel", "metricname",
                      "calculationtype", "defaultscale", "tableid",
                      "seriescodeparents"))

save(nipa_series, file = "nipa_series.RData")

# nipa -----

nipa <- "https://bea.gov/national/Release/TXT/NipaDataQ.txt" %>%
  fread(col.names = c("seriescode", "period", "value")) %>%
  mutate(value = value %>% gsub(",", "", .) %>% as.numeric,
         year = period %>% substr(1, 4) %>% as.numeric,
         qtr = period %>% substr(6, 6) %>% as.numeric,
         yearqtr = year + (qtr - 1)/4) %>%
  left_join(nipa_series %>%
              select(seriescode, variable.desc1 = serieslabel, variable.desc2 = metricname, 
                     variable.desc3 = calculationtype, variable.desc4 = tableid),
            by = "seriescode") %>%
  select(variable = seriescode, contains("variable.desc"), yearqtr, value)

save(nipa, file = "nipa.RData")

# nipa_annual -----

nipa_annual <- "https://bea.gov/national/Release/TXT/NipaDataA.txt" %>%
  fread(col.names = c("seriescode", "period", "value")) %>%
  mutate(value = value %>% gsub(",", "", .) %>% as.numeric,
         year = period %>% substr(1, 4) %>% as.numeric) %>%
  left_join(nipa_series %>%
              select(seriescode, variable.desc1 = serieslabel, variable.desc2 = metricname, 
                     variable.desc3 = calculationtype, variable.desc4 = tableid),
            by = "seriescode") %>%
  select(variable = seriescode, contains("variable.desc"), year, value)

save(nipa_annual, file = "nipa_annual.RData")
