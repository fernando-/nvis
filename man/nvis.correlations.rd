\name{nvis.correlations}
\alias{nvis.correlations}
\title{nvis correlations}
\usage{nvis.correlations(dataset, xvar, yvar)}
\description{Calculates Pearson correlation between xvar and yvar in a dataset}
\details{
Returns a description string to be used in plot title.
}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{methods}
\arguments{
\item{dataset}{data set object containing xvar and yvar as string column names}
\item{xvar}{x variable in string format}
\item{yvar}{y variable in string format}
}
\examples{\dontrun{
# example of use
nvis.correlations(skyrme_65, "CDR0", "M0i")
#returns:
#[1] "Pearson correlation = -0.92"
}}
