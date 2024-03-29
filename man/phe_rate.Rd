% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Rates.R
\name{phe_rate}
\alias{phe_rate}
\title{Calculate Rates using phe_rate}
\usage{
phe_rate(data, x, n, type = "full", confidence = 0.95, multiplier = 1e+05)
}
\arguments{
\item{data}{the data.frame containing the data to calculate rates for,
pre-grouped if proportions required for group aggregates; unquoted string;
no default}

\item{x}{field name from data containing the rate numerators (eg observed
number of events); unquoted string; no default}

\item{n}{field name from data containing the rate denominators (eg
populations); unquoted string; no default}

\item{type}{defines the data and metadata columns to be included in output;
can be "value", "lower", "upper", "standard" (for all data) or "full" (for
all data and metadata); quoted string; default = "full"}

\item{confidence}{the required level of confidence expressed as a number
between 0.9 and 1 or a number between 90 and 100 or can be a vector of 0.95
and 0.998, for example, to output both 95 percent and 99.8 percent percent CIs; numeric;
default 0.95}

\item{multiplier}{the multiplier used to express the final values (eg 100,000
= rate per 100,000); numeric; default 100,000}
}
\value{
When type = "full", returns the original data.frame with the
following appended: rate, lower confidence limit, upper confidence limit,
confidence level, statistic and method
}
\description{
Calculates rates with confidence limits using Byar's (1) or exact (2) CI method.
}
\section{Notes}{
 For numerators >= 10 Byar's method (1) is applied using the
internal byars_lower and byars_upper functions.  For
small numerators Byar's method is less accurate and so an exact method (2)
based on the Poisson distribution is used.
}

\examples{
# ungrouped data frame
df <- data.frame(area = rep(c("Area1","Area2","Area3","Area4"), each=3),
                 obs = c(NA,82,9,48, 6500,8200,10000,10000,8,7,750,900),
                 pop = rep(c(100,10000,10000,10000), each=3))

phe_rate(df, obs, pop)
phe_rate(df, obs, pop, type="standard")
phe_rate(df, obs, pop, confidence=99.8, multiplier=100)

# grouped data frame
library(dplyr)
dfg <- df \%>\% group_by(area)
phe_rate(dfg, obs, pop)

}
\references{
(1) Breslow NE, Day NE. Statistical methods in cancer research,
volume II: The design and analysis of cohort studies. Lyon: International
Agency for Research on Cancer, World Health Organisation; 1987. \cr
(2) Armitage P, Berry G. Statistical methods in medical research (4th edn).
Oxford: Blackwell; 2002.
}
\seealso{
Other PHEindicatormethods package functions: 
\code{\link{assign_funnel_significance}()},
\code{\link{calculate_ISRate}()},
\code{\link{calculate_ISRatio}()},
\code{\link{calculate_funnel_limits}()},
\code{\link{calculate_funnel_points}()},
\code{\link{phe_dsr}()},
\code{\link{phe_life_expectancy}()},
\code{\link{phe_mean}()},
\code{\link{phe_proportion}()},
\code{\link{phe_quantile}()},
\code{\link{phe_sii}()}
}
\concept{PHEindicatormethods package functions}
