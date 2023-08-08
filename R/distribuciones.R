# Tomadas de https://github.com/LaplacesDemonR/LaplacesDemon/blob/master/R/distributions.R
# Paquete LaplacesDemon de R,
#
#
# Mezclas univariadas de normales
#
dnormm <- function(x, p, mu, sigma, log=FALSE)
{
  if(missing(x)) stop("x is a required argument.")
  x <- as.vector(x)
  n <- length(x)
  if(missing(p)) stop("p is a required argument.")
  p <- as.vector(p)
  if(any(p <= 0) | any(p > 1)) stop("p must be in (0,1].")
  if(sum(p) != 1) stop("p must sum to 1 for all components.")
  m <- length(p)
  p <- matrix(p, n, m, byrow=TRUE)
  if(missing(mu)) stop("mu is a required argument.")
  mu <- as.vector(mu)
  if(!identical(m, length(mu)))
    stop("p and mu differ in length.")
  mu <- matrix(mu, n, m, byrow=TRUE)
  if(missing(sigma)) stop("sigma is a required argument.")
  sigma <- as.vector(sigma)
  if(!identical(m, length(sigma)))
    stop("p and sigma differ in length.")
  sigma <- matrix(sigma, n, m, byrow=TRUE)
  dens <- matrix(dnorm(x, mu, sigma, log=TRUE), n, m)
  dens <- dens + log(p)
  if(log == TRUE) dens <- apply(dens, 1, logadd)
  else dens <- rowSums(exp(dens))
  return(dens)
}
pnormm <- function(q, p, mu, sigma, lower.tail=TRUE, log.p=FALSE)
{
  n <- length(q)
  m <- length(p)
  q <- matrix(q, n, m)
  p <- matrix(p, n, m, byrow=TRUE)
  mu <- matrix(mu, n, m, byrow=TRUE)
  sigma <- matrix(sigma, n, m, byrow=TRUE)
  cdf <- matrix(pnorm(q, mu, sigma, lower.tail=lower.tail,
                      log.p=log.p), n, m)
  if(log.p == FALSE) cdf <- rowSums(cdf * p)
  else stop("The log.p argument does not work yet.")
  return(cdf)
}
rnormm <- function(n, p, mu, sigma)
{
  if(missing(p)) stop("p is a required argument.")
  p <- as.vector(p)
  if(any(p <= 0) | any(p > 1)) stop("p must be in (0,1].")
  if(sum(p) != 1) stop("p must sum to 1 for all components.")
  m <- length(p)
  p <- matrix(p, n, m, byrow=TRUE)
  if(missing(mu)) stop("mu is a required argument.")
  mu <- as.vector(mu)
  if(!identical(m, length(mu)))
    stop("p and mu differ in length.")
  if(missing(sigma)) stop("sigma is a required argument.")
  sigma <- as.vector(sigma)
  if(!identical(m, length(sigma)))
    stop("p and sigma differ in length.")
  if(any(sigma <= 0)) stop("sigma must be positive.")
  z <- rcat(n, p)
  x <- rnorm(n, mean=mu[z], sd=sigma[z])
  return(x)
}

rcat <- function(n, p){
  if(is.vector(p)) {
    x <- as.vector(which(rmultinom(n, size=1, prob=p) ==
                           1, arr.ind=TRUE)[, "row"])
  }
  else {
    d <- dim(p)
    n <- d[1]
    k <- d[2]
    lev <- dimnames(p)[[2]]
    if(!length(lev)) lev <- 1:k
    z <- colSums(p)
    U <- apply(p, 1, cumsum)
    U[,k] <- 1
    un <- rep(runif(n), rep(k,n))
    x <- lev[1 + colSums(un > U)]}
  return(x)
}
