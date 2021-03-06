#' Test the shape parameter of a gamma distribution using the likelihood ratio test.
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param shape a number indicating the tested value of the shape parameter.
#' @param alternative a character string specifying the alternative hypothesis, must be one of "two.sided" (default), "greater" or "less".
#' @return An S3 class containing the test statistic, p value and alternative
#' hypothesis.
#' @source \url{https://en.wikipedia.org/wiki/Likelihood-ratio_test}
#' @examples
#' library(LRTesteR)
#'
#' # Null is true
#' set.seed(1)
#' x <- rgamma(100, shape = 1, scale = 2)
#' gamma_shape_lr_test(x, 1, "two.sided")
#'
#' # Null is false
#' set.seed(1)
#' x <- rgamma(100, shape = 3, scale = 2)
#' gamma_shape_lr_test(x, 1, "greater")
#' @export
gamma_shape_lr_test <- function(x, shape = 1, alternative = "two.sided") {
  if (length(x) < 50) {
    stop("Argument x should have at least 50 data points.")
  }
  if (!is.numeric(x)) {
    stop("Argument x should be numeric.")
  }
  if (length(shape) != 1) {
    stop("Argument shape should have length one.")
  }
  if (!is.numeric(shape)) {
    stop("Argument shape should be numeric.")
  }
  if (shape <= 0) {
    stop("Argument shape should be positive.")
  }
  if (length(alternative) != 1) {
    stop("Argument alternative should have length one.")
  }
  if (!is.character(alternative)) {
    stop("Argument alternative should be a character.")
  }
  if (!(alternative %in% c("two.sided", "less", "greater"))) {
    stop("Argument alternative should be 'two.sided', 'less', or 'greater'")
  }

  get_MLEs <- function(x) {
    # Based on wiki page for gamma distribution.
    # starting points
    s <- log(mean(x)) - mean(log(x))
    shape <- (3 - s + ((s - 3)^2 + 24 * s)^.5) / (12 * s)

    # newton updates
    for (i in 1:10) {
      shape <- shape - (log(shape) - base::digamma(shape) - s) / ((1 / shape) - base::psigamma(shape, deriv = 1))
    }

    scale <- sum(x) / (shape * length(x))
    rate <- 1 / scale
    MLEs <- c(shape, rate)

    return(MLEs)
  }

  MLEs <- get_MLEs(x)
  obs_shape <- MLEs[1]
  obs_rate <- MLEs[2]
  obs_scale <- 1 / obs_rate

  # Profile scale/rate based on null hypothesis shape
  profile_scale <- mean(x) / shape
  profile_rate <- 1 / profile_scale

  if (alternative == "two.sided") {
    W <- 2 * (sum(stats::dgamma(x = x, shape = obs_shape, rate = obs_rate, log = TRUE)) -
      sum(stats::dgamma(x = x, shape = shape, rate = profile_rate, log = TRUE)))
    p.value <- stats::pchisq(q = W, df = 1, lower.tail = FALSE)
  }
  else {
    W <- 2 * (sum(stats::dgamma(x = x, shape = obs_shape, rate = obs_rate, log = TRUE)) -
      sum(stats::dgamma(x = x, shape = shape, rate = profile_rate, log = TRUE)))
    W <- sign(obs_shape - shape) * W^.5
    if (alternative == "less") {
      p.value <- stats::pnorm(q = W, lower.tail = TRUE)
    }
    if (alternative == "greater") {
      p.value <- stats::pnorm(q = W, lower.tail = FALSE)
    }
  }

  out <- list(statistic = W, p.value = p.value, alternative = alternative)
  class(out) <- "lrtest"
  return(out)
}

#' Test the scale parameter of a gamma distribution using the likelihood ratio test.
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param scale a number indicating the tested value of the scale parameter.
#' @param alternative a character string specifying the alternative hypothesis, must be one of "two.sided" (default), "greater" or "less".
#' @return An S3 class containing the test statistic, p value and alternative
#' hypothesis.
#' @source \url{https://en.wikipedia.org/wiki/Likelihood-ratio_test}
#' @examples
#' library(LRTesteR)
#'
#' # Null is true
#' set.seed(1)
#' x <- rgamma(100, shape = 1, scale = 2)
#' gamma_scale_lr_test(x, 2, "two.sided")
#'
#' # Null is false
#' set.seed(1)
#' x <- rgamma(100, shape = 1, scale = 2)
#' gamma_scale_lr_test(x, 1, "greater")
#' @export
gamma_scale_lr_test <- function(x, scale = 1, alternative = "two.sided") {
  if (length(x) < 50) {
    stop("Argument x should have at least 50 data points.")
  }
  if (!is.numeric(x)) {
    stop("Argument x should be numeric.")
  }
  if (length(scale) != 1) {
    stop("Argument scale should have length one.")
  }
  if (!is.numeric(scale)) {
    stop("Argument scale should be numeric.")
  }
  if (scale <= 0) {
    stop("Argument scale should be positive.")
  }
  if (length(alternative) != 1) {
    stop("Argument alternative should have length one.")
  }
  if (!is.character(alternative)) {
    stop("Argument alternative should be a character.")
  }
  if (!(alternative %in% c("two.sided", "less", "greater"))) {
    stop("Argument alternative should be 'two.sided', 'less', or 'greater'")
  }

  get_MLEs <- function(x) {
    # Based on wiki page for gamma distribution.
    # starting points
    s <- log(mean(x)) - mean(log(x))
    shape <- (3 - s + ((s - 3)^2 + 24 * s)^.5) / (12 * s)

    # newton updates
    for (i in 1:10) {
      shape <- shape - (log(shape) - base::digamma(shape) - s) / ((1 / shape) - base::psigamma(shape, deriv = 1))
    }

    scale <- sum(x) / (shape * length(x))
    rate <- 1 / scale
    MLEs <- c(shape, rate)

    return(MLEs)
  }

  MLEs <- get_MLEs(x)
  obs_shape <- MLEs[1]
  obs_rate <- MLEs[2]
  obs_scale <- 1 / obs_rate

  get_profile_shape <- function(x, scale) {
    geo_mean <- function(x) {
      return(exp(mean(log(x))))
    }

    profile_helper <- function(shape) {
      return(base::digamma(shape) - log(geo_mean(x) / scale))
    }

    profile_shape <- stats::uniroot(profile_helper, lower = geo_mean(x) / scale, upper = geo_mean(x) / scale + 1)$root

    return(profile_shape)
  }

  profile_shape <- get_profile_shape(x, scale)

  if (alternative == "two.sided") {
    W <- 2 * (sum(stats::dgamma(x = x, shape = obs_shape, scale = obs_scale, log = TRUE)) -
      sum(stats::dgamma(x = x, shape = profile_shape, scale = scale, log = TRUE)))
    p.value <- stats::pchisq(q = W, df = 1, lower.tail = FALSE)
  }
  else {
    W <- 2 * (sum(stats::dgamma(x = x, shape = obs_shape, scale = obs_scale, log = TRUE)) -
      sum(stats::dgamma(x = x, shape = profile_shape, scale = scale, log = TRUE)))
    W <- sign(obs_scale - scale) * W^.5
    if (alternative == "less") {
      p.value <- stats::pnorm(q = W, lower.tail = TRUE)
    }
    if (alternative == "greater") {
      p.value <- stats::pnorm(q = W, lower.tail = FALSE)
    }
  }

  out <- list(statistic = W, p.value = p.value, alternative = alternative)
  class(out) <- "lrtest"
  return(out)
}

