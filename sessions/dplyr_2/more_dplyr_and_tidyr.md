More dplyr and introduction to tidyr
========================================================
author: Andrew Flowers
date: Wed., May 25, 2016
autosize: true
font-family: 'Helvetica'
autosize: TRUE

Goals for R Learning Group
========================================================

- Hands-on 
- Complete beginners welcome
- No dumb questions
- 1 hour or less
- Gradually learn more R

Outline for today's session
========================================================
- Review dplyr (~ 20-30 min.)
  - Install dplyr, load NBA Elo data 
  - Pipe operator (%>%)
  - filter()
  - select()
  - mutate()
  - group_by() and summarize()
  - arrange()
- Advanced dplyr
  - distinct()
  - rename()
  - left_join() and other join functions
  - Hands-on project:
- Introduction to tidyr
  - gather()
  - spread()

Installing and Loading Packages. Install dplyr!
========================================================
- Let's load the following package: readr
- To install an R package: 
  + Use install.packages() command **with package name in quotes**

```r
install.packages("dplyr")
```
- To load an R package: 
  + Use require() or library() command **don't need to put the package name in quotes, but you can**

```r
require("dplyr")
# or
library("dplyr")
```
Load NBA Elo data, explore it
========================================================
#### Historical data on all NBA games
- GitHub repo: https://github.com/fivethirtyeight/nba-elo 
#### To load the csv file, use the read_csv() function from the readr package

```r
library(readr)
all_elo_data <- read_csv("nbaallelo.csv")
```
#### Useful functions for understanding this data

```r
dim(all_elo_data)

names(all_elo_data)

summary(all_elo_data)

str(all_elo_data)
```
#### Pipe operator: %>%
- dplyr has several function that can be **chained** together with the %>% operator
- Shortcut key for Macs: **Command + Shift + M**

filter() -- filter the rows you'd like (1/2)
========================================================
### Let's look at games from 2014-2015 season

```r
# Without the pipe operator
filter(all_elo_data, year_id==2015)

# With pipe operator
all_elo_data %>% filter(year_id==2015)
```
### Using the pipe operator to chain commands read more elegantly

```r
all_elo_data %>% filter(year_id==2015) %>% head()
```

```
Source: local data frame [6 x 11]

       game_id lg_id year_id  date_game is_playoffs   fran_id   pts
         (chr) (chr)   (int)      (chr)       (int)     (chr) (int)
1 201410280LAL   NBA    2015 10/28/2014           0   Rockets   108
2 201410280LAL   NBA    2015 10/28/2014           0    Lakers    90
3 201410280NOP   NBA    2015 10/28/2014           0  Pelicans   101
4 201410280NOP   NBA    2015 10/28/2014           0     Magic    84
5 201410280SAS   NBA    2015 10/28/2014           0     Spurs   101
6 201410280SAS   NBA    2015 10/28/2014           0 Mavericks   100
Variables not shown: elo_i (dbl), elo_n (dbl), opp_id (chr), opp_pts (int)
```
filter() -- filter the rows you'd like (2/2)
========================================================
### Can also use specific id variables, and other operators 

```r
# Lakers
all_elo_data %>% filter(fran_id == 'Lakers')

# Just the playoffs
all_elo_data %>% filter(is_playoffs == 1)

# Since 2000
all_elo_data %>% filter(year_id >= 2000)

# Opponent was NOT the Lakers
all_elo_data %>% filter(opp_id != 'Lakers')

# Year is 1996 and team is the Bulls
all_elo_data %>% filter(fran_id == 'Bulls' & year_id == 1996)

# Either team scored over 100 points
all_elo_data %>% filter(pts >= 100 | opp_pts >= 100)
```
### Important fresher on operators
 +  ==, !=
 + >, <, >=, <=
 + &, |

select() -- filter the columns you'd like
========================================================
### There are several ways to select columns

```r
# Without the pipe operator
select(all_elo_data, date_game, fran_id, opp_id)

# With pipe operator
all_elo_data %>% 
  select(date_game, fran_id, opp_id)

## Notice that with the pipe operator, you can move to the next line

# First 5 columns
all_elo_data %>% 
  select(1:5)

# All columns but the second one
all_elo_data %>% 
  select(-2)

# Columns from pts to opp_pts
all_elo_data %>% 
  select(pts:opp_pts)
```
mutate() -- create a new column
========================================================
### Mutate is useful for creating new variables, or changing existing ones

```r
# Without the pipe operator
mutate(all_elo_data, pts_diff = pts - opp_pts)

# With pipe operator
all_elo_data %>% 
  mutate(pts_diff = pts - opp_pts)

## NOTE: you can assign the manipulated data to a data frame
more_elo_data <- all_elo_data %>% 
  mutate(pts_diff = pts - opp_pts)

View(more_elo_data)

# Mutate can do more multiple changes at once
more_elo_data %>% 
  mutate(abs_pts_diff = abs(pts - opp_pts),
         total_pts = sum(pts, opp_pts))

# Mutate can also do more complex calcualtions
more_elo_data %>% 
  mutate(winner = ifelse(pts > opp_pts, fran_id, opp_id))

# Overwrite fran_id to be lower-case
more_elo_data %>% 
  mutate(fran_id = tolower(fran_id))

rm(more_elo_data) # This removes the data frame for our environment
```
group_by()/summarize() -- Pivot tables but better
========================================================
### Let's try to find each franchise's best Elo rating

```r
# Using pipe operator
all_elo_data %>% 
  group_by(fran_id) %>% 
  summarize(best_Elo = max(elo_i))

# You can group_by multiple variables
# Let's look at each franchise's best Elo rating BY YEAR

all_elo_data %>% 
  group_by(year_id, fran_id) %>% 
  summarize(best_Elo = max(elo_i))
```
## Use arrange() to sort data

```r
# Sort by lowest Elo
all_elo_data %>% 
  group_by(fran_id) %>% 
  summarize(best_Elo = max(elo_i)) %>% 
  arrange(best_Elo)

# Sort by highest using desc() wrapper
all_elo_data %>% 
  group_by(fran_id) %>% 
  summarize(best_Elo = max(elo_i)) %>% 
  arrange(desc(best_Elo))
```
distinct() -- Isolate unique rows
========================================================
### Let's try to distinct rows

```r
# Using pipe operator
all_elo_data %>% 
  distinct(fran_id) 
```
