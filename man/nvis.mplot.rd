\name{nvis.mplot}
\alias{nvis.mplot}
\title{nvis multiplot}
\usage{nvis.mplot(dataset, xlist, ylist, color = "", 
	export="off", width = "default", height = "default", res = 100,
	mplot_width = 20, legend_width = 2,
	legend = "on",  ggdetails = "default", outliers="rm", correlations="off", expressions="no")}
\description{multiplot: simple grid of ggplots}
\details{
x/y parameter recognizes: "inm", "surface", "volume" keywords
dataset parameter recognizes: "small", "large" keywords

recommended ggdetails for "small" skyrme legend:
geom <- geom_point()
opt1 <- opts(legend.text=theme_text(size=8))
opt2 <- opts(legend.key.size = unit(0, "inches"), legend.key = theme_blank())
ggdetails <- list(geom, opt1, opt2)
}
\keyword{hplot}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}}
\arguments{
\item{dataset}{data set to be used. keywords: "small" = skyrme_65, "large" = skyrme_189}
\item{xlist}{list of desired x columns in "string" format}
\item{ylist}{list of desired y columns in "string" format}
\item{color}{column to for which to colour all plots in "string" format, if coloring by another method use the ggdetails parameter}
\item{export}{switch to generate export file: "off", "png", "pdf", "on" . filename: "nvis_mplot.pdf" or "nvis_mplot.png". default is "off"}
\item{width}{file width dimension, png in pixels, pdf in inches}
\item{height}{file height dimension, png in pixels, pdf in inches}
\item{res}{png file resolution, default is 100}
\item{mplot_width}{tweak this value to modify plotting area layout width. Default 20}
\item{legend_width}{tweak this value to modify legend layout width. Default 2}
\item{legend}{string representing legend visibility, default is on}
\item{ggdetails}{ggplot2 options to be included in the creation of all plots, can be combined in a list for multiple layers}
\item{outliers}{Action to remove outliers. Default is "rm" : remove outliers from dataset}
\item{correlations}{Switch to display pair pearson correlation on the title of each plot. Default: "off"}
\item{expressions}{If "yes" it will change nvis x/y labels to their expressions, code also expresses if dataset keyword is used}
}
\examples{
# example of use
pxlist <- c("RHO", "M0i", "L")
pylist <- c("CDR0", "CT1", "CJ0")
nvis.mplot(dataset = "small",pxlist,pylist,color="FORCES", export="off")
}
