# Example bar plot
par(mar=c(5,2,1,1))#bottom, left, top, right
val1 <- 5
val2 <- 14
barplot(c(val1, val2), xlab="times eaten this month",names.arg=c("cake", "gelato"))