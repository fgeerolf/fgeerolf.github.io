pklist <- c("tidyverse", "curl", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

curl_download(url = "http://databank.worldbank.org/data/download/WDI_csv.zip", 
              destfile = "WDI_csv.zip", 
              quiet = FALSE)

unzip("WDI_csv.zip")
unlink("WDI_csv.zip")

# WDI ------------

WDI <- "WDIData.csv" %>%
  fread(header = TRUE) %>%
  rename(Country.Name = `Country Name`, Country.Code = `Country Code`,
         Indicator.Name = `Indicator Name`, Indicator.Code = `Indicator Code`) %>%
  gather(year, value, -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code) %>%
  mutate(year = year %>% substr(2, 5) %>% as.numeric) %>%
  filter(!is.na(value))

save(WDI, file = "WDI.RData")

# WDI.series ------------

WDI.series <- 'WDISeries.csv' %>%
  fread

save(WDI.series, file = "WDI.series.RData")

# WDI.country ------------

WDI.country <- "WDICountry.csv" %>%
  fread

save(WDI.country, file = "WDI.country.RData")

# WDI.variable.nobs ------------

WDI.variable.nobs <- WDI %>%
  group_by(Indicator.Name, Indicator.Code) %>%
  summarise(nobs = sum(!is.na(value))) %>%
  ungroup %>%
  select(Indicator.Code, Indicator.Name, nobs) %>%
  mutate(Indicator.Code = Indicator.Code %>% paste %>% as.character,
         Indicator.Name = Indicator.Name %>% paste %>% as.character) %>%
  arrange(Indicator.Code) %>%
  unique

save(WDI.variable.nobs, file = "WDI.variable.nobs.RData")

unlink(list.files(pattern = "\\.csv$"))
