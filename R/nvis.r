# nvis
# mplot : multiplot : simple grid of ggplots
# x/y parameter recognizes: "inm", "surface", "volume" keywords
# dataset parameter recognizes: "small", "large" keywords
# not recommended to turn png "on", due to size of multiplot
# recommended ggdetails for "small" skyrme legend:
# geom <- geom_point()
# opt1 <- opts(legend.text=theme_text(size=8))
# opt2 <- opts(legend.key.size = unit(0, "inches"), legend.key = theme_blank())
# ggdetails <- list(geom, opt1, opt2)
#
# NOTE: Because of layer methods, color parameter should not be used if geom_smooth is desired.
# To apply coloring and smooth use following:
# recommended ggdetails for geom_smooth and color, where "FORCES" is desired color variable:
# geom1 <- geom_smooth()
# geom2 <- geom_point(aes_string(colour="FORCES"))
# ggdetails <- list(geom1, geom2)
#
# Parameters:
# dataset : data set to be used, keywords: "small" = skyrme_65, "large" = skyrme_189
# xlist : variables on the horizontal axes in the form of a "string" list
# ylist : variables on the vertical axes in the form of a "string" list
# color : variable to color plots in string format, default is none
# png : name of png file in string format. If "off", doesnt create file. Default: "nvis_mplot.png"
# width : png file pixel dimension, default is 11400
# height : png file pixel dimension, default is 3000
# res : png file resolution, default is 100
# legend : controls legend visibility, default is "on"
# mplot_width : tweak this value to modify plotting area layout width. Default 20
# legend_width : tweak this value to modify legend layout width. Default 2
# ggdetails : additional layer include in the ggplot2 plots, default is geom_point, can be combined in a list for multiple layers
# outliers : Action to remove outliers. Default is "rm" : remove outliers from dataset.
# correlations : Switch to display pair pearson correlation on the title of each plot. Default: "off"
# expressions : If "yes" it will change nvis x/y labels to their expressions, code also expresses if dataset keyword is used.
nvis.mplot <- function(dataset, xlist, ylist, color = "", 
	png="nvis_mplot.png", width = 5000, height = 1500, res = 100,
	mplot_width = 20, legend_width = 2,
	legend = "on",  ggdetails = "default", outliers="rm", correlations="off", expressions="no")
{	
	if(dataset == "small" || dataset == "large")
	{
		dataset <- nvis.keyword(dataset)
		expressions <- "yes"
	}
	if(xlist == "inm" || xlist == "surface" || xlist == "volume")
	{
		xlist <- nvis.keyword(xlist)
		expressions <- "yes"
	}
	if(ylist == "inm" || ylist == "surface" || ylist == "volume")
	{
		ylist <- nvis.keyword(ylist)
		expressions <- "yes"
	}
	if(outliers == "rm")
		dataset <- nvis.rm_outliers(dataset)
		
	xnum <- length(xlist)
	ynum <- length(ylist)
	plotnum <- xnum * ynum
	
	ypos <- 1
	xpos <- 1
	
	if( png != "off")
		png(png, width = width, height = height,  res = res)
	
	grid.newpage()
	#legend configuration
	if(legend == "on")
	{
		legendplot <- ggplot(data = dataset, aes_string(x = xlist[1], y = ylist[1]))
		if(color != "")
			legendplot <- legendplot + aes_string(colour = color)
		# ifelse(color_e != "off", legendplot <- legendplot + aes(colour = color_e),legendplot <- legendplot)
		# if(color_e != "off")
			# legendplot <- legendplot + aes(colour = color_e)
		ifelse(ggdetails != "default", legendplot <- legendplot + ggdetails, legendplot <- legendplot + geom_point())
	
		legendplot <- legendplot + opts(keep="legend_box", legend.position = c(0.5,0.5), legend.justification = "centre")
		
		legendlayout=grid.layout(nrow=1, ncol=2, widths=c(mplot_width,legend_width))
		pushViewport(viewport(layout=legendlayout))		
		pushViewport(viewport(layout.pos.row=1, layout.pos.col=2))
		grid.draw(ggplotGrob(legendplot))
		popViewport()
		pushViewport(viewport(layout.pos.row=1, layout.pos.col=1))
	}
		
	pushViewport(viewport(layout = grid.layout(nrow=ynum, ncol=xnum)))
	
	for(i in 1:plotnum)
	{
		plot <- ggplot(data = dataset, aes_string(x = xlist[xpos], y = ylist[ypos]))
		plot <- plot + opts(legend.position="none")
		
		#color options
		if(color != "")
			plot <- plot + aes_string(colour = color)		
		
		#ggplot layer options
		ifelse(ggdetails != "default", plot <- plot + ggdetails, plot <- plot + geom_point())
		
		if(correlations != "off")
		{
			plot_title <- nvis.correlations(dataset, xlist[xpos], ylist[ypos])
			plot <- plot + opts(title=plot_title)
			plot <- plot + opts(plot.title = theme_text(size=8, face = "plain"))
		}
		
		if(expressions == "yes")
		{
			expressed_x <- nvis.label_expression(xlist[xpos])
			expressed_y <- nvis.label_expression(ylist[ypos])
			plot <- plot + xlab(expressed_x)
			plot <- plot + ylab(expressed_y)
			plot <- plot + opts(axis.title.y=theme_text(angle=0))
		}
		print(plot, vp = vplayout(ypos, xpos))
		
		if(xpos == xnum)
		{
			xpos <- 1
			ypos <- ypos + 1
		} else
			xpos <- xpos + 1
	}	
	
	popViewport()
	
	if( png != "off")
		dev.off()
}

