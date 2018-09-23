#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plyr)

# Define server logic
shinyServer(function(input, output) {
  output$Sum<- renderText({input$LR + input$RL})
  output$propLR<- renderText({input$LR/(input$LR+input$RL)})
  output$propRL<- renderText({input$RL/(input$LR+input$RL)})
  output$test<- renderText({
    boops<- c(input$LR, input$RL)
    stat<-(binom.test(x=boops,p=0.5))
    stat$p.value
    })
  output$boopplot<- renderPlot({
    boops<- c(input$LR, input$RL)
    barplot(boops,
          main = "Count of Boops",
          names.arg = c("Left", "Right"),
          xlab = "Direction",
          ylab = "Count",
          col= c("#56B4E9", "#009E73")
          )
    })
  output$BinDist<- renderPlot({
    LR<- input$LR;
    RL<- input$RL;
    sum<- LR+RL;
    f<- ((LR+RL)/2);
    x<- dbinom(0:sum, size=sum, prob=0.5)
    return(
      barplot(x,names.arg=0:sum, xlab="Number of Left-Pawed Boops", ylab="Probability of Outcome", main="Binomial Distribution", col=ifelse(x>0.05, "#56B4E9", "#009E73"))
      )
    })
  })
