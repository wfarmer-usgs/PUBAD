% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/approxQ.R
\name{approxQ}
\alias{approxQ}
\title{Interpolate and Extrapolate Streamflow Probabilities along Flow Duration
Curve}
\usage{
approxQ(pts, fdc)
}
\arguments{
\item{pts}{A numerical vector containing a time series of streamflow
probabilities.  The probabilities can be either nonexceedance or exceedance
probabilities, as long as they correspond to the probabilities in
\code{fdc$p} described below.}

\item{fdc}{A data frame of two numerical variables.  The first, \code{p},
contains streamflow probabilities corresponding to the streamflow values in
the second, \code{q}.  The probabilities can be either nonexceedance or
exceedance probabilities, as long as they correspond to the probabilities
in \code{pts} described above.  Non-positive values of \code{q} will be
removed because of the conversion to common logarithms.}
}
\value{
A list of three elements: \item{pts}{The input time series of
  streamflow probabilites.} \item{fdc}{The input flow duration curve, with
  addition of the common logarithm of streamflow (\code{ql}) and the standard
  nomral quantiles of the probabilities (\code{z}).} \item{targetFlow}{The
  resulting conversion of \code{pts} into streamflows by interpolating and
  extrapolating along the given flow duration curve.}
}
\description{
The function \code{approxQ} interpolates and extrapolates a time
  series of probabilities along a given set of quantiles from a flow duration
  curve.
}
\details{
The interpolation is accomplished by converting streamflows to the
common logarithms of streamflow and converting the probabilites to standard
normal quantlies.  The \code{approx} is used to then linearly
interpolate the standard normal quantiles against the common logarithms of
streamflow.

Probabilites in \code{pts} that are beyond the maximum value in \code{fdc$p}
are extrapolated by extending the line between the two greatest quantiles of
the flow duration curve.

Similarly, probabilites in \code{pts} that are below the minimum value in
\code{fdc$p} are extrapolated by extending the line between the two smallest
quantiles of the flow duration curve.
}
\examples{
set.seed(1)
pts <- runif(100)
fdc <- data.frame(
  p = seq(from = 0.01, to = 0.99, by = 0.01)
)
fdc$q <- qnorm(fdc$p, mean = 5, sd = 2)

result <- approxQ(pts = pts, fdc = fdc)
}
