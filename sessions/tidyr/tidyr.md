Tidyr (with some dplyr and maybe lubridate)
========================================================
author: Andrew Flowers
date: Wed., June 1, 2016
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
- First, install EDAWR package **from GitHub**
  - Type this: devtools::install_github("rstudio/EDAWR") 
- Introduction to tidyr
  - Why use tidyr? What is "tidy data?"
  - gather()
  - spread()
  - separate()
  - unite()
  - Hands-on problem
- Joining data with dplyr
  - left_join() 
  - right_join()
  - inner_join() 
  - full_join()
  - Filtering joins
  - Hands-on problem
- Lubridate
 - ymd()/mdy()/dmy()
 - year()/month()/day()

Why use tidyr? What is tidy data?
========================================================
- tidyr is great because:
  + It's a powerful tool to **reshape** your data
  + It's integral to using ggplot2 for making charts
- What is "Tidy Data?"
  + The idea structure to work well with R
  + Each variable has its own column
  + Each row contains a single observations
  + **Read Hadley Wickham's paper "Tidy Data"**

Install dplyr and tidyr
========================================================
- Let's load dplyr and tidyr
- To install an R package: 
  + Use install.packages() command **with package name in quotes**

```r
install.packages("tidyr")
```
- To load an R package: 
  + Use require() or library() command **don't need to put the package name in quotes, but you can**

```r
require("tidyr")
# or
library("tidyr")
```

gather()
========================================================
#### What does gather do?
- It moves data from wide --> long
- Like the "melt" function from the package reshape2
- Goes from rectangular format to a key-value format

#### Let's use the toy data set "cases"

```r
library(tidyr)
library(dplyr)
library(EDAWR)
cases
```

```
  country  2011  2012  2013
1      FR  7000  6900  7000
2      DE  5800  6000  6200
3      US 15000 14000 13000
```
#### What's not tidy about this data?
- The country variable is on each row, not its own column; so let's gather it into key-value pairs
- **gather( [dataset], [key-column], [value-column], [columns-to-gather])**

```r
# Without pipes
gather(cases, country, year, 2:4)

# Or with pipes
cases %>% gather(country, year, 2:4)   
```
spread()
========================================================
#### What does spread do?
- It moves data from long --> wide
- Like the "cast" function from the package reshape2
- Goes from a key-value format to rectangular format

#### Let's use the toy data set "pollution"

```r
pollution
```

```
      city  size amount
1 New York large     23
2 New York small     14
3   London large     22
4   London small     16
5  Beijing large    121
6  Beijing small     56
```
#### What if you want multiple columns for a variable?
- Let's try this with the size variable. 
- **spread( [dataset], [key-column], [value-column])**

```r
# Without pipes
spread(pollution, size, amount)

# Or with pipes
pollution %>% spread(size, amount)
```
separate()
========================================================
#### What does spread do?
- Splits a single column into multiple columns

#### Let's use the toy data set "storms"

```r
storms
```

```
Source: local data frame [6 x 4]

    storm  wind pressure       date
    (chr) (int)    (int)     (date)
1 Alberto   110     1007 2000-08-03
2    Alex    45     1009 1998-07-27
3 Allison    65     1005 1995-06-03
4     Ana    40     1013 1997-06-30
5  Arlene    50     1010 1999-06-11
6  Arthur    45     1010 1996-06-17
```
#### What if you want to split date to multiple columns?
- **separate( [dataset], [column-to-separate], [new-column-names-IN-QUOTES], sep=[separator])**

```r
# Without pipes
separate(storms, date, c("year", "month", "day"), sep = "-")

# Saved, with pipes
storms2 <- storms %>% separate(date, c("year", "month", "day"), sep = "-")
```
unite()
========================================================
#### What does unite do?
- Unites multiple columns into a single column

#### Let's use our new data set "storms2"

```r
storms2 <- storms %>% separate(date, c("year", "month", "day"), sep = "-")
storms2
```

```
Source: local data frame [6 x 6]

    storm  wind pressure  year month   day
    (chr) (int)    (int) (chr) (chr) (chr)
1 Alberto   110     1007  2000    08    03
2    Alex    45     1009  1998    07    27
3 Allison    65     1005  1995    06    03
4     Ana    40     1013  1997    06    30
5  Arlene    50     1010  1999    06    11
6  Arthur    45     1010  1996    06    17
```
#### What if you want to create one date column?
- **unite( [dataset], [new-column-name-IN-QUOTES], [columns-to-unite], sep=[separator])**

```r
# Without pipes
unite(storms2, "date", year, month, day, sep = "/")

# Or with pipes
storms2 %>% unite("date", year, month, day, sep = "/")
```

left_join()
========================================================
#### Need to join two data sets?
- Like SQL, dplyr offers several join functions
- left_join() joins two data sets, according to the left data set

### Let's use the toy data sets songs and artists

```r
songs
```

```
                 song  name
1 Across the Universe  John
2       Come Together  John
3      Hello, Goodbye  Paul
4           Peggy Sue Buddy
```

```r
artists
```

```
    name  plays
1 George  sitar
2   John guitar
3   Paul   bass
4  Ringo  drums
```
#### How left_join works:
- **left_join( [dataset1], [dataset2], by=[column-or-columns-to-join-by])**

```r
left_join(songs, artists, by = "name")

left_join(artists, songs, by = "name")
```
right_join()
========================================================
### right_join() is just the compliment of left_join()

```r
songs
```

```
                 song  name
1 Across the Universe  John
2       Come Together  John
3      Hello, Goodbye  Paul
4           Peggy Sue Buddy
```

```r
artists
```

```
    name  plays
1 George  sitar
2   John guitar
3   Paul   bass
4  Ringo  drums
```
#### How right_join works:
- **right_join( [dataset1], [dataset2], by=[column-or-columns-to-join-by])**

```r
right_join(songs, artists, by = "name")

right_join(artists, songs, by = "name")
```
inner_join() and full_join()
========================================================
- full_join() adds all rows, regardless of matching, including NA's
- inner_join() only joins rows that match

```r
songs
```

```
                 song  name
1 Across the Universe  John
2       Come Together  John
3      Hello, Goodbye  Paul
4           Peggy Sue Buddy
```

```r
artists
```

```
    name  plays
1 George  sitar
2   John guitar
3   Paul   bass
4  Ringo  drums
```
#### They both work similarly:
- **inner_join( [dataset1], [dataset1], by=[column-or-columns-to-join-by])**

```r
inner_join(songs, artists, by = "name")

full_join(artists, songs, by = "name")
```

semi_join() and anti_join()
========================================================
### semi_join() and anti_join() don't join data, they filter it
- semi_join() returns rows that matched
- anti_join() returns rows that DID NOT match

```r
songs
```

```
                 song  name
1 Across the Universe  John
2       Come Together  John
3      Hello, Goodbye  Paul
4           Peggy Sue Buddy
```

```r
artists
```

```
    name  plays
1 George  sitar
2   John guitar
3   Paul   bass
4  Ringo  drums
```
#### They both work similarly:
- **inner_join( [dataset1], [dataset1], by=[column-or-columns-to-join-by])**

```r
semi_join(songs, artists, by = "name")

anti_join(artists, songs, by = "name")
```
