pack.fun <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]; 
  if (length(new.pkg)) install.packages(new.pkg, dependencies = TRUE, repos='http://cran.us.r-project.org'); 
  sapply(pkg, require, character.only = TRUE)
}

if (exists("pklist")) pack.fun(pklist); rm(pklist,pack.fun)
