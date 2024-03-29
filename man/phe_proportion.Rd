% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Proportions.R
\name{phe_proportion}
\alias{phe_proportion}
\title{Calculate Proportions using phe_proportion}
\usage{
phe_proportion(data, x, n, type = "full", confidence = 0.95, multiplier = 1)
}
\arguments{
\item{data}{a data.frame containing the data to calculate proportions for, pre-grouped if proportions required for
group aggregates; unquoted string; no default}

\item{x}{field name from data containing the observed numbers of cases in the sample meeting the required condition
(the numerator for the proportion); unquoted string; no default}

\item{n}{field name from data containing the number of cases in the sample (the denominator for the proportion);
unquoted string; no default}

\item{type}{defines the data and metadata columns to be included in output;
can be "value", "lower", "upper", "standard" (for all data) or "full" (for
all data and metadata); quoted string; default = "full"}

\item{confidence}{the required level of confidence expressed as a number
between 0.9 and 1 or a number between 90 and 100. The vector c(0.95, 0.998)
can also be passed to output both 95 percent and 99.8 percent CIs, or an NA
value can be passed if no confidence intervals are required.; numeric; default 0.95}

\item{multiplier}{the multiplier used to express the final values (eg 100 = percentage); numeric; default 1}
}
\value{
When type = "full", returns the original data.frame with the following appended:
proportion, lower confidence limit, upper confidence limit, confidence level, statistic and method
}
\description{
Calculates proportions with confidence limits using Wilson Score method (1,2).
}
\section{Notes}{
 Wilson Score method (2) is applied using the internal wilson_lower
and wilson_upper functions. \cr \cr
The percentage argument was deprecated in v1_1_0, please use multiplier argument instead
}

\examples{

# ungrouped data frame
df <- data.frame(area = rep(c("Area1","Area2","Area3","Area4"), each=3),
                 numerator = c(NA,82,9,48, 6500,8200,10000,10000,8,7,750,900),
                 denominator = rep(c(100,10000,10000,10000), each=3))

phe_proportion(df, numerator, denominator)
phe_proportion(df, numerator, denominator, confidence=99.8)
phe_proportion(df, numerator, denominator, type="standard")
phe_proportion(df, numerator, denominator, confidence = c(0.95, 0.998))

# grouped data frame
library(dplyr)
dfg <- df |> group_by(area)
phe_proportion(dfg, numerator, denominator, multiplier=100)


}
\references{
(1) Wilson EB. Probable inference, the law of succession, and statistical
inference. J Am Stat Assoc; 1927; 22. Pg 209 to 212. \cr
(2) Newcombe RG, Altman DG. Proportions and their differences. In Altman
DG et al. (eds). Statistics with confidence (2nd edn). London: BMJ Books;
2000. Pg 46 to 48.
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
\code{\link{phe_quantile}()},
\code{\link{phe_rate}()},
\code{\link{phe_sii}()}
}
\concept{PHEindicatormethods package functions}
