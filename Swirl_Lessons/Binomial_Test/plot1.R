plot.binomial.distribution<- function(n,p){
  x<- dbinom(0:n, size=n, prob=p)
  return(
    barplot(x,names.arg=0:n,xlab="Number of Desired Outcomes", ylab="Probability of Outcome", main="Binomial Distribution")
  )
}