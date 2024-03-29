% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ISRate.R
\name{calculate_ISRate}
\alias{calculate_ISRate}
\title{Calculate Indirectly Standardised Rates using calculate_ISRate}
\usage{
calculate_ISRate(
  data,
  x,
  n,
  x_ref,
  n_ref,
  refpoptype = "vector",
  type = "full",
  confidence = 0.95,
  multiplier = 1e+05,
  observed_totals = NULL
)
}
\arguments{
\item{data}{data.frame containing the data to be standardised, pre-grouped if
multiple ISRs required; unquoted string; no default}

\item{x}{field name from data containing the observed number of events for
each standardisation category (eg ageband) within each grouping set (eg
area). Alternatively, if not providing age breakdowns for observed events,
field name from observed_totals containing the observed number of events
within each grouping set ; unquoted string; no default}

\item{n}{field name from data containing the populations for each
standardisation category (eg ageband) within each grouping set (eg area);
unquoted string; no default}

\item{x_ref}{the observed number of events in the reference population for
each standardisation category (eg age band); unquoted string referencing a
numeric vector or field name from data depending on value of refpoptype; no
default}

\item{n_ref}{the reference population for each standardisation category (eg
age band); unquoted string referencing a numeric vector or field name from
data depending on value of refpoptype; no default}

\item{refpoptype}{whether x_ref and n_ref have been specified as vectors or a
field name from data; quoted string "field" or "vector"; default = "vector"}

\item{type}{defines the data and metadata columns to be included in output;
can be "value", "lower", "upper", "standard" (for all data) or "full" (for
all data and metadata); quoted string; default = "full"}

\item{confidence}{the required level of confidence expressed as a number
between 0.9 and 1 or a number between 90 and 100 or can be a vector of 0.95
and 0.998, for example, to output both 95 percent and 99.8 percent percent CIs; numeric;
default 0.95}

\item{multiplier}{the multiplier used to express the final values (eg 100,000
= rate per 100,000); numeric; default 100,000}

\item{observed_totals}{data.frame containing total observed events for each
group, if not provided with age-breakdowns in data. Must only contain the
count field (x) plus grouping columns required to join to data using the
same grouping column names; default = NULL}
}
\value{
When type = "full", returns a tibble of observed events, expected
events, indirectly standardised rate, lower confidence limit, upper
confidence limit, confidence level, statistic and method for each grouping
set
}
\description{
Calculates indirectly standardised rates with confidence limits using Byar's
(1) or exact (2) CI method.
}
\section{Notes}{
 User MUST ensure that x, n, x_ref and n_ref vectors are all
ordered by the same standardisation category values as records will be
matched by position. \cr  \cr For numerators >= 10 Byar's method (1) is
applied using the internal byars_lower and byars_upper functions.  For
small numerators Byar's method is less accurate and so an exact method (2)
based on the Poisson distribution is used. \cr  \cr This function directly
replaced phe_isr which was fully deprecated in package version 2.0.0 due to
ambiguous naming
}

\examples{
library(dplyr)
df <- data.frame(indicatorid = rep(c(1234, 5678, 91011, 121314), each = 19 * 2 * 5),
                 year = rep(2006:2010, each = 19 * 2),
                 sex = rep(rep(c("Male", "Female"), each = 19), 5),
                 ageband = rep(c(0,5,10,15,20,25,30,35,40,45,
                                 50,55,60,65,70,75,80,85,90), times = 10),
                 obs = sample(200, 19 * 2 * 5 * 4, replace = TRUE),
                 pop = sample(10000:20000, 19 * 2 * 5 * 4, replace = TRUE))

refdf <- data.frame(refcount = sample(200, 19, replace = TRUE),
                    refpop = sample(10000:20000, 19, replace = TRUE))

## calculate multiple ISRs in single execution
df \%>\%
    group_by(indicatorid, year, sex) \%>\%
    calculate_ISRate(obs, pop, refdf$refcount, refdf$refpop)

## execute without outputting metadata fields
df \%>\%
    group_by(indicatorid, year, sex) \%>\%
    calculate_ISRate(obs, pop, refdf$refcount, refdf$refpop, type="standard", confidence=99.8)

## calculate 95\% and 99.8\% CIs in single execution
df \%>\%
    group_by(indicatorid, year, sex) \%>\%
    calculate_ISRate(obs, pop, refdf$refcount, refdf$refpop, confidence = c(0.95, 0.998))

## Calculate ISR when observed totals aren't available with age-breakdowns
observed_totals <- data.frame(indicatorid = rep(c(1234, 5678, 91011, 121314), each = 10),
                       year = rep(rep(2006:2010, each = 2),4),
                       sex = rep(rep(c("Male", "Female"), each = 1),20),
                       observed = sample(1500:2500, 40))

df \%>\%
    group_by(indicatorid, year, sex) \%>\%
    calculate_ISRate(observed, pop, refdf$refcount, refdf$refpop,
    observed_totals = observed_totals)


}
\references{
(1) Breslow NE, Day NE. Statistical methods in cancer research,
volume II: The design and analysis of cohort studies. Lyon: International
Agency for Research on Cancer, World Health Organisation; 1987. \cr \cr
(2) Armitage P, Berry G. Statistical methods in medical research (4th edn).
Oxford: Blackwell; 2002.
}
\seealso{
Other PHEindicatormethods package functions: 
\code{\link{assign_funnel_significance}()},
\code{\link{calculate_ISRatio}()},
\code{\link{calculate_funnel_limits}()},
\code{\link{calculate_funnel_points}()},
\code{\link{phe_dsr}()},
\code{\link{phe_life_expectancy}()},
\code{\link{phe_mean}()},
\code{\link{phe_proportion}()},
\code{\link{phe_quantile}()},
\code{\link{phe_rate}()},
\code{\link{phe_sii}()}
}
\concept{PHEindicatormethods package functions}
