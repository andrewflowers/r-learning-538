R Basics
========================================================
author: Andrew Flowers
date: Wed., May 4, 2016
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

- Review
  + Working directories
  + Installing and loading packages
  + Importing data into RStudio
- Understanding your data
- Subsetting

Working directories (1/2)
========================================================
### "We all need a place to call home"
  - Your working directory is the folder location out of which you're working
  - Use the getwd() command to display your current working directory

```r
getwd()
```

```
[1] "/Users/flowersa/repos/r-learning/sessions/r-basics"
```
- Note: R commands often have a parenthesis "()"" where you input arguments

### Make sure you've set your working directory correctly
- Use the setwd() command to set your working directory

```r
setwd("/Users/flowersa/repos/r-learning")
```

```r
setwd("/Users/flowersa/repos/r-learning/sessions/intro-to-R-and-RStudio/")
```
Working directories (2/2)
========================================================
### Display the files in your current working directory
- Use the list.files() command

```r
list.files()
```

```
[1] "police_killings.csv" "r-basics-figure"     "r-basics.Rpres"     
```
- Side note: dir() command does the same thing

```r
dir()
```

```
[1] "police_killings.csv" "r-basics-figure"     "r-basics.Rpres"     
```
Important notes (1/2)
========================================================
### R has a weird-looking "assignment operator"

```r
x <- 1
x
```

```
[1] 1
```

```r
x = 2
x
```

```
[1] 2
```
### While the "=" symbol works, please use "<-"
 - Short-cut for Mac (two keys): "alt/option" + "-"
Important notes (2/2)
========================================================
### Commenting
- Use the # sign for commenting
- Commenting is text or code that you do NOT want R to run

```r
# This will not print
# print("hello world")
```

```r
# This will print
print("hello world")
```

```
[1] "hello world"
```
- Make sure to comment you code so you can understand it later

### Tab completion
- When typing, hit "Tab" and RStudio will suggest completed commands for you

### The RStudio console is not responding. What do I do?
- Hit the "Esc" key 

```r
# Example of getting stuck
print("hello world"
```

Installing and Loading Packages
========================================================
- Let's load the following package: readr
- To install an R package: 
  + Use install.packages() command **with package name in quotes**

```r
install.packages("readr")
```
- To load an R package: 
  + Use require() or library() command **with the bare, unquoted package name**

```r
require("readr")
# or
library("readr")
```
  
Police killings data
========================================================
#### Police killings data set
- Used by Ben in a story last June
- GitHub repo: https://github.com/fivethirtyeight/data/tree/master/police-killings  

#### To load the csv file, use the read_csv() function from the readr package

```r
police_killings <- read_csv("police_killings.csv")
```

Functions for understanding your data (1/2)
========================================================

- str() means "structure" -- gives you a description of the variables

```r
str(police_killings)
```
- dim() tells you the dimensions of your data

```r
dim(police_killings)
```
- ncol() and nrow() return how many columns and rows are in the DataFrame

```r
ncol(police_killings)
nrow(police_killings)
```
- length() returns the length of a vector (or the columns of a DataFrame)

```r
length(police_killings)
sample_vector <- c('a', 'b', 'c', 'd')
length(sample_vector)
```
Functions for understanding your data (2/2)
========================================================
- head() and tail() show you the top and bottom rows (deafult is 5)

```r
head(police_killings)
tail(police_killings, 2)
```
- names() produces a list of your DataFrame's columns

```r
names(police_killings)
```
- summary() produces a statistical summary of each variable

```r
summary(police_killings)
```
- View() displays the data in the RStudio viewer (can also click on data in Environment tab)

```r
View(police_killings)
```
Selecting columns in a data frame
========================================================
### How do you pick out a specific column of a DataFrame?
- Use the "$" operator
  + If your data is DataFrame, and the column is Column, then select it like this: DataFrame$Column
- For instance:

```r
police_killings$name
```
- To understand the structure of the "name" column, do this:

```r
str(police_killings$name)
```

```
 chr [1:467] "A'donte Washington" "Aaron Rutledge" "Aaron Siler" ...
```
- To create a summary of the county_income column, do this:

```r
summary(police_killings$county_income)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  22540   43800   50860   52530   56830  110300 
```

Useful analysis functions
========================================================

- table() give you a the breakdown for a variable

```r
table(police_killings$state)
```

```

AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO 
 2  8  4 25 74 12  1  1  2 29 16  4  2  4 11  8  6  7 11  5 10  1  9  6 10 
MS MT NC NE NH NJ NM NV NY OH OK OR PA SC TN TX UT VA WA WI WV WY 
 6  2 10  6  1 11  5  3 14 10 22  8  7  9  6 46  5  9 11  5  2  1 
```
- sort() does just that (default is decreasing = F)

```r
head(sort(police_killings$county_income))
tail(sort(police_killings$county_income))
head(sort(police_killings$county_income, decreasing=T))
```
- unique() returns the unique values of a variable

```r
unique(police_killings$lawenforcementagency)
```
Subsetting data (1/2)
========================================================
### What is subsetting?
- When you want to see specific rows or columns in a data frame
- Cells in a DataFrames are accessed through bracket notation: 
  + **DataFrame[rows(s), column(s)]**
- To see the first row:

```r
police_killings[1,]
# or 
View(police_killings[1,])
```
- To see the second column (which is age):

```r
police_killings[,2]
# or 
View(police_killings[,2])
```
- Don't forget the comma "," when subsetting a Dataframe!!!
  + Think in terms of rows and columns
Subsetting data (2/2)
========================================================
- So, for instance, let's look at all police killings in New York state
  + To find how to code for New York state, let's run table() or summary() on that column

```r
table(police_killings$state)
# or 
str(police_killings$state)
```
  + Using bracket notation AND the full DataFrame$Column identifier, try this:

```r
police_killings[police_killings$state=="NY",]
```
  + Creating new data frames

```r
# We can save this subsetted data as a new DataFrame
ny_police_killings <- police_killings[police_killings$state=="NY",]
```
  + How many police killings were in NY state in 2015?

```r
dim(ny_police_killings)
```

```
[1] 14 34
```

```r
# Answer: 14
```
### We will learn easier and much more flexible data munging soon (dplyr!)
