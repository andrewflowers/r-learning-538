# Intro to dplyr

setwd("~/repos/r-learning/sessions/dplyr_1/")

require(readr)
require(dplyr)

all_elo_data <- read_csv("nbaallelo.csv")

# If needed
all_elo_data <- read_csv("nbaallelo.csv", col_types = cols( date_game = col_date("%m/%d/%y")))

# Neil's problem



all_elo_data %>% 
  filter(is_playoffs == 1 & year_id > 1999) %>% 
  group_by(fran_id, year_id) %>% 
  summarize(best_elo = max(elo_n)) %>% 
  ungroup() %>% 
  arrange(desc(best_elo)) %>% 
  left_join(all_elo_data %>% 
              select(fran_id, year_id, elo_n, date_game), 
            by = c("fran_id", "year_id",  "best_elo" = "elo_n"))

