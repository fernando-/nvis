# Keyword function to match "string" description to proper object of analysis
# 
# Parameters:
# key: string keyword to be deciphered
nvis.keyword <- function(key)
{
	# x/y keywords
	if(key == "inm")
		answer  <- c("RHO","W","K","M0i","A","L","DK","M1i")
	if(key == "surface")
		answer  <- c("CDR0","CDR1","CDJ0","CDJ1","CJ0","CJ1")
	if(key == "volume")
		answer  <- c("C00","C10","C0D","C1D","CT0","CT1")
	
	#dataset keywords
	if(key == "small")
		answer  <- skyrme_65
	if(key == "large")
		answer  <- skyrme_189
	
	return(answer)
}

# Removes outliers from dataset
# NOTE: Edit this function to modify what is considered as an outlier
# 
# Parameters:
# dataset: skyrme dataset which will be analyzed and outliers will be removed
nvis.rm_outliers <- function(dataset)
{
	#----------inm properties--------------
	#--------------------------------------
	#  RHO
	dataset <- dataset[(dataset[,"RHO"] > 0.140) & (dataset[,"RHO"] < 0.165),]
	#  W
	dataset <- dataset[(dataset[,"W"] > -16.2) & (dataset[,"W"] < -15.5),]
	#  K
	dataset <- dataset[(dataset[,"K"] > 190) & (dataset[,"K"] < 375),]
	#  M0
	dataset <- dataset[(dataset[,"M0"] > 0.5) & (dataset[,"M0"] < 1.3),]
	#  A
	dataset <- dataset[(dataset[,"A"] > 22.5) & (dataset[,"A"] < 40),]
	#  L
	dataset <- dataset[(dataset[,"L"] > -75) & (dataset[,"L"] < 150),]
	#  DK
	dataset <- dataset[(dataset[,"DK"] > -600) & (dataset[,"DK"] < 200),]
	#  M1
	dataset <- dataset[(dataset[,"M1"] > 0.45) & (dataset[,"M1"] < 1.1),]
	#----------surface parameters----------
	#--------------------------------------
	#  CDR0
	dataset <- dataset[(dataset[,"CDR0"] > -130) & (dataset[,"CDR0"] < -30),]
	#  CDR1
	dataset <- dataset[(dataset[,"CDR1"] > -175) & (dataset[,"CDR1"] < 100),]
	#  CDJ0
	dataset <- dataset[(dataset[,"CDJ0"] > -122) & (dataset[,"CDJ0"] < -70),]
	#  CDJ1
	dataset <- dataset[(dataset[,"CDJ1"] > -41) & (dataset[,"CDJ1"] < 0),]
	#  CJ0
	dataset <- dataset[(dataset[,"CJ0"] > -25) & (dataset[,"CJ0"] < 400),]
	#  CJ1
	dataset <- dataset[(dataset[,"CJ1"] > -40) & (dataset[,"CJ1"] < 70),]
	#----------volume parameters-----------
	#--------------------------------------
	#  C00
	dataset <- dataset[(dataset[,"C00"] > -1150) & (dataset[,"C00"] < -350),]
	#  C10
	dataset <- dataset[(dataset[,"C10"] > 500) & (dataset[,"C10"] < 1200),]
	#  C0D
	dataset <- dataset[(dataset[,"C0D"] > 0) & (dataset[,"C0D"] < 1000),]
	#  C1D
	dataset <- dataset[(dataset[,"C1D"] > -1500) & (dataset[,"C1D"] < 500),]
	#  CT0
	dataset <- dataset[(dataset[,"CT0"] > -20) & (dataset[,"CT0"] < 110),]
	#  CT1
	dataset <- dataset[(dataset[,"CT1"] > -65) & (dataset[,"CT1"] < 70),]
	
	return (dataset)
}

# Calculates Pearson correlation between xvar and yvar in a dataset
# Returns a description string to be used in plot title.
#
# Parameters:
# dataset: data set object containing xvar and yvar as string column names
# xvar: x variable in string format
# yvar: y variable in string format
nvis.correlations <- function(dataset, xvar, yvar)
{
	for(i in 1:ncol(dataset))
	{
		if(xvar==names(dataset[i]))
			xpos = i
		if(yvar==names(dataset[i]))
			ypos = i
	}
		
	cor_title <- paste("Pearson correlation =",round(cor(dataset[xpos],dataset[ypos], method = "pearson"),2))
	cor_title
}

# Returns LaTeX style expresion of nvis variable for better display during plotting.
# 
# Parameters:
# tempvar: nvis related variable in string format
nvis.label_expression <- function (tempvar) 
{	
	expressvar <- tempvar
	
	#volume
	if(tempvar == "C00")
		expressvar <- expression(C[paste("00")]^rho)
	if(tempvar == "C10")
		expressvar <- expression(C[paste("10")]^rho)
	if(tempvar == "C0D")
		expressvar <- expression(C[paste("0D")]^rho)
	if(tempvar == "C1D")
		expressvar <- expression(C[paste("1D")]^rho)
	if(tempvar == "CT0")
		expressvar <- expression(C[paste("0")]^tau)
	if(tempvar == "CT1")
		expressvar <- expression(C[paste("1")]^tau)
	
	#surface
	if(tempvar == "CDR0")
		expressvar <- expression(C[paste("0")]^paste(Delta,rho))
	if(tempvar == "CDR1")
		expressvar <- expression(C[paste("1")]^paste(Delta,rho))
	if(tempvar == "CDJ0")
		expressvar <- expression(C[paste("0")]^paste(Delta,J))
	if(tempvar == "CDJ1")
		expressvar <- expression(C[paste("1")]^paste(Delta,J))
	if(tempvar == "CJ0")
		expressvar <- expression(C[paste("0")]^J)
	if(tempvar == "CJ1")
		expressvar <- expression(C[paste("1")]^J)
	
	#inm
	if(tempvar == "gamma")
		expressvar <- expression(gamma)		
	if(tempvar == "P")
		expressvar <- expression(P)
	if(tempvar == "RHO")
		expressvar <- expression(rho)
	if(tempvar == "W")
		expressvar <- expression(W)
	if(tempvar == "K")
		expressvar <- expression(K)
	if(tempvar == "M0")
		expressvar <- expression(M[0])
	if(tempvar == "A")
		expressvar <- expression(a[sym])
	if(tempvar == "L")
		expressvar <- expression(L)
	if(tempvar == "DK")
		expressvar <- expression(paste(Delta,K))
	if(tempvar == "M1")
		expressvar <- expression(M[1])	
	if(tempvar == "M0i")
		expressvar <- expression(M[paste("sC")]^paste("*","N","M",sep=""))
	if(tempvar == "M1i")
		expressvar <- expression(M[paste("vC")]^paste("*","N","M",sep=""))			
		
	return (expressvar)
}
