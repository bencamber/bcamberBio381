# Exploring continuous distributions
# 20 Feb 2020


# uniform -----------------------------------------------------------------

library(ggplot2)
library(MASS)

qplot(x=runif(n=1000,min=1,max=6),
              color=I("black"),
              fill=I("blue"))

qplot(x=sample(1:6,size=1000,replace=TRUE),
      fill=I("red"))

# normal ------------------------------------------------------------------

norm<-rnorm(n=100,mean=2,sd=2)
qplot(x=norm)
toss<-norm[norm>0] # changes the mean and sd of the simulated mean
qplot(toss)
mean(toss)
sd(toss)
# instead of throwing out values, just do a different distribution (gamma in this case)

# gamma distribution ------------------------------------------------------
# use for continuous data greater than zero
gamma<-rgamma(n=10000,shape=1,scale=0.1)
qplot(gamma)

# gamma with shape=1 makes exponential curve with mean equal to the shape*scale
# increasing shape parameter makes distribution appear more normal
gamma2<-rgamma(n=1000,shape=20,scale=1)
qplot(gamma2)
# variance = (shape*scale)^2


# beta  -------------------------------------------------------------------

# continuous but bounded between 0 and 1. Great for distribution of a probability
# analagous to binomaial, but with a continous distribution of possible values. 

# parameters of beta are shape1 (number of successes+1) and shape2 (number of failures+1)


# bayesian maximum likelihood: p(parameters|data) -> probability of parameters given data

# beta with 3 heads and 0 tails
beta<-rbeta(n=1000,shape1=4,shape2=1) # toss a coin 8 times and get 4 heads 4 tails. What's the underlying probability of the coin?
qplot(beta)

# what if you never flipped the coin? 
beta<-rbeta(n=1000,shape1=.2,shape2=.1)
qplot(beta)


# estimate parameters from data -------------------------------------------

x<-rnorm(1000,mean=92.5,sd=2.5)
qplot(x)

fitdistr(x,"gamma") # fits distribution of x (normal) to a gamma distribution
sim<-rgamma(n=1000,shape=1375,rate=14.89)
qplot(sim)
qplot(x)
