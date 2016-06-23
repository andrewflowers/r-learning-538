Functions and Control Structures
========================================================
author: Andrew Flowers
date: Thurs., June 23, 2016
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
- Functions
  - Function basics
  - Default arguments
  - Return values
- Control structures
  - if(), else, ifelse()
  - for() loops
  - while() loops
- Apply functions
  - lapply()
  - sapply()


Function basics
========================================================
Functions are incredibly important
- If you find yourself copy and pasting a lot of code -- **WRITE A FUNCTION**
Write a function using **function()** 
- A function doesn't have to have an argument

```r
double_num <- function(num) { num * 2 }

double_num(269)
```

```
[1] 538
```
- But most functions do have arguments
  + Arguments are inputs the user may explictly set

```r
print_name <- function(your_name) {
  print(your_name)
}

print_name("Andrew Flowers")
```

```
[1] "Andrew Flowers"
```

Default arguments
========================================================
You can specify default argumetns for a function
 + That way you don't have to specify that argument ever time


```r
article_details <- function(title, length = 1500) {
  print(
    paste0(
      "The article ", title, " will be ", length, " words long."
      )
    )
}

article_details("Clinton Wins The White House")
```

```
[1] "The article Clinton Wins The White House will be 1500 words long."
```

```r
article_details("OMFG, Trump Won The Election", 2000)
```

```
[1] "The article OMFG, Trump Won The Election will be 2000 words long."
```

Return values
========================================================
You may want to return a specific value and assign it to a variable
 + Use the **return()** function


```r
retirement_date <- function(your_age, retirement_age = 67) {
  year_to_retire <- (retirement_age - your_age) + 2016
  return(year_to_retire)
}

retirement_date(30)
```

```
[1] 2053
```
- You can write out the arguments names
 + But it's not required
 + R functions match to arguments **positionally**, or by name

```r
retirement_date(your_age = 30, retirement_age = 77)
```

```
[1] 2063
```

```r
retirement_date(30, 57)
```

```
[1] 2043
```

```r
retirement_date(retirement_age = 57, your_age = 30)
```

```
[1] 2043
```

```r
# Use args(retirement_date) to see arguments
```

Control structures: if() and else
========================================================
Control structures allow you to control the flow of execution
- if() and else are the building blocks
- **if ( [some condition] ) { [do if TRUE] } else { [do if FALSE] }**

```r
if (2 < 1) { 
  print("Never print this")
}

if (2 > 1) { 
  print("Always print this")
}
```

```
[1] "Always print this"
```

```r
name <-  "Andrew"

if (name == "Andrew") { 
  print("That's me!")
} else {
  print("Whoa, that's not me.")
}
```

```
[1] "That's me!"
```

```r
 # You can chain togethter mutliple if()/else() functions
name <- "Barack Obama"
if (name == "Andrew") { 
  print("That's me.")
} else if (name == "Anna"){
  print("That's my wife.")
} else if (name == "Vivian") {
  print("That's my daughter.")
} else {
  print("Oops!")
}
```

```
[1] "Oops!"
```

Control structures: ifelse()
========================================================
ifelse() is a nice function that combines these two control structures into one
- **ifelse ( [if condition], [do if TRUE], [do if FALSE] )**

```r
library(lubridate)
todays_date <- ymd("2016/6/23")

ifelse( todays_date < ymd("2016/7/4"), "July 4th hasn't happened yet", "July 4th has passed")
```

```
[1] "July 4th hasn't happened yet"
```

```r
# Check out this data set
# mtcars
library(dplyr)

# Useful using ifelse() with mutate() to create new variables
mtcars %>% 
  mutate(good_mpg = ifelse (mpg >= 30, TRUE, FALSE)) %>% 
  filter(good_mpg)
```

```
   mpg cyl disp  hp drat    wt  qsec vs am gear carb good_mpg
1 32.4   4 78.7  66 4.08 2.200 19.47  1  1    4    1     TRUE
2 30.4   4 75.7  52 4.93 1.615 18.52  1  1    4    2     TRUE
3 33.9   4 71.1  65 4.22 1.835 19.90  1  1    4    1     TRUE
4 30.4   4 95.1 113 3.77 1.513 16.90  1  1    5    2     TRUE
```

Control structures: for() loops (Part 1)
========================================================
for() loops are a crucial part of programming
- **for ( [element] in [sequence] ) { [do something] }**

```r
for (i in 1:10){
  print(i)
}
```

