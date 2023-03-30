## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----part1--------------------------------------------------------------------
library(LRTesteR)

set.seed(1)
x <- rnorm(n = 30, mean = 1, sd = 1)
empirical_mu_one_sample(x = x, mu = 0, alternative = "two.sided")

## ----part2--------------------------------------------------------------------
library(statmod)

set.seed(1)
x <- rinvgauss(n = 30, mean = 2.25, dispersion = 2)
empirical_mu_one_sample(x = x, mu = 1, alternative = "two.sided")

## ----part3--------------------------------------------------------------------
set.seed(1)
x <- c(rnorm(n = 30, mean = 1, sd = 1), rnorm(n = 30, mean = 1.5, sd = 1.5), rnorm(n = 30, mean = 2, sd = 2))
fctr <- c(rep(1, 30), rep(2, 30), rep(3, 30))
fctr <- factor(fctr, levels = c("1", "2", "3"))
empirical_mu_one_way(x = x, fctr = fctr, conf.level = .95)

## ----part4--------------------------------------------------------------------
set.seed(1)
x <- c(rnorm(n = 30, mean = 1, sd = 1), rnorm(n = 40, mean = 1.5, sd = 1.5), rnorm(n = 50, mean = 2, sd = 2))
fctr <- c(rep(1, 30), rep(2, 40), rep(3, 50))
fctr <- factor(fctr, levels = c("1", "2", "3"))
empirical_mu_one_way(x = x, fctr = fctr, conf.level = .95)

