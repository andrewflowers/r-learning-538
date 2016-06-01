# Tidyr (with some dplyr and maybe lubridate)

setwd("~/repos/r-learning/sessions/tidyr/")

require(dplyr)
require(readr)
require(tidyr)
require(lubridate)

# Install devtools, if you need to
devtools::install_github("rstudio/EDAWR") 

# Load data
require(EDAWR)

# We're going to use three data sets: storms, cases, pollution
