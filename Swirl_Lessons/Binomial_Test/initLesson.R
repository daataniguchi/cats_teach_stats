# Code placed in this file fill be executed every time the
      # lesson is started. Any variables created here will show up in
      # the user's working directory and thus be accessible to them
      # throughout the lesson.
plot.binomial.distribution<- function(n,p){
  x<- dbinom(0:n, size=n, prob=p)
  return(
    barplot(x,names.arg=0:n,ylim=c(0,1.0),xlab="Number of Desired Outcomes", ylab="Probability of Outcome", main="Binomial Distribution")
  )
}