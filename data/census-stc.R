pklist <- c("curl", "tidyverse")
source("http://fgeerolf.com/code/load-packages.R")

curl_download("https://www2.census.gov/programs-surveys/stc/datasets/historical/state_tax_collections.zip", 
              destfile = "state_tax_collections.zip", 
              quiet = FALSE)

unzip("state_tax_collections.zip")
unlink("state_tax_collections.zip")

census_stc  <- "STC_Historical_DB (2017).xls" %>%
  read.xls %>%
  filter(!is.na(Year)) %>%
  gather(variable, value, -Year, -State, -Name, -FY.Ending.Date) %>%
  mutate(value = gsub(",", "", value),
         value = as.numeric(value)) %>%
  mutate_at(vars(Year, State, Name, FY.Ending.Date), funs(paste(.))) %>%
  mutate_at(vars(Year, State, Name, FY.Ending.Date), funs(factor(.))) %>%
  full_join(fread("variables/variable.list.csv") %>%
              select(variable = C105, description = `Total Taxes`), 
            by = "variable") %>%
  mutate(year = as.numeric(paste(Year)),
         state = substr(paste(Name), 1, 2), 
         variable = factor(variable), 
         state = factor(state)) %>%
  select(-Year, -Name, -State, -FY.Ending.Date) %>%
  select(state, year, variable, description, value) %>%
  arrange(variable, state, year)

unlink("STC_Historical_DB (2017).xls")

save(census_stc, file = "census_stc.RData")
