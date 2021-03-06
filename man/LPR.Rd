\name{LPR}
\alias{LPR}
\alias{PartRidge}
\alias{ci}
\alias{escv.glmnet}
\alias{mls}
\alias{mylasso}
\alias{mylassomls}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Lasso and Partial Ridge
}
\description{
This package contains a function called "LPR" to estimate coefficients using "Lasso and Partial Ridge" method and to calculate confidence intervals through bootstrap.
}
\usage{
LPR(x, y, lambda2, B, type.boot=c("residual","paired"), alpha = 0.05)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
   \item{x}{
  	explanatory variables
}
  \item{y}{
  	dependent variable
}
  \item{lambda2}{
  	tuning parameter for partial ridge, suggested value is \eqn{1/n}
}
  \item{B}{
  	the times of bootstrap
}
  \item{type.boot}{
  	the type of bootstrap, "paired" or "residual"
}
  \item{alpha}{
  	confidence level
}
}
\value{
\item{lambda.opt}{
		chosen tuning parameter for LASSO 
}
    \item{Beta}{
    	regression coefficients estimated by LASSO
}
    \item{Beta.LPR}{
     regression coefficients estimated by LASSO and Partial Ridge(LPR)
}
    \item{selectset}{
    	coefficients set selected by LASSO
    	}
    \item{interval.LPR}{ 
    confidence interval through bootstrap
}
}
\examples{
#generate dataset	
set.seed(2015)
n <- 100    
p <- 250
B <- 100
s <- 10
rho <- 0.5
z <- matrix(rnorm(n*p),ncol=p)
x <- matrix(0,n,p)
x[,1] <- z[,1]
for(j in 2:p){
  x[,j] <- rho*x[,j-1]+sqrt(1-rho^2)*z[,j]
}

#beta is decaying
beta <- rep(0,p)
ind.s <- sample(1:p,s)
beta[ind.s] <- rnorm(s,1,sqrt(0.001))
for( j in setdiff(1:p,ind.s) ){
  beta[j]<-1/(j+3)^2
}
#generate y
epsilon <- rep(0,n)
epsilon <- rnorm(n,0,0.1)
y <- x\%*\%beta + epsilon
#use LPR
LPR.obj <- LPR(x, y, 1/n, B, type.boot="paired", alpha=0.05)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.