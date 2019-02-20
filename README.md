# wrangling-03 <img src="/img/logo.png" align="right" />
[![](https://img.shields.io/badge/seminar-data%20wrangling%20in%20r-brightgreen.svg)](https://github.com/slu-dss/wrangling-03/)
[![](https://img.shields.io/badge/lesson%20status-stable-brightgreen.svg)](https://github.com/slu-dss/wrangling-03/)
[![](https://img.shields.io/github/release/slu-dss/wrangling-03.svg?label=version)](https://github.com/slu-dss/wrangling-03/releases)
[![](https://img.shields.io/github/last-commit/slu-dss/wrangling-03.svg)](https://github.com/slu-dss/wrangling-03/commits/master)
[![Travis-CI Build Status](https://travis-ci.org/slu-dss/wrangling-03.svg?branch=master)](https://travis-ci.org/slu-dss/wrangling-03)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/slu-dss/wrangling-03?branch=master&svg=true)](https://ci.appveyor.com/project/chris-prener/wrangling-03)

## Lesson Overview
This repository contains the third lesson for the Data Wrangling in R seminar. This lesson covers the basics of using `dplyr` to modify existing observations.

### Lesson Objectives
By the end of this lesson, learners should be able to:

1. Create a new data frame with only a selection (i.e. a "subset") of observations based on characteristics present in the data.
2. Create a new data frame with a set group of observations based on the current sort order.
3. Create a new data frame with a random sample of observations.

### Lesson Resources
* The [`SETUP.md`](/references/SETUP.md) file in the [`references/`](/references) directory contains a list of packages required for this lesson
* The [`notebook/`](/notebook) directory contains our primary teaching materials, included a completed version of the notebook we will be working on during the seminar.
* The [lesson slides](https://slu-dss.github.io/wrangling-01/) provide an overview of the DSS and data cleaning.
* The [`references/`](/references) directory also contains other notes on changes to the repository, key topics, terms, data sources, and software.

### Extra Resources
* [*R for Data Science*, Chapter 5 - Data Transformation](https://r4ds.had.co.nz/transform.html)
* [RStudio's `dplyr` Cheat Sheet](https://www.rstudio.com/resources/cheatsheets/#dplyr)

### Lesson Quick Start
#### Install Necessary Packages
The packages we'll need for today can be installed using:

```r
install.packages(c("tidyverse", "here", "knitr", "rmarkdown", "usethis"))
```

#### Download Lesson Materials
You can download this lesson to your Desktop easily using `usethis`:

```r
usethis::use_course("https://github.com/slu-dss/wrangling-03/archive/master.zip")
```

By using `usethis::use_course`, all of the lesson materials will be downloaded to your computer, automatically extracted, and saved to your desktop. You can then open the `.Rproj` file to get started.

## Contributor Code of Conduct
Please note that this project is released with a [Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## About the SLU DSS
### Data Wrangling in `R`

### About the SLU Data Science Seminar
The [SLU Data Science Seminar](https://slu-dss.githb.io) (DSS) is a collaborative, interdisciplinary group at Saint Louis University focused on building researchers’ data science skills using open source software. We currently host seminars focused on the programming language R. The SLU DSS is co-organized by [Christina Gacia, Ph.D.](mailto:christina.garcia@slu.edu), [Kelly Lovejoy, Ph.D.](mailto:kelly.lovejoy@slu.edu), and [Christopher Prener, Ph.D.](mailto:chris.prener@slu.edu}). You can keep up with us here on GitHub, on our [website](https://slu-dss.githb.io), and on [Twitter](https://twitter.com/SLUDSS).

### About Saint Louis University <img src="/img/sluLogo.png" align="right" />
Founded in 1818, [Saint Louis University](http://www.slu.edu) is one of the nation’s oldest and most prestigious Catholic institutions. Rooted in Jesuit values and its pioneering history as the first university west of the Mississippi River, SLU offers nearly 13,000 students a rigorous, transformative education of the whole person. At the core of the University’s diverse community of scholars is SLU’s service-focused mission, which challenges and prepares students to make the world a better, more just place.
