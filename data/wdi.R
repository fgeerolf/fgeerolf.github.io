pklist <- c("tidyverse", "data.table", "benchmarkme", "pryr", "R.utils")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name,
    "\nMemory:", round(get_ram()/2^30, digits = 3),
    "Go\nNumber of cores:", get_cpu()$no_of_cores,
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

"http://databank.worldbank.org/data/download/WDI_csv.zip" %>%
  curl_download(url = ., 
                destfile = "WDI_csv.zip", 
                quiet = FALSE, mode = "wb")

unzip("WDI_csv.zip")
unlink("WDI_csv.zip")

WDI <- "WDIData.csv" %>%
  fread(header = TRUE) %>%
  rename(Country.Name = `Country Name`, Country.Code = `Country Code`,
         Indicator.Name = `Indicator Name`, Indicator.Code = `Indicator Code`) %>%
  gather(year, value, -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code) %>%
  mutate(year = year %>% substr(2, 5) %>% as.numeric) %>%
  filter(!is.na(value))

WDI.series <- 'WDISeries.csv' %>%
  fread

WDI.country <- "WDICountry.csv" %>%
  fread

WDI.variable.nobs <- WDI %>%
  group_by(Indicator.Name, Indicator.Code) %>%
  summarise(nobs = sum(!is.na(value))) %>%
  ungroup %>%
  select(Indicator.Code, Indicator.Name, nobs) %>%
  mutate(Indicator.Code = Indicator.Code %>% paste %>% as.character,
         Indicator.Name = Indicator.Name %>% paste %>% as.character) %>%
  arrange(Indicator.Code) %>%
  unique

save(WDI, file = "WDI.RData")
save(WDI.series, file = "WDI.series.RData")
save(WDI.country, file = "WDI.country.RData")
save(WDI.variable.nobs, file = "WDI.variable.nobs.RData")

unlink(list.files(pattern = "\\.csv$"))
