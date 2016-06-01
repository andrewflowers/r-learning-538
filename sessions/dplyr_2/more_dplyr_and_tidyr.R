# More dplyr and intro to tidyr

setwd("~/repos/r-learning/sessions/dplyr_2/")

require(readr)
require(dplyr)

all_elo_data <- read_csv("nbaallelo.csv")

all_elo_data %>% 
  select(date_game, fran_id, opp_id)

# If needed
all_elo_data <- read_csv("nbaallelo.csv", col_types = cols( date_game = col_date("%m/%d/%y")))



# Neil's problem

best_team_elo_99 <- all_elo_data %>% 
  filter(is_playoffs == 1 & year_id > 1999) %>% 
  group_by(fran_id, year_id) %>% 
  summarize(best_elo = max(elo_n)) 

best_team_elo_99 %>% 
  right_join(all_elo_data, 
            by = c("fran_id", "year_id",  "best_elo" = "elo_n"))