# iplot : Individual plot : Makes a ggplot object that is customized for nvis.
# 
# NOTE: Because of layer methods, color parameter should not be used if geom_smooth is desired.
# To apply coloring and smooth use following:
# recommended ggdetails for geom_smooth and color, where "FORCES" is desired color variable:
# geom1 <- geom_smooth()
# geom2 <- geom_point(aes_string(colour="FORCES"))
# ggdetails <- list(geom1, geom2)
#
# Parameters:
# dataset : data set to be used, keywords: "small" = skyrme_65, "large" = skyrme_189
# xvar : x axis variable in string format
# yvar : y axis variable in string format
# color : variable to color plots in string format, default is none
# png : name of png file in string format. Default is "off", doesnt create file. If "on": "nvis_mplot.png"
# width : png file pixel dimension, default is 1280
# height : png file pixel dimension, default is 1024
# res : png file resolution, default is 200
# legend : controls legend visibility, default is "on"
# ggdetails : additional layer include in the ggplot2 plots, default is geom_point, can be combined in a list for multiple layers
# outliers : Action to remove outliers. Default is "rm" : remove outliers from dataset.
# correlations : Switch to display pair pearson correlation on the title of each plot. Default: "off"
# expressions : If "yes" it will change nvis x/y labels to their expressions, code also expresses if dataset keyword is used.
nvis.iplot <- function(dataset, x, y, color = "", 
	png="off", width = 1280, height = 1024,  res = 150,
	legend = "on",  ggdetails = "default", outliers="rm", correlations="off", expressions="no")
{	
	if(dataset == "small" || dataset == "large")
	{
		dataset <- nvis.keyword(dataset)
		expressions <- "yes"
	}
	if(outliers == "rm")
		dataset <- nvis.rm_outliers(dataset)

	if(png != "off")
	{
		if(png == "on")
			png <- "nvis_iplot.png"
		png(png, width = width, height = height,  res = res)
	}
	
	plot <- ggplot(data = dataset, aes_string(x = x, y = y))
	
	# color options
	if(color != "")
		plot <- plot + aes_string(colour = color)
		
	#ggplot layer options
	ifelse(ggdetails != "default", plot <- plot + ggdetails, plot <- plot + geom_point())
	
	# legend options
	if(legend != "on")
		plot <- plot + opts(legend.position="none")
	
	# pearson correlation title
	if(correlations != "off")
	{
		plot_title <- nvis.correlations(dataset, x, y)
		plot <- plot + opts(title = plot_title)
		plot <- plot + opts(plot.title = theme_text(size=10, face = "plain"))
	}
	
	# x/y labels expressions
	if(expressions == "yes")
	{
		expressed_x <- nvis.label_expression(x)
		expressed_y <- nvis.label_expression(y)
		plot <- plot + xlab(expressed_x)
		plot <- plot + ylab(expressed_y)
		plot <- plot + opts(axis.title.y=theme_text(angle=0))
	}
	
	if(png != "off")
	{
		print(plot)
		dev.off()
	}
	
	plot	
}

# ggcplot : ggcolpairs plot : Makes a ggcolpairs matrix plot that is customized for nvis.
#
# Parameters:
# dataset : data set to be used, keywords: "small" = skyrme_65, "large" = skyrme_189
# xlist : variables on the horizontal axes in the form of a "string" list
# ylist : variables on the vertical axes in the form of a "string" list
# color : variable to color plots in string format, default is none
# ggdetails : additional layer include in the ggplot2 plots, default is geom_point, can be combined in a list for multiple layers
# margins : space surrounding the plots, default is lines based, 0.1 for top and right and -0.7 for bottom and left
# png : name of png file in string format. If "off", doesnt create file. Default: "nvis_mplot.png"
# width : png file pixel dimension, default is 11400
# height : png file pixel dimension, default is 3000
# res : png file resolution, default is 100
# legend : controls legend visibility, default is "on"
# outliers : Action to remove outliers. Default is "rm" : remove outliers from dataset.
nvis.ggcplot <- function(dataset, xlist, ylist, color = "default",
	ggdetails = "default", margins="default", title="",
	png="on", width = 1280, height = 1024, res = 150,	
	legend = "on", outliers="rm")
{
	if(dataset == "small" || dataset == "large")
		dataset <- nvis.keyword(dataset)
	if(xlist == "inm" || xlist == "surface" || xlist == "volume")
		xlist <- nvis.keyword(xlist)
	if(ylist == "inm" || ylist == "surface" || ylist == "volume")
		ylist <- nvis.keyword(ylist)
		
	if(outliers == "rm")
		dataset <- nvis.rm_outliers(dataset)
	
	plot <- ggcolpairs(dataset = dataset, xlist = xlist, ylist = ylist, colour = color, 
				ggdetails = ggdetails, margins = margins, title = title, legend = legend)
	
	if(png != "off")
	{
		if(png == "on")
			png <- "nvis_ggcplot.png"
		png(png, width = width, height = height,  res = res)
		print(plot)
		dev.off()
	}
	
	plot
}
