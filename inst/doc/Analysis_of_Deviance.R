## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----part1--------------------------------------------------------------------
library(LRTesteR)

set.seed(1)
x <- c(rnorm(50, 1, 1), rnorm(50, 3, 1), rnorm(50, 5, 1))
fctr <- c(rep(1, 50), rep(2, 50), rep(3, 50))
fctr <- factor(fctr, levels = c("1", "2", "3"))
gaussian_mu_one_way(x, fctr, conf.level = 0.95)

## ----part2--------------------------------------------------------------------
set.seed(1)
x <- c(rcauchy(50, 2, 1), rcauchy(50, 2, 3))
fctr <- c(rep(1, 50), rep(2, 50))
fctr <- factor(fctr, levels = c("1", "2"))
cauchy_scale_one_way(x, fctr, conf.level = 0.95)

## ----part3--------------------------------------------------------------------
set.seed(1)
x <- c(rpois(50, 1), rpois(50, 2), rpois(50, 3), rpois(50, 4))
fctr <- c(rep(1, 50), rep(2, 50), rep(3, 50), rep(4, 50))
fctr <- factor(fctr, levels = c("1", "2", "3", "4"))
poisson_lambda_one_way(x, fctr, conf.level = 0.95)

