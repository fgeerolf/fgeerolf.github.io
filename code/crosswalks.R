rm(list = ls())
pklist <- c("tidyverse", "curl", "fredr", "data.table", 
            "pryr", "benchmarkme", "readstata13")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

# zipcode_to_county -----------

zipcode_to_county <- "https://www2.census.gov/geo/docs/maps-data/data/rel/zcta_county_rel_10.txt" %>%
  fread %>%
  mutate(fips = STATE*1000+COUNTY) %>%
  select(zipcode = ZCTA5, fips) %>%
  arrange(zipcode)

zipcode_to_county %>% str

save(zipcode_to_county, file = "zipcode_to_county.RData")

# zipcode_CBSA -----------

curl_download(url = "https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2006/07-zip-to-06-cbsa/zip07-cbsa06.zip",
              destfile = "zip07-cbsa06.zip", 
              quiet = FALSE)
unzip("zip07-cbsa06.zip")
zipcode_CBSA <- "Documents and Settings/gardn301/My Documents/Crosswalk Tables/zip07_cbsa06.txt" %>%
  fread %>%
  select(zipcode = ZIP5, cbsa = `CBSA CODE`, cbsa_label = `CBSA TITLE`) %>%
  unique
zipcode_CBSA %>% str
unlink("Documents and Settings", recursive = TRUE)
unlink("zip07-cbsa06.zip")
save(zipcode_CBSA, file = "zipcode_CBSA.RData")
system("ls -l")

# cz_to_county ----------

curl_download(url = "https://www.ddorn.net/data/cw_cty_czone.zip",
              destfile = "cw_cty_czone.zip",
              quiet = FALSE)
unzip("cw_cty_czone.zip")
unlink("cw_cty_czone.zip")
cz_to_county <- read.dta13("cw_cty_czone.dta")
unlink("cw_cty_czone.dta")
save(cz_to_county, file = "cz_to_county.RData")


# cz_to_census_division ----------

curl_download(url = "https://www.ddorn.net/data/cw_czone_division.zip",
              destfile = "cw_czone_division.zip",
              quiet = FALSE)
unzip("cw_czone_division.zip")
unlink("cw_czone_division.zip")
cz_to_census_division <- read.dta13("cw_czone_division.dta")
unlink("cw_czone_division.dta")
save(cz_to_census_division, file = "cz_to_census_division.RData")