## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----part1--------------------------------------------------------------------
library(LRTesteR)

set.seed(123)
x <- c(
  rnorm(n = 50, mean = 1, sd = 1),
  rnorm(n = 50, mean = 3, sd = 1),
  rnorm(n = 50, mean = 5, sd = 1)
)
fctr <- c(rep(1, 50), rep(2, 50), rep(3, 50))
fctr <- factor(fctr, levels = c("1", "2", "3"))
gaussian_mu_one_way(x = x, fctr = fctr, conf.level = 0.95)

## ----part2--------------------------------------------------------------------
empirical_mu_one_way(x = x, fctr = fctr, conf.level = 0.95)

## ----part3--------------------------------------------------------------------
set.seed(1)
x <- c(rcauchy(n = 50, location = 2, scale = 1), rcauchy(n = 50, location = 2, scale = 3))
fctr <- c(rep(1, 50), rep(2, 50))
fctr <- factor(fctr, levels = c("1", "2"))
cauchy_scale_one_way(x = x, fctr = fctr, conf.level = 0.95)

## ----part4--------------------------------------------------------------------
set.seed(1)
x <- c(rpois(n = 50, lambda = 1), rpois(n = 50, lambda = 2), rpois(n = 50, lambda = 3))
fctr <- c(rep(1, 50), rep(2, 50), rep(3, 50))
fctr <- factor(fctr, levels = c("1", "2", "3"))
poisson_lambda_one_way(x = x, fctr = fctr, conf.level = 0.95)