#' Test the rate parameter of a gamma distribution using the likelihood ratio test.
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param rate a number indicating the tested value of the rate parameter.
#' @param alternative a character string specifying the alternative hypothesis, must be one of "two.sided" (default), "greater" or "less".
#' @return An S3 class containing the test statistic, p value and alternative
#' hypothesis.
#' @source \url{https://en.wikipedia.org/wiki/Likelihood-ratio_test}
#' @examples
#' library(LRTesteR)
#'
#' # Null is true
#' set.seed(1)
#' x <- rgamma(100, shape = 1, rate = 1)
#' gamma_rate_lr_test(x, 1, "two.sided")
#'
#' # Null is false
#' set.seed(1)
#' x <- rgamma(100, shape = 1, rate = 2)
#' gamma_rate_lr_test(x, 1, "greater")
#' @export
gamma_rate_lr_test <- function(x, rate = 1, alternative = "two.sided") {
  if (length(x) < 50) {
    stop("Argument x should have at least 50 data points.")
  }
  if (!is.numeric(x)) {
    stop("Argument x should be numeric.")
  }
  if (length(rate) != 1) {
    stop("Argument rate should have length one.")
  }
  if (!is.numeric(rate)) {
    stop("Argument rate should be numeric.")
  }
  if (rate <= 0) {
    stop("Argument rate should be positive.")
  }
  if (length(alternative) != 1) {
    stop("Argument alternative should have length one.")
  }
  if (!is.character(alternative)) {
    stop("Argument alternative should be a character.")
  }
  if (!(alternative %in% c("two.sided", "less", "greater"))) {
    stop("Argument alternative should be 'two.sided', 'less', or 'greater'")
  }

  get_MLEs <- function(x) {
    # Based on wiki page for gamma distribution.
    # starting points
    s <- log(mean(x)) - mean(log(x))
    shape <- (3 - s + ((s - 3)^2 + 24 * s)^.5) / (12 * s)

    # newton updates
    for (i in 1:10) {
      shape <- shape - (log(shape) - base::digamma(shape) - s) / ((1 / shape) - base::psigamma(shape, deriv = 1))
    }

    scale <- sum(x) / (shape * length(x))
    rate <- 1 / scale
    MLEs <- c(shape, rate)

    return(MLEs)
  }

  MLEs <- get_MLEs(x)
  obs_shape <- MLEs[1]
  obs_rate <- MLEs[2]
  obs_scale <- 1 / obs_rate

  get_profile_shape <- function(x, rate) {
    scale <- 1 / rate
    geo_mean <- function(x) {
      return(exp(mean(log(x))))
    }

    profile_helper <- function(shape) {
      return(base::digamma(shape) - log(geo_mean(x) / scale))
    }

    profile_shape <- stats::uniroot(profile_helper, lower = geo_mean(x) / scale, upper = geo_mean(x) / scale + 1)$root

    return(profile_shape)
  }

  profile_shape <- get_profile_shape(x, rate)

  if (alternative == "two.sided") {
    W <- 2 * (sum(stats::dgamma(x = x, shape = obs_shape, rate = obs_rate, log = TRUE)) -
      sum(stats::dgamma(x = x, shape = profile_shape, rate = rate, log = TRUE)))
    p.value <- stats::pchisq(q = W, df = 1, lower.tail = FALSE)
  }
  else {
    W <- 2 * (sum(stats::dgamma(x = x, shape = obs_shape, rate = obs_rate, log = TRUE)) -
      sum(stats::dgamma(x = x, shape = profile_shape, rate = rate, log = TRUE)))
    W <- sign(obs_rate - rate) * W^.5
    if (alternative == "less") {
      p.value <- stats::pnorm(q = W, lower.tail = TRUE)
    }
    if (alternative == "greater") {
      p.value <- stats::pnorm(q = W, lower.tail = FALSE)
    }
  }

  out <- list(statistic = W, p.value = p.value, alternative = alternative)
  class(out) <- "lrtest"
  return(out)
}
