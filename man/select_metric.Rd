% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/select_metric.R
\name{select_metric}
\alias{select_metric}
\title{select_metric}
\usage{
select_metric(messy_v, clean_v)
}
\arguments{
\item{messy_v}{a messy vector of strings}

\item{clean_v}{a vector of strings for messy_v to be matched against}
}
\value{
a string representing the suggested stringdist metric
}
\description{
Uses heuristic algorithm to suggest a stringdist metric from among hamming, lv, osa, dl, lcs, jw
}
\details{
for each metric, measures certainty via the difference between the best matches for each word and the average of all matches for each word
}
\examples{
select_metric(c("aapple", "bamana", "clemtidne"), c("apple", "banana", "clementine"))
}
\seealso{
\code{\link[stringdist]{stringdist}}
}
