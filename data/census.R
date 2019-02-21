pklist <- c("tidyverse", "data.table", "tidycensus")
source("https://fgeerolf.github.io/code/load-packages.R")

census_api_key("91493ab4bd8df8770e68c192ec0413efbcfd95ed",
               install = TRUE,
               overwrite = TRUE)

# Intercensus

housing_units_00_10 <- "https://www2.census.gov/programs-surveys/popest/datasets/2000-2010/intercensal/housing/hu-est00int-tot.csv" %>%
  fread %>%
  filter(!is.na(COUNTY)) %>%
  mutate(fips = STATE*1000 + COUNTY) %>%
  select(fips, contains("HUEST_")) %>%
  gather(variable, value, -fips) %>%
  mutate(year = gsub("HUEST_", "", variable) %>% as.numeric) %>%
  select(fips, year, value)

save(housing_units_00_10, file = "housing_units_00_10.RData")

# variables_1990 -------

variables_1990 <- load_variables(1990, "sf3", cache = TRUE)

save(variables_1990, file = "variables_1990.RData")

# variables_2000 -------

variables_2000 <- load_variables(2000, "sf3", cache = TRUE)

save(variables_2000, file = "variables_2000.RData")

# variable_list_5_year_acs_2016 -------

variable_list_5_year_acs_2016 <- load_variables(2016, "acs5", cache = TRUE)

save(variable_list_5_year_acs_2016, file = "variable_list_5_year_acs_2016.RData")

# variable_list_5_year_acs_2010 -------

variable_list_5_year_acs_2010 <- load_variables(2010, "acs5", cache = TRUE)

save(variable_list_5_year_acs_2010, file = "variable_list_5_year_acs_2010.RData")

# variable_list_5_year_acs_2010 -------
# Median Gross Rent as a Percentage of Household Income --------


median_rent_percentage_zcta_2016 <- get_acs(geography = "zip code tabulation area", 
                                              variables = "B25071_001",
                                              geometry = FALSE) %>%
  mutate(GEOID = GEOID %>% as.numeric,
         variable.desc1 = "Rent as a Percentage of Household Income",
         date = 2016)

save(median_rent_percentage_zcta_2016, file = "median_rent_percentage_zcta_2016.RData")


# Median Gross Rent as a Percentage of Household Income --------

median_rent_percentage_county_2016 <- get_acs(geography = "county", 
                                            variables = "B25071_001",
                                            geometry = FALSE) %>%
  mutate(GEOID = GEOID %>% as.numeric,
         variable.desc1 = "Rent as a Percentage of Household Income",
         date = 2016)

save(median_rent_percentage_county_2016, file = "median_rent_percentage_county_2016.RData")

# median_gross_rent_county_1990 -------

median_gross_rent_county_1990 <- get_decennial(geography = "county", 
                                               variables = "H043A001", 
                                               year = 1990) %>%
  mutate(fips = GEOID %>% as.numeric,
         variable.desc1 = "Median Gross Rent",
         date = 1990) %>%
  select(variable, variable.desc1, fips, date, value)

save(median_gross_rent_county_1990, file = "median_gross_rent_county_1990.RData")

# median_gross_rent_place_1990 -------

median_gross_rent_place_1990 <- get_decennial(geography = "place", 
                                               variables = "H043A001", 
                                               year = 1990) %>%
  mutate(GEOID = GEOID %>% as.numeric,
         variable.desc1 = "Median Gross Rent",
         date = 1990)

save(median_gross_rent_place_1990, file = "median_gross_rent_place_1990.RData")

# median_gross_rent_place_1990 -------

median_gross_rent_place_2000 <- get_decennial(geography = "place", 
                                              variables = "H063001", 
                                              year = 2000) %>%
  mutate(GEOID = GEOID %>% as.numeric,
         variable.desc1 = "Median Gross Rent",
         date = 2000)

save(median_gross_rent_place_2000, file = "median_gross_rent_place_2000.RData")

# median_gross_rent_county_2000 -------

median_gross_rent_county_2000 <- get_decennial(geography = "county", 
                                               variables = "H063001", 
                                               year = 2000) %>%
  mutate(fips = GEOID %>% as.numeric,
         variable.desc1 = "Median gross rent Specified renter-occupied housing",
         date = 2000) %>%
  select(variable, variable.desc1, fips, date, value)

save(median_gross_rent_county_2000, file = "median_gross_rent_county_2000.RData")


# median_gross_rent_place_2000 -------

median_gross_rent_place_2000 <- get_decennial(geography = "place", 
                                               variables = "H063001", 
                                               year = 2000) %>%
  mutate(fips = GEOID %>% as.numeric,
         variable.desc1 = "Median gross rent Specified renter-occupied housing",
         date = 2000) %>%
  select(variable, variable.desc1, fips, date, value)

save(median_gross_rent_place_2000, file = "median_gross_rent_place_2000.RData")


# characteristics_county -------

characteristics_county <- get_acs(geography = "county", 
                                  variables = c(aggregate.taxes.paid = "B25090_001",
                                                medincome = "B19013_001",
                                                property = "B25103_001",
                                                median.rent = "B25031_001",
                                                median.rent.2 = "B25063_001",
                                                median.gross.rent = "B25064_001")) %>%
  select(GEOID, NAME, variable, value = estimate) %>%
  spread(variable, value) %>%
  mutate(rent_share = median.rent*12/medincome)

save(characteristics_county, file = "characteristics_county.RData")

# characteristics_places -------

characteristics_places <- get_acs(geography = "metropolitan statistical area/micropolitan statistical area", 
                                  variables = c(aggregate.taxes.paid = "B25090_001",
                                                medincome = "B19013_001",
                                                property = "B25103_001",
                                                median.rent = "B25031_001",
                                                median.rent.2 = "B25063_001",
                                                median.gross.rent = "B25064_001")) %>%
  select(GEOID, NAME, variable, value = estimate) %>%
  spread(variable, value) %>%
  mutate(rent_share = median.rent*12/medincome)

save(characteristics_places, file = "characteristics_places.RData")

# characteristics_places -------

characteristics_csa <- get_acs(geography = "combined statistical area", 
                               variables = c(aggregate.taxes.paid = "B25090_001",
                                             medincome = "B19013_001",
                                             property = "B25103_001",
                                             median.rent = "B25031_001",
                                             median.rent.2 = "B25063_001",
                                             median.gross.rent = "B25064_001")) %>%
  select(GEOID, NAME, variable, value = estimate) %>%
  spread(variable, value) %>%
  mutate(rent_share = median.rent*12/medincome)

save(characteristics_csa, file = "characteristics_csa.RData")
