getwd()

library(shiny)

##below script tests connection by making a blank gui
#ui<- fluidPage()
#server<- function(input, output){}
#shinyApp(ui=ui, server=server)


#Testing Paw Preference: The Binomial Test web app code.
if (interactive()){

  ui <- fluidPage(
    titlePanel("Paw Preference"),
      mainPanel(
        tabsetPanel(
          tabPanel("Directions", 
                   fluidRow(h4("Directions"),
                            h5("Watch this video of Catistician Dr. WPJ using his particle accelerator: link"),
                            h5("Count how many times WPJ boops the ball with his right or left paw"),
                            h5("We will assume that each time he boops the ball, he does so completely independently of the direction he booped the ball before; each boop is an independent trial"))
                            ),
          tabPanel("Your Data", 
                            sidebarPanel(numericInput("LR", "Left to Right Boops", 0, min=0, max=50),
                                             numericInput("RL", "Right to Left Boops", 0, min=0, max=50),
                                             h4("Boop Sum"),
                                             h5(textOutput("Sum")),
                                             h4("Proportion of Left to Right Boops"),
                                             h5(textOutput("propLR")),
                                             h4("Proportion of Right to Left Boops"),
                                             h5(textOutput("propRL"))
                                      ),
                            mainPanel(plotOutput("boopplot"))
                    ),
          tabPanel("Hypothesis Testing", 
                   sidebarPanel(h4("Does WPJ have a paw preference?"),
                                h5("Null Hypothesis: No"),
                                h6("He is equally likely to use both paws"),
                                h5("Alternative Hypothesis: Yes"),
                                h6("He has a paw preference"),
                                h5("Binomial Test of our hypothesis"),
                                h6("paw-value ="),
                                h4(textOutput("test")),
                                h6("A p-value of <0.05 causes us to reject the null hypothesis"),
                                width=4
                                ),
                   mainPanel(plotOutput("BinDist")
                   )))))

  server<- function(input, output){
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
              names.arg = c("L-to-R", "R-to-L"),
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
         barplot(x,names.arg=0:sum,xlab="Number of LR Boops", ylab="Probability of Outcome", main="Binomial Distribution")
       )
     })
  }

  shinyApp(ui=ui, server=server)}
