pklist <- c("curl", "tidyverse", "rvest", "data.table", "benchmarkme")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name,
    "\nMemory:", round(get_ram()/2^30, digits = 3),
    "Go\nNumber of cores:", get_cpu()$no_of_cores,
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

curl_download("https://www.imf.org/external/pubs/ft/weo/2018/02/weodata/WEOOct2018all.xls", 
              destfile = "WEOOct2018all.xls",
              quiet = FALSE)

system("ssconvert WEOOct2018all.xls WEOOct2018all.csv")

WEO <- "WEOOct2018all.csv" %>%
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

file.remove(c("WEOOct2018all.csv", "WEOOct2018all.xls"))
