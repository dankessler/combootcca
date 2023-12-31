% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/funcs.R
\name{gen_sigma}
\alias{gen_sigma}
\title{Generate random covariance matrix for CCA}
\usage{
gen_sigma(p, q, rho_max = 0.9, rho_gap = 0.1, rho_decay = 1, gamma21 = NULL)
}
\arguments{
\item{p}{Dimension of X random variable}

\item{q}{Dimension of Y random variable}

\item{rho_max}{The largest canonical correlation (must be between 0 and 1)}

\item{rho_gap}{The gap between the largest and second-largest canonical
correlation}

\item{rho_decay}{The rate at which the canonical correlations (after the
first) decay. Should be a strictly positive number. Small values will give
very gradual decay and poor spacing, very large values will asymptote at 0
very quickly and also give poor spacing. See details for more information.}

\item{gamma21}{User-specified value for the second element of the first
canonical direction associated with Y. If NULL (default) then this will be
iid N(0, 1) like the rest of Gamma.}
}
\value{
A square, positive definite matrix with p+q rows/cols
}
\description{
Generate a square covariance matrix for use with CCA.
}
\details{
For CCA simulation studies, it is convenient to be able to generate a
"random" covariance matrix. The current approach proceeds by constructing
Gamma (the canonical directions associated with Y), Beta (the canonical
directions associated with X), and rho (the canonical correlations
themselves). It then inverts the CCA formulation (using cancor_inv_cov) so
that the resultant covariance matrix (Sigma) would, if subjected to CCA
(e.g., with cancor_cov), yield Gamma, Beta, and rho.

Both Gamma and Beta are constructed with iid standard normal entries,
although the second coordinate of the first canonical direction associated
with Y can be manually specified (as the argument gamma21).

Next, a sequence of the canonical correlations are generated. Currently, the
largest canonical correlation will be set to rho_max. The remaining
canonical correlations will begin at rho_max - rho_gap and then decay
exponentially according to (rho_max - rho_gap)^((t - 1) * rho_decay), where
t is an integer that indicates the index of the canonical correlation.

It is contingent on the user to ensure that rho_max is in (0, 1) and that
rho_max minus rho_gap is strictly greater than 0.

Note: If p \neq q, then the inverse mapping is not unique. See the
documentation of cancor_inv_cov for details of how this is handled.
}
\author{
Dan Kessler
}
