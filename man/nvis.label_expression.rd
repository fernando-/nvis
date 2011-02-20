\name{nvis.label_expression}
\alias{nvis.label_expression}
\title{nvis label expression}
\usage{nvis.label_expression(tempvar)}
\description{Returns LaTeX style expresion of nvis variable for better display during plotting.}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\keyword{methods}
\arguments{
\item{tempvar}{nvis related variable in string format}
}
\examples{\dontrun{
# example of use
nvis.label_expression("CDR0")
# returns:
# expression(C[paste("0")]^paste(Delta, rho))
}}
