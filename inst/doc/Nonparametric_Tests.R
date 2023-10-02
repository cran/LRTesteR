## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----part1--------------------------------------------------------------------
library(LRTesteR)
library(statmod)

set.seed(1)
x <- rinvgauss(n = 30, mean = 2.25, dispersion = 2)
empirical_mu_one_sample(x = x, mu = 1, alternative = "two.sided")

## ----part2--------------------------------------------------------------------
set.seed(1)
x <- c(
  rinvgauss(n = 35, mean = 1, dispersion = 1),
  rinvgauss(n = 40, mean = 2, dispersion = 3),
  rinvgauss(n = 45, mean = 3, dispersion = 5)
)
fctr <- c(rep(1, 35), rep(2, 40), rep(3, 45))
fctr <- factor(fctr, levels = c("1", "2", "3"))
empirical_mu_one_way(x = x, fctr = fctr, conf.level = .95)

## ----part3--------------------------------------------------------------------
set.seed(2)
x <- rnorm(n = 30, mean = 0, sd = 1)
empirical_quantile_one_sample(x = x, Q = .50, value = 0, alternative = "two.sided")

## ----part4--------------------------------------------------------------------
# Q1
empirical_quantile_one_sample(x = x, Q = .25, value = 0, alternative = "two.sided")

## ----part5--------------------------------------------------------------------
# Q3
empirical_quantile_one_sample(x = x, Q = .75, value = 0, alternative = "two.sided")

## ----part6--------------------------------------------------------------------
set.seed(1)
x <- c(
  rnorm(n = 35, mean = 1, sd = 1),
  rnorm(n = 40, mean = 2, sd = 1.25),
  rnorm(n = 45, mean = 3, sd = 1.5)
)
fctr <- c(rep(1, 35), rep(2, 40), rep(3, 45))
fctr <- factor(fctr, levels = c("1", "2", "3"))
empirical_quantile_one_way(x = x, Q = .50, fctr = fctr)

