Data Wrangling in R, Lesson 3
================
Christy Garcia, Ph.D. and Christopher Prener, Ph.D.
(February 22, 2022)

## Introduction

In the first two “Data Wrangling” sessions, we explored how to clean
data, work with existing variables, and mutate variables in order to
create new ones. This week we’ll be taking a look at how to manage
observations within a data set.

## Dependencies

This week we’ll continue to use the super powerful `dplyr` package
within `tidyverse`. We also need the `readr` and `here` packages again:

``` r
# tidyverse packages
library(dplyr)     # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)     # read and write csv files

# manage file paths
library(here)      # manage file paths
```

    ## here() starts at /Users/prenercg/GitHub/slu-dss/wrangling-03

## Read in Data

This week we’ll use the same two data sets as the last session – the
clean versions of `mpg` and `starwars`. Our first step is to read those
in:

``` r
mpg <- read_csv(here("data", "mpg.csv"))
```

    ## Rows: 234 Columns: 11

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (6): manufacturer, model, trans, drv, fl, class
    ## dbl (5): displ, year, cyl, cty, hwy

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
starwars <- read_csv(here("data", "starwars.csv"))
```

    ## Rows: 87 Columns: 10

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (7): name, hair_color, skin_color, eye_color, gender, homeworld, species
    ## dbl (3): height, mass, birth_year

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

## Review - Subsetting columns with `select`

Depending on where you get your data from, you might end up with a data
set that has hundreds or even thousands of variables. Chances are you
are not actually going to use all of these variables. The `select()`
function allows you to select which variables you would like to include:

``` r
mpg_select <- select(mpg, manufacturer, model, year, cty, hwy)
```

If the variables/columns you want to select happen to be right next to
each other, you can also tell it the range of columns to include:

``` r
mpg_select2 <- select(mpg, manufacturer:year)
```

If you’d like to preserve all of the variables, but re-order them so
that certain columns appear at the beginning of the data frame, you can
embed the `everything()` function within `select()`. As a bonus, we’ll
also show off an additional feature of `select()` - renaming variables
on the fly. By using the same `new_name = old_name` syntax from
`rename()`, we can rename variables as we subset columns.

``` r
mpg_select3 <- select(mpg, city = cty, highway = hwy, everything())
```

This decreases the amount of code we have to write, but might be harder
for humans to read. So, there is a trade off here.

Try using `select()` with the `starwars` data frame. (For example,
selecting only those variables that are related to phenotype.) If you
want, you can try renaming variables as well.

``` r
starwars_select <- select(starwars, name, hair = hair_color, skin = skin_color, eyes = eye_color)
```

## Subsetting rows with `filter`

The function `filter()` within the `dplyr` package allows us to subset
observations based on a given variable value. We need to specify the
following within the function:

1.  the name of the data frame
2.  which variables we would like to filter by
3.  what values of those variables we would like to select

For example, say we want to filter out the automobiles from the `mpg`
data frame that are Audi’s and have four cylinders:

``` r
filter(mpg, manufacturer == "audi" & cyl == 4)
```

    ## # A tibble: 8 × 11
    ##   manufacturer model      displ  year   cyl trans  drv     cty   hwy fl    class
    ##   <chr>        <chr>      <dbl> <dbl> <dbl> <chr>  <chr> <dbl> <dbl> <chr> <chr>
    ## 1 audi         a4           1.8  1999     4 auto(… f        18    29 p     comp…
    ## 2 audi         a4           1.8  1999     4 manua… f        21    29 p     comp…
    ## 3 audi         a4           2    2008     4 manua… f        20    31 p     comp…
    ## 4 audi         a4           2    2008     4 auto(… f        21    30 p     comp…
    ## 5 audi         a4 quattro   1.8  1999     4 manua… 4        18    26 p     comp…
    ## 6 audi         a4 quattro   1.8  1999     4 auto(… 4        16    25 p     comp…
    ## 7 audi         a4 quattro   2    2008     4 manua… 4        20    28 p     comp…
    ## 8 audi         a4 quattro   2    2008     4 auto(… 4        19    27 p     comp…

(Note the quotes for the character value “audi” and the lack of quotes
for the integer value for cylinders.)

If we do nothing else, this only prints the filtered results, but we can
also save them to a new data frame if we want to later do some analysis
of only this subset of the data.

``` r
audi4 <- filter(mpg, manufacturer == "audi" & cyl == 4)
```

Practice using the `filter()` function by making a subset of the
`starwars` data. (For example, filtering only the humans from Tatooine.)

``` r
humanTat <- filter(starwars, homeworld == "Tatooine" & species == "Human")
```

Like we saw last time, we can use operators to get a little bit more
complicated. Here are the basic operators we have at our disposal:

`>` greater than `>=` greater than or equal to `<` less than `<=` less
than or equal to `!=` not equal to `==` equal to `&` and `|` or `!` not

For example, let’s `filter()` all automobiles that have four or six
cylinders:

``` r
filter(mpg, cyl==4 | cyl ==6)
```

    ## # A tibble: 160 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <chr> <chr>
    ##  1 audi         a4           1.8  1999     4 auto… f        18    29 p     comp…
    ##  2 audi         a4           1.8  1999     4 manu… f        21    29 p     comp…
    ##  3 audi         a4           2    2008     4 manu… f        20    31 p     comp…
    ##  4 audi         a4           2    2008     4 auto… f        21    30 p     comp…
    ##  5 audi         a4           2.8  1999     6 auto… f        16    26 p     comp…
    ##  6 audi         a4           2.8  1999     6 manu… f        18    26 p     comp…
    ##  7 audi         a4           3.1  2008     6 auto… f        18    27 p     comp…
    ##  8 audi         a4 quattro   1.8  1999     4 manu… 4        18    26 p     comp…
    ##  9 audi         a4 quattro   1.8  1999     4 auto… 4        16    25 p     comp…
    ## 10 audi         a4 quattro   2    2008     4 manu… 4        20    28 p     comp…
    ## # … with 150 more rows

As we saw last time, we can also use the `%in%` operator to select
multiple values to filter:

``` r
filter(mpg, cyl %in% c(4, 6))
```

    ## # A tibble: 160 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <chr> <chr>
    ##  1 audi         a4           1.8  1999     4 auto… f        18    29 p     comp…
    ##  2 audi         a4           1.8  1999     4 manu… f        21    29 p     comp…
    ##  3 audi         a4           2    2008     4 manu… f        20    31 p     comp…
    ##  4 audi         a4           2    2008     4 auto… f        21    30 p     comp…
    ##  5 audi         a4           2.8  1999     6 auto… f        16    26 p     comp…
    ##  6 audi         a4           2.8  1999     6 manu… f        18    26 p     comp…
    ##  7 audi         a4           3.1  2008     6 auto… f        18    27 p     comp…
    ##  8 audi         a4 quattro   1.8  1999     4 manu… 4        18    26 p     comp…
    ##  9 audi         a4 quattro   1.8  1999     4 auto… 4        16    25 p     comp…
    ## 10 audi         a4 quattro   2    2008     4 manu… 4        20    28 p     comp…
    ## # … with 150 more rows

In this example, we are filtering all automobiles that are more than 6
cylinders and made before 2008:

``` r
filter(mpg, cyl >= 6 & year < 2008)
```

    ## # A tibble: 72 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <chr> <chr>
    ##  1 audi         a4           2.8  1999     6 auto… f        16    26 p     comp…
    ##  2 audi         a4           2.8  1999     6 manu… f        18    26 p     comp…
    ##  3 audi         a4 quattro   2.8  1999     6 auto… 4        15    25 p     comp…
    ##  4 audi         a4 quattro   2.8  1999     6 manu… 4        17    25 p     comp…
    ##  5 audi         a6 quattro   2.8  1999     6 auto… 4        15    24 p     mids…
    ##  6 chevrolet    c1500 sub…   5.7  1999     8 auto… r        13    17 r     suv  
    ##  7 chevrolet    corvette     5.7  1999     8 manu… r        16    26 p     2sea…
    ##  8 chevrolet    corvette     5.7  1999     8 auto… r        15    23 p     2sea…
    ##  9 chevrolet    k1500 tah…   5.7  1999     8 auto… 4        11    15 r     suv  
    ## 10 chevrolet    k1500 tah…   6.5  1999     8 auto… 4        14    17 d     suv  
    ## # … with 62 more rows

Your turn! Try using `filter()` with some operators to filter the
`starwars` data frame in two or three different ways. (For example,
filtering the tall males, or those who have blue or blue-gray eyes and
are from anywhere but Tatooine.)

``` r
filter(starwars, height >= 180 & gender == "male")
```

    ## # A tibble: 40 × 10
    ##    name           height  mass hair_color skin_color eye_color birth_year gender
    ##    <chr>           <dbl> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> 
    ##  1 Darth Vader       202 136   none       white      yellow          41.9 male  
    ##  2 Biggs Darklig…    183  84   black      light      brown           24   male  
    ##  3 Obi-Wan Kenobi    182  77   auburn, w… fair       blue-gray       57   male  
    ##  4 Anakin Skywal…    188  84   blond      fair       blue            41.9 male  
    ##  5 Wilhuff Tarkin    180  NA   auburn, g… fair       blue            64   male  
    ##  6 Chewbacca         228 112   brown      unknown    blue           200   male  
    ##  7 Han Solo          180  80   brown      fair       brown           29   male  
    ##  8 Jek Tono Pork…    180 110   brown      fair       blue            NA   male  
    ##  9 Boba Fett         183  78.2 black      fair       brown           31.5 male  
    ## 10 Bossk             190 113   none       green      red             53   male  
    ## # … with 30 more rows, and 2 more variables: homeworld <chr>, species <chr>

``` r
filter(starwars, homeworld != "Tatooine" & eye_color %in% c("blue", "blue-gray"))
```

    ## # A tibble: 14 × 10
    ##    name           height  mass hair_color skin_color eye_color birth_year gender
    ##    <chr>           <dbl> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> 
    ##  1 Obi-Wan Kenobi    182  77   auburn, w… fair       blue-gray         57 male  
    ##  2 Wilhuff Tarkin    180  NA   auburn, g… fair       blue              64 male  
    ##  3 Chewbacca         228 112   brown      unknown    blue             200 male  
    ##  4 Jek Tono Pork…    180 110   brown      fair       blue              NA male  
    ##  5 Lobot             175  79   none       light      blue              37 male  
    ##  6 Mon Mothma        150  NA   auburn     fair       blue              48 female
    ##  7 Finis Valorum     170  NA   blond      fair       blue              91 male  
    ##  8 Ric Olié          183  NA   brown      fair       blue              NA male  
    ##  9 Adi Gallia        184  50   none       dark       blue              NA female
    ## 10 Mas Amedda        196  NA   none       blue       blue              NA male  
    ## 11 Luminara Undu…    170  56.2 black      yellow     blue              58 female
    ## 12 Barriss Offee     166  50   black      yellow     blue              40 female
    ## 13 Jocasta Nu        167  NA   white      fair       blue              NA female
    ## 14 Tarfful           234 136   brown      brown      blue              NA male  
    ## # … with 2 more variables: homeworld <chr>, species <chr>

## Choose rows by position with `slice`

To instead subset your data by row position, you can use the `slice()`
function to include only certain observations. All you have to specify
is the data frame to be sliced and which rows you would like to include:

``` r
mpg_sliced <- slice(mpg, 100:120)
```

Remember you can also use `head()` and `tail()` to get a quick look at
the first six and last six observations, respectively.

``` r
head(mpg)
```

    ## # A tibble: 6 × 11
    ##   manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class 
    ##   <chr>        <chr> <dbl> <dbl> <dbl> <chr>      <chr> <dbl> <dbl> <chr> <chr> 
    ## 1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compa…
    ## 2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compa…
    ## 3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compa…
    ## 4 audi         a4      2    2008     4 auto(av)   f        21    30 p     compa…
    ## 5 audi         a4      2.8  1999     6 auto(l5)   f        16    26 p     compa…
    ## 6 audi         a4      2.8  1999     6 manual(m5) f        18    26 p     compa…

``` r
tail(mpg)
```

    ## # A tibble: 6 × 11
    ##   manufacturer model  displ  year   cyl trans      drv     cty   hwy fl    class
    ##   <chr>        <chr>  <dbl> <dbl> <dbl> <chr>      <chr> <dbl> <dbl> <chr> <chr>
    ## 1 volkswagen   passat   1.8  1999     4 auto(l5)   f        18    29 p     mids…
    ## 2 volkswagen   passat   2    2008     4 auto(s6)   f        19    28 p     mids…
    ## 3 volkswagen   passat   2    2008     4 manual(m6) f        21    29 p     mids…
    ## 4 volkswagen   passat   2.8  1999     6 auto(l5)   f        16    26 p     mids…
    ## 5 volkswagen   passat   2.8  1999     6 manual(m5) f        18    26 p     mids…
    ## 6 volkswagen   passat   3.6  2008     6 auto(s6)   f        17    26 p     mids…

Slice and dice in the `starwars` data frame:

``` r
starwars_sliced <- slice(starwars, 1:20)
```

## Arrange rows with `arrange`

The function `arrange()` changes the order of rows within a data frame.
You can think of it as analogous to the ‘sort’ function in Excel. First,
we tell it what data frame we would like to re-order and then which
variables(s) to order by:

``` r
arrange(mpg, cty)
```

    ## # A tibble: 234 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <chr> <chr>
    ##  1 dodge        dakota pi…   4.7  2008     8 auto… 4         9    12 e     pick…
    ##  2 dodge        durango 4…   4.7  2008     8 auto… 4         9    12 e     suv  
    ##  3 dodge        ram 1500 …   4.7  2008     8 auto… 4         9    12 e     pick…
    ##  4 dodge        ram 1500 …   4.7  2008     8 manu… 4         9    12 e     pick…
    ##  5 jeep         grand che…   4.7  2008     8 auto… 4         9    12 e     suv  
    ##  6 chevrolet    c1500 sub…   5.3  2008     8 auto… r        11    15 e     suv  
    ##  7 chevrolet    k1500 tah…   5.3  2008     8 auto… 4        11    14 e     suv  
    ##  8 chevrolet    k1500 tah…   5.7  1999     8 auto… 4        11    15 r     suv  
    ##  9 dodge        caravan 2…   3.3  2008     6 auto… f        11    17 e     mini…
    ## 10 dodge        dakota pi…   5.2  1999     8 manu… 4        11    17 r     pick…
    ## # … with 224 more rows

Just like with `filter()` and `slice()`, this new sorted order is not
saved to the data frame unless you use the assignment operator:

``` r
mpg_sorted <- arrange(mpg, cty)
```

Also, the default is ascending order unless you specify that you want
descending order with `desc()`:

``` r
arrange(mpg, desc(cty))
```

    ## # A tibble: 234 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <chr> <chr>
    ##  1 volkswagen   new beetle   1.9  1999     4 manu… f        35    44 d     subc…
    ##  2 volkswagen   jetta        1.9  1999     4 manu… f        33    44 d     comp…
    ##  3 volkswagen   new beetle   1.9  1999     4 auto… f        29    41 d     subc…
    ##  4 honda        civic        1.6  1999     4 manu… f        28    33 r     subc…
    ##  5 toyota       corolla      1.8  2008     4 manu… f        28    37 r     comp…
    ##  6 honda        civic        1.8  2008     4 manu… f        26    34 r     subc…
    ##  7 toyota       corolla      1.8  1999     4 manu… f        26    35 r     comp…
    ##  8 toyota       corolla      1.8  2008     4 auto… f        26    35 r     comp…
    ##  9 honda        civic        1.6  1999     4 manu… f        25    32 r     subc…
    ## 10 honda        civic        1.8  2008     4 auto… f        25    36 r     subc…
    ## # … with 224 more rows

\*Note: Missing values (which we don’t have any of!) are sorted to the
end.

If you specify more than one variable within the function, `arrange()`
will sort by that variable after the preceding one (similar to
‘sort/then by’ in Excel).

``` r
arrange(mpg, cty, class)
```

    ## # A tibble: 234 × 11
    ##    manufacturer model      displ  year   cyl trans drv     cty   hwy fl    class
    ##    <chr>        <chr>      <dbl> <dbl> <dbl> <chr> <chr> <dbl> <dbl> <chr> <chr>
    ##  1 dodge        dakota pi…   4.7  2008     8 auto… 4         9    12 e     pick…
    ##  2 dodge        ram 1500 …   4.7  2008     8 auto… 4         9    12 e     pick…
    ##  3 dodge        ram 1500 …   4.7  2008     8 manu… 4         9    12 e     pick…
    ##  4 dodge        durango 4…   4.7  2008     8 auto… 4         9    12 e     suv  
    ##  5 jeep         grand che…   4.7  2008     8 auto… 4         9    12 e     suv  
    ##  6 dodge        caravan 2…   3.3  2008     6 auto… f        11    17 e     mini…
    ##  7 dodge        dakota pi…   5.2  1999     8 manu… 4        11    17 r     pick…
    ##  8 dodge        dakota pi…   5.2  1999     8 auto… 4        11    15 r     pick…
    ##  9 dodge        ram 1500 …   5.2  1999     8 auto… 4        11    15 r     pick…
    ## 10 dodge        ram 1500 …   5.2  1999     8 manu… 4        11    16 r     pick…
    ## # … with 224 more rows

Try re-ordering the rows of the `starwars` data frame. (For example,
re-order by home world and then alphabetically by first name.)

``` r
arrange(starwars, homeworld, name)
```

    ## # A tibble: 87 × 10
    ##    name           height  mass hair_color skin_color eye_color birth_year gender
    ##    <chr>           <dbl> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> 
    ##  1 Bail Prestor …    191    NA black      tan        brown             67 male  
    ##  2 Leia Organa       150    49 brown      light      brown             19 female
    ##  3 Raymus Antill…    188    79 brown      light      brown             NA male  
    ##  4 Ratts Tyerell      79    15 none       grey, blue unknown           NA male  
    ##  5 Lobot             175    79 none       light      blue              37 male  
    ##  6 Jek Tono Pork…    180   110 brown      fair       blue              NA male  
    ##  7 Nute Gunray       191    90 none       mottled g… red               NA male  
    ##  8 Ki-Adi-Mundi      198    82 white      pale       yellow            92 male  
    ##  9 Mas Amedda        196    NA none       blue       blue              NA male  
    ## 10 Mon Mothma        150    NA auburn     fair       blue              48 female
    ## # … with 77 more rows, and 2 more variables: homeworld <chr>, species <chr>

## Random Samples

Sometimes it is useful to create a random sample of our data. This can
use particularly helpful if you want to work out the kinks of a data
cleaning or analysis process on a subset of the data, or if you want to
create a sub-sample for additional analyses.

``` r
# create sample
mpg_random <- sample_n(mpg, size = 50)
```

If you wanted every draw to have the same observations, you can set the
“seed” (using `base::set.seed()`). In this case, it ensures that we all
end up with the same random draw from the `mpg` data:

``` r
# set seed
set.seed(12345)

# create sample
mpg_random2 <- sample_n(mpg, size = 50)
```

Try taking a random sample of 40 observations from the `starwars` data
frame. There is no need to `set.seed()` here:

``` r
starwars_sample <- sample_n(starwars, size = 40)
```
