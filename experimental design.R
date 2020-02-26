# experimental design
# 20 feb 2020


# Regression analysis --------------------------------------------------------------

n<-50 # number of observations
a<-runif(n) # 50 random uniformly distributed numbers
b<-runif(n)
c<-5.5+a*10
id<-seq_len(n)
data<-data.frame(id,a,b,c)
print(data)
str(data)

# regression model
model<-lm(c~a,data=data)
summary(model) # actually what we want !!!
summary(model)$coefficients

z<-unlist(summary(model))
z
reg_sum<-list(intercept=z$coefficients1, # all this shit is obtained by tediously going through all the coefficients and seeing what they match
              slope=z$coefficients2,
              intercept_p=z$coefficients7,
              slope_p=z$coefficients8,
              r2=z$r.squared)

library(ggplot2)
reg_plot<-ggplot(data=data,
                 aes(x=a,y=c)) + geom_point()+
                  stat_smooth(method=lm,se=0.95)
reg_plot


# basic ANOVA -------------------------------------------------------------

n_group<-3
n_name <- c("control","treat1","treat2")
n_size<-c(12,17,9) # number of observations in each of the three groups. 
n_mean<-c(60,60,60)
n_sd<-c(5,5,5) # ideally the sd for each group is the same
t_group<-rep(n_name,n_size)
t_group
table(t_group)


id<-1:(sum(n_size))
res_var<-c(rnorm(n=n_size[1],mean=n_mean[1],sd=n_sd[1]),
           rnorm(n=n_size[2],mean=n_mean[2],sd=n_sd[2]),
           rnorm(n=n_size[3],mean=n_mean[3],sd=n_sd[3]))
ano_data<-data.frame(id,t_group,res_var)
str(ano_data)

ano_model<-aov(res_var~t_group,data=ano_data)
print(ano_model)
z<-summary(ano_model)
str(Z)
str(z)
aggregate(res_var~t_group,data=ano_data,FUN = mean)
unlist(z)
unlist(z)[7]
ano_sum<- list(Fval=unlist(z)[7],
               probF=unlist(z)[9])
ano_sum

# ggplot for anova data ---------------------------------------------------
ano_plot<-ggplot(data=ano_data,aes(x=t_group,y=res_var,fill=t_group) + geom_boxplot())
ano_plot


# data frame for logistic regression --------------------------------------

# discrete y variable (0,1) and continuous x variable 
xvar<-sort(rgamma(n=200,shape=5,scale=5))
yvar<-sample(rep(c(0,1),each=100),prob=seq_len(200))
head(yvar)
l_reg_data<-data.frame(xvar,yvar)


# logistic regression code ------------------------------------------------

l_reg_model<-glm(yvar~xvar,
                 data=l_reg_data,
                 family=binomial(link=logit))

l_reg_plot <- ggplot(data=l_reg_data,
                   aes(x=xvar,y=yvar)) +
                    geom_point() +
                     stat_smooth(method=glm,
                     method.args=list(family=binomial))
print(l_reg_plot
      )


# contingency table data --------------------------------------------------

# both x and y variables are discrete 
# integer counts of different groups
vec1<-c(50,66,22)
vec2<-c(120,22,30)
datamatrix<-rbind(vec1,vec2)
rownames(datamatrix)<-c("cold","warm")
colnames(datamatrix)<-c("aphaenogaster","camponotus","crematogaster")
str(datamatrix)
datamatrix


# simple association test -------------------------------------------------

print(chisq.test(datamatrix))


# plotting association data -----------------------------------------------

# base r graphics
mosaicplot(x=datamatrix,
           col=c("blue","yellow","red"),
           shade=FALSE)
barplot(height=datamatrix,beside=TRUE,col=c("green","tomato"))


# ggplot graph ------------------------------------------------------------
library(dplyr)
dframe<-as.data.frame(datamatrix)
dframe<-cbind(dframe,list(Treatment=c("cold","warm")))
dframe<-gather(dframe,key=Species,Aphaenogaster:Crematogaster,value=Counts)
head(dframe)
p<-ggplot(data=dframe,
          aes(x=Species,y=Counts,fill=Treatment)) +
          geom_bar(stat="identity",
                   position="dodge",
                   color=I("black")) +
                    scale_fill_manual(values=c("blue","coral"))
print(p)
