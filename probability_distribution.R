# probability learnins
# 18 Feb 2020

# d denotes probability density function
# p denotes cumulative probability distribution
# q denotes quantile function (inverse of p function)
# r denotes random number generator

library(ggplot2)
library(MASS)


# poisson distribution ----------------------------------------------------

# discrete 0 to infinity
# a single parameter: lambda > 0 (continuous)
# lambda is a constant rate parameter (observations/unit time or /unit area)

# d function for probability density
hits<-0:10
vec<-dpois(x=hits,lambda=1)
qplot(x=hits,
      y=vec,
      geom="col",
      color=I("black"), # color and fill require I (identity) function here because ggPlot thinks you want to make different groups with different colors
      fill=I("magenta")
      )

hits<-0:10
vec<-dpois(x=hits,lambda=4.4)
qplot(x=hits,
      y=vec,
      geom="col",
      color=I("black"),
      fill=I("magenta"))
sum(vec)

# for a poisson with lambda=2, what is the probability that a single draw will yield a zero?
dpois(x=0,lambda=2)

hits<-0:10
vec<-ppois(q=hits,lambda=2)
qplot(x=hits,
      y=vec,
      geom="col",
      color=I("black"),
      fill=I("orange"))
# for poisson with lambda=2, what is the probability that single random draw will yield x<=1?
ppois(q=1,lambda=2)
p1<-dpois(x=1,lambda=2)
p2<-dpois(x=0,lambda=2)
p1+p2

# the q function is the reverse of p
qpois(p=0.5,lambda=2.5)

# simulate a poisson to get actual values
ranpois<-rpois(n=1000,lambda=2.5)
qplot(x=ranpois,
      color=I("black"),
      fill=I("blue"))
quantile(x=ranpois,probs=c(0.025,0.975))


# binomial distribution ---------------------------------------------------

# describes a single process with dichotomous outcome (yes,no)
# p=probability of outcome (successes/iterations)
# parameters: size=number of trials, x=distribution of possible outcomes
# outcome x is bounded by 0 and size

# density function for binomial
hits<-0:10
vec<-dbinom(x=hits,size=10,prob=0.5)
qplot(x=hits,y=vec,geom="col",color=I("black"),
      fill=I("blue"))

# what is the probability of getting 5 heads out of 10 tosses

dbinom(x=5,size=10,prob=0.5)

# biased coin
hits<-0:10
vec<-dbinom(x=hits,size=10,prob=0.85)
qplot(x=hits,y=vec,geom="col",color=I("black"),
      fill=I("blue"))

# p function for tail probability
pbinom(q=4,size=9,prob=0.5)

# what is a 95% confidence interval for 100 trials of a coin with p=0.7?
qbinom(p=c(0.027,0.975),size=100,prob=0.7)

# how does this compare to a sample interval for real data?
mycoins<-rbinom(n=50,
                size=100,
                prob=0.5)
qplot(x=mycoins,
      color=I("black"),
      fill=I("blue"))
quantile(x=mycoins, probs=c(0.025,0.975))


# negative binomial -------------------------------------------------------

# number of failures in a series of Bernouli trials with p=probability of success before a targeted number of successes (=size)
# generates a distribution that is more heterogeneous (overdispersed) than Poisson 

hits<-0:40
vec<-dnbinom(x=hits,size=5,prob=0.5) # how many tails will I get until I get five heads on a fair coin?
vec
qplot(x=hits,y=vec,geom="col")


# geometric series where number of successes=1
# each bar is a constant fraction of the one that came before it with prob= 1-p
vec<-dnbinom(x=hits,
             size=1,
             prob=0.1)
qplot(x=hits,y=vec,geom="col")

# alternatively specify mean = mu of distribution and size
# this gives us a Poisson distribution with a lambda value that varies

# dispersion parameter is the shape parameter from a gamma distribution
#as it increases, the variance gets smaller
nbiran<-rnbinom(n=1000,
                size=0.1,
                mu=5)
qplot(nbiran)
