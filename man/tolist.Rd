% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tolist.R
\name{tolist}
\alias{tolist}
\title{List of EVs}
\usage{
tolist(regimes, regm.indx, vars, ranges, leaps_list)
}
\arguments{
\item{regimes}{The flow regimes list from \code{\link{compile.vars}}}

\item{regm.indx}{The index to which flow regime is to be used}

\item{vars}{The number of variables in a candidate model}

\item{ranges}{The ranges index list corresponding to regimes}

\item{leaps_list}{Output from \code{\link{compute.leaps.for}}}
}
\value{
A list of subsets of EVs (y), their ranks (rank),
and the full set of EVs for each quantile
}
\description{
A sub-function used by \code{\link{compile.vars}}.
}
\details{
Lorem ipsum...
}
