% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/poisson_tests.R
\name{poisson_lambda_lr_test}
\alias{poisson_lambda_lr_test}
\title{Test lambda of a poisson distribution using the likelihood ratio test.}
\source{
\url{https://en.wikipedia.org/wiki/Likelihood-ratio_test}
}
\usage{
poisson_lambda_lr_test(x, lambda = 1, alternative = "two.sided")
}
\arguments{
\item{x}{a (non-empty) numeric vector of data values.}

\item{lambda}{a number indicating the tested value of lambda}

\item{alternative}{a character string specifying the alternative hypothesis, must be one of "two.sided" (default), "greater" or "less".}
}
\value{
An S3 class containing the test statistic, p value and alternative
hypothesis.
}
\description{
Test lambda of a poisson distribution using the likelihood ratio test.
}
\examples{
library(LRTesteR)

# Null is true
set.seed(1)
x <- rpois(100, 1)
poisson_lambda_lr_test(x, 1, "two.sided")

# Null is false
set.seed(1)
x <- rpois(100, 2)
poisson_lambda_lr_test(x, 1, "greater")
}
