\name{nvis.iplot}
\alias{nvis.iplot}
\title{nvis iplot}
\usage{nvis.iplot(dataset, x, y, color = "", 
	export="off", width = "default", height = "default",  res = 150,
	legend = "on",  ggdetails = "default", outliers="rm", correlations="off", expressions="no")}
\description{Individual plot: makes a ggplot object customized for nvis.}
\details{
NOTE: Because of layer methods, color parameter should not be used if geom_smooth is desired.
To apply coloring and smooth use the following:
Recommended ggdetails for geom_smooth and color, where "FORCES" is desired color variable:
geom1 <- geom_smooth()
geom2 <- geom_point(aes_string(colour="FORCES"))
ggdetails <- list(geom1, geom2)
}
\keyword{hplot}
\author{Fernando Fuentes \email{fuentes.f4@gmail.com}, George Ostrouchov \email{ostrouchovg@ornl.gov}}
\arguments{
\item{dataset}{data set to be used. keywords: "small" = skyrme_65, "large" = skyrme_189}
\item{x}{x axis variable in string format}
\item{y}{y axis variable in string format}
\item{color}{column to for which to colour all plots in "string" format, if coloring by another method use the ggdetails parameter}
\item{export}{switch to generate export file: "off", "png", "pdf", "on" . filename: "nvis_iplot.pdf" or "nvis_iplot.png". default is "off"}
\item{width}{file width dimension, png in pixels, pdf in inches}
\item{height}{file height dimension, png in pixels, pdf in inches}
\item{res}{png file resolution, default is 100}
\item{legend}{string representing legend visibility, default is on}
\item{ggdetails}{ggplot2 options to be included in the creation of all plots, can be combined in a list for multiple layers}
\item{outliers}{Action to remove outliers. Default is "rm" : remove outliers from dataset}
\item{correlations}{Switch to display pair pearson correlation on the title of each plot. Default: "off"}
\item{expressions}{If "yes" it will change nvis x/y labels to their expressions, code also expresses if dataset keyword is used}
}
\examples{
# example of use
nvis.iplot(dataset="small", x="CDR0", y="M0i", color="FORCES")
}
