rm(list = ls())
pklist <- c("tidyverse", "curl", "foreign")
source("https://fgeerolf.github.io/code/load-packages.R")

# housing_supply ---------

curl_download("http://web.archive.org/web/20100619052721/http://real.wharton.upenn.edu/~saiz/SUPPLYDATA.zip", 
              destfile = "SUPPLYDATA.zip", 
              quiet = FALSE)
unzip("SUPPLYDATA.zip")
housing_supply <- read.dta("HOUSING_SUPPLY.dta")
unlink(c("HOUSING_SUPPLY.dta", "SUPPLYDATA.zip", "readme.txt"))

save(housing_supply, file = "housing_supply.RData")

# wharton_land_regulation ---------

curl_download("http://real.wharton.upenn.edu/~gyourko/WRLURI/WHARTON%20LAND%20REGULATION%20DATA_1_24_2008.zip", 
              destfile = "WHARTON LAND REGULATION DATA_1_24_2008.zip", 
              quiet = FALSE)

unzip("WHARTON LAND REGULATION DATA_1_24_2008.zip")
wharton_land_regulation <- read.dta("WHARTON LAND REGULATION DATA_1_24_2008.dta")
unlink(c("WHARTON LAND REGULATION DATA_1_24_2008.zip", "WHARTON LAND REGULATION DATA_1_24_2008.dta"))

save(wharton_land_regulation, file = "wharton_land_regulation.RData")
