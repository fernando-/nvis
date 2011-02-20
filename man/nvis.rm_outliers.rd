\name{nvis.rm_outliers}
\alias{nvis.rm_outliers}
\title{nvis remove outliers}
\usage{nvis.rm_outliers(dataset)}
\description{Removes outliers from dataset}
\details{
This function removes the rows of a dataset that do not comply with certain range of values according to columns. 
Edit this function to change what is considered as an outlier.
}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{methods}
\arguments{
\item{dataset}{skyrme dataset which will be analyzed and outliers will be removed}
}
\examples{\dontrun{
# example of use
new_skyrme <- nvis.rm_outliers(skyrme_189)
}}
