\name{nvis.ggcplot}
\alias{nvis.ggcplot}
\title{nvis ggcplot}
\usage{nvis.ggcplot(dataset, xlist, ylist, color = "default",
	ggdetails = "default", margins="default", title="",
	export="png", width = "default", height = "default", res = 150,	
	legend = "on", outliers="rm")}
\description{ggcolpairs plot: makes a ggcolpairs matrix plot that is customized for nvis}
\details{
xlist/ylist parameter recognizes: "inm", "surface", "volume" keywords
dataset parameter recognizes: "small", "large" keywords
}
\keyword{hplot}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\arguments{
\item{dataset}{data set to be used. keywords: "small" = skyrme_65, "large" = skyrme_189}
\item{xlist}{list of desired x columns in "string" format}
\item{ylist}{list of desired y columns in "string" format}
\item{color}{column to for which to colour all plots in "string" format, if coloring by another method use the ggdetails parameter}
\item{ggdetails}{ggplot2 options to be included in the creation of all plots, can be combined in a list for multiple layers}
\item{margins}{space surrounding the plots, default is lines based, 0.1 for top and right and -0.4 for bottom and left}
\item{title}{string title of the resulting matrix plot}
\item{export}{switch to generate export file: "off", "png", "pdf", "on" . filename: "nvis_ggcplot.pdf" or "nvis_ggcplot.png". default is "png"}
\item{width}{file width dimension, png in pixels, pdf in inches}
\item{height}{file height dimension, png in pixels, pdf in inches}
\item{res}{png file resolution, default is 150}
\item{legend}{string representing legend visibility, default is on}
\item{outliers}{Action to remove outliers. Default is "rm" : remove outliers from dataset}
}
\examples{
# example of use
pxlist <- c("RHO", "M0i", "L")
pylist <- c("CDR0", "CT1", "CJ0")
nvis.ggcplot(dataset = "small",pxlist,pylist, color="FORCES", export="off", legend="off")
}
