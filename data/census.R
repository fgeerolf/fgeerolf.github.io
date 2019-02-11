rm(list = ls())
pklist <- c("tidyverse", "data.table", "pryr", "benchmarkme", "tidycensus")
source("https://fgeerolf.github.io/code/load-packages.R")

cat("Model:", get_cpu()$model_name, 
    "\nMemory:", round(get_ram()/2^30, digits = 3), 
    "Go\nNumber of cores:", get_cpu()$no_of_cores, 
    "\nStart: ", format(Sys.time(), "%a %b %d, %Y - %X"), "\n")

census_api_key("91493ab4bd8df8770e68c192ec0413efbcfd95ed", install = TRUE, overwrite = TRUE)

# median_gross_rent_county_1990 -------

median_gross_rent_county_1990 <- get_decennial(geography = "county", 
                                               variables = "H043A001", 
                                               year = 1990) %>%
  mutate(fips = GEOID %>% as.numeric,
         variable.desc1 = "Median Gross Rent",
         date = 1990) %>%
  select(variable, variable.desc1, fips, date, value)

save(median_gross_rent_county_1990, file = "median_gross_rent_county_1990.RData")

# median_gross_rent_county_2000 -------

median_gross_rent_county_2000 <- get_decennial(geography = "county", 
                                               variables = "H063001", 
                                               year = 2000) %>%
  mutate(fips = GEOID %>% as.numeric,
         variable.desc1 = "Median gross rent Specified renter-occupied housing",
         date = 2000) %>%
  select(variable, variable.desc1, fips, date, value)

save(median_gross_rent_county_2000, file = "median_gross_rent_county_2000.RData")

# characteristics_county -------

characteristics_county <- get_acs(geography = "county", 
                                  variables = c("B25090_001",
                                                "B19013_001",
                                                "B25103_001")) %>%
  mutate(variable.desc1 = "",
         variable.desc1 = ifelse(variable == "B19013_001", "Median Income", variable.desc1),
         variable.desc1 = ifelse(variable == "B25090_001", "Aggregate Taxes Paid", variable.desc1),
         variable.desc1 = ifelse(variable == "B25103_001", "Property Taxes Paid", variable.desc1)) %>%
  mutate(fips = GEOID %>% as.numeric,
         date = 2017) %>%
  select(variable, variable.desc1, fips, date, value = estimate)

save(characteristics_county, file = "characteristics_county.RData")

# characteristics_places -------

characteristics_places <- get_acs(geography = "metropolitan statistical area/micropolitan statistical area", 
                                  variables = c(aggregate.taxes.paid = "B25090_001",
                                                medincome = "B19013_001",
                                                property = "B25103_001"))

save(characteristics_places, file = "characteristics_places.RData")

# characteristics_places -------

characteristics_csa <- get_acs(geography = "combined statistical area", 
                               variables = c(aggregate.taxes.paid = "B25090_001",
                                             medincome = "B19013_001",
                                             property = "B25103_001"))

save(characteristics_csa, file = "characteristics_csa.RData")
