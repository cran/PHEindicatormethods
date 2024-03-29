% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Funnels.R
\name{calculate_funnel_limits}
\alias{calculate_funnel_limits}
\title{Calculate control limits for funnel plots}
\usage{
calculate_funnel_limits(
  data,
  numerator,
  denominator,
  rate,
  type = "full",
  multiplier = NULL,
  statistic = NULL,
  ratio_type = NULL,
  rate_type = NULL,
  years_of_data = NULL
)
}
\arguments{
\item{data}{a data.frame containing the data to calculate control limits for;
unquoted string; no default}

\item{numerator}{field name from data containing the observed numbers of
cases in the sample meeting the required condition (the numerator or
observed counts for the control limits); unquoted string; no default}

\item{denominator}{field name from data containing the population(s) in the
sample (the denominator or expected counts for the control limits);
unquoted string; no default}

\item{rate}{field name from data containing the rate data when creating
funnels for a Crude or Directly Standardised Rate; unquoted string; no
default}

\item{type}{defines the data and metadata columns to be included in output;
"standard" (for all data) or "full" (for all data and metadata); quoted
string; default = "full"}

\item{multiplier}{the multiplier used to express the final values (eg 100 =
percentage); numeric; no default}

\item{statistic}{type of statistic to inform funnel calculations. Acceptable
values are "proportion", "ratio" or "rate"; string; no default}

\item{ratio_type}{if statistic is "ratio", specify either "count" or "isr"
(indirectly standardised ratio); string; no default}

\item{rate_type}{if statistic is "rate", specify either "dsr" or "crude";
string; no default}

\item{years_of_data}{number of years the data represents; this is required
for statistic = "rate"; numeric; no default}
}
\value{
returns the original data.frame with the following appended: lower
0.025 limit, upper 0.025 limit, lower 0.001 limit, upper 0.001 limit and
baseline average
}
\description{
Calculates control limits adopting a consistent method as per the PHE
Fingertips Technical Guidance: https://fingertips.phe.org.uk/profile/guidance/supporting-information/PH-methods
}
\examples{
library(dplyr)
set.seed(123)
df <- data.frame(obs = sample(200, 19 * 2 * 5 * 4, replace = TRUE),
                 pop = sample(10000:20000, 19 * 2 * 5 * 4, replace = TRUE))
df \%>\%
    calculate_funnel_limits(obs, pop, statistic = "proportion", multiplier = 100)

}
\seealso{
Other PHEindicatormethods package functions: 
\code{\link{assign_funnel_significance}()},
\code{\link{calculate_ISRate}()},
\code{\link{calculate_ISRatio}()},
\code{\link{calculate_funnel_points}()},
\code{\link{phe_dsr}()},
\code{\link{phe_life_expectancy}()},
\code{\link{phe_mean}()},
\code{\link{phe_proportion}()},
\code{\link{phe_quantile}()},
\code{\link{phe_rate}()},
\code{\link{phe_sii}()}
}
\author{
Matthew Francis
}
\concept{PHEindicatormethods package functions}
