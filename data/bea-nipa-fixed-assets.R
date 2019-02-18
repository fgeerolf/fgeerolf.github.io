pklist <- c("tidyverse", "lubridate", "data.table")
source("http://fgeerolf.com/code/load-packages.R")

# nipa_fixed_asset_series -----

nipa_fixed_asset_series <- "https://apps.bea.gov/national/FixedAssets/Release/TXT/SeriesRegister.txt" %>%
  fread %>%
  rename(variable = `%SeriesCode`)

save(nipa_fixed_asset_series, file = "nipa_fixed_asset_series.RData")

# nipa_fixed_asset -----

nipa_fixed_asset <- "https://apps.bea.gov/national/FixedAssets/Release/TXT/FixedAssets.txt" %>%
  fread %>%
  rename(variable = `%SeriesCode`, year = Period, value = Value) %>%
  mutate(value = value %>% paste %>% as.numeric) %>%
  filter(!is.na(value))

save(nipa_fixed_asset, file = "nipa_fixed_asset.RData")