```
[1] 1
[1] 2
[1] 3
[1] 4
[1] 5
[1] 6
[1] 7
[1] 8
[1] 9
[1] 10
```

```r
# Let's find the max value for each car variable
for (col in 1:ncol(mtcars)){ # Could use seq_along(mtcars) instead
  print(max(mtcars[, col]))
}
```

```
[1] 33.9
[1] 8
[1] 472
[1] 335
[1] 4.93
[1] 5.424
[1] 22.9
[1] 1
[1] 1
[1] 5
[1] 8
```

Control structures: for() loops (Part 2)
========================================================
for() loops are flexible
- It will automatically iterate over each item in a vector

```r
letters

for (letter in letters){
  print(letter)
}

family <- c("Andrew", "Anna", "Vivian")

for (person in family){ 
  print(person)
}
```
for() loops can be nested
- WARNING: this can slow your code down a lot

```r
x <- matrix(1:6, 2, 3)
x
```

```
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

```r
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}
```

```
[1] 1
[1] 3
[1] 5
[1] 2
[1] 4
[1] 6
```

Control structures: while() loops
========================================================
while() loops are used much less often
- **while ( [condition is TRUE] ) { [continue doing something] }**

```r
count <- 0

while (count < 10) {
  print(count)
  count <- count + 1
}
```

```
[1] 0
[1] 1
[1] 2
[1] 3
[1] 4
[1] 5
[1] 6
[1] 7
[1] 8
[1] 9
```
- WARNING: these can potentially result in infinite loops

The apply() function family
========================================================
These are extremely useful functions for **looping**
 + Great for an interactive setting
 + Avoid the curl braces of for() and while() loops
 + Computationally more efficient
 
There are five main "apply" functions (we'll focus on first two):
- lapply(): Loop over a list and evaluate a function on each element
- sapply(): Same as lapply but try to simplify the result
- apply(): Apply a function over the margins of an array
- tapply(): Apply a function over subsets of a vector
- mapply(): Multivariate version of lapply

lapply() -- Part 1
========================================================
Workhouse function
 - **applies** a function to each element of a **list**
 - Always returns a list
 
Structure of function:
- **lapply ( [list to loop through], [function], [other arguments ... ] )**

```r
x <- list(a = 1:5, b = rnorm(10))
x
```

```
$a
[1] 1 2 3 4 5

$b
 [1] -0.7605941 -1.0541132 -0.8573815 -2.2427025 -0.0214562 -0.8679225
 [7] -1.5373108  1.7507773 -1.7361028  0.7159639
```

```r
lapply(x, mean)
```

```
$a
[1] 3

$b
[1] -0.6610842
```

```r
# ASSIGNMENT: use lapply() to find mean of each variable in mtcars
```

lapply() -- Part 2
========================================================
Can also pass other arguments for function

```r
?runif
x <- 1:4
lapply(x, runif)
lapply(x, runif, min = 0, max = 10)
```
Can use anonymous functions
 - You write the function on the spot

```r
lapply(mtcars, function(var) { var[2] })
```

```
$mpg
[1] 21

$cyl
[1] 6

$disp
[1] 160

$hp
[1] 110

$drat
[1] 3.9

$wt
[1] 2.875

$qsec
[1] 17.02

$vs
[1] 0

$am
[1] 1

$gear
[1] 4

$carb
[1] 4
```

```r
lapply(mtcars, function(var) { c(mean(var), sd(var)) })
```

```
$mpg
[1] 20.090625  6.026948

$cyl
[1] 6.187500 1.785922

$disp
[1] 230.7219 123.9387

$hp
[1] 146.68750  68.56287

$drat
[1] 3.5965625 0.5346787

$wt
[1] 3.2172500 0.9784574

$qsec
[1] 17.848750  1.786943

$vs
[1] 0.4375000 0.5040161

$am
[1] 0.4062500 0.4989909

$gear
[1] 3.6875000 0.7378041

$carb
[1] 2.8125 1.6152
```

sapply() 
========================================================
Variant of lapply(), tries to simplify the results
Sometimes you don't want a list to be returned

```r
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))

lapply(x, mean)
```

```
$a
[1] 2.5

$b
[1] 0.3589385

$c
[1] 0.7261239

$d
[1] 4.929451
```

```r
typeof(lapply(x, mean))
```

```
[1] "list"
```

```r
sapply(x, mean)
```

```
        a         b         c         d 
2.5000000 0.3589385 0.7261239 4.9294514 
```

```r
typeof(sapply(x, mean))
```

```
[1] "double"
```
