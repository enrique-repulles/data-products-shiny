library(shiny)
library(caret)
library(e1071)


# Data preparation
dataCar<-read.csv("data/insuranceCarData.csv")
dataCar$agecat <- factor(dataCar$agecat)
dataCar$clm <- factor(dataCar$clm)
values <- createDataPartition(dataCar$clm, p=.3,list=FALSE)
training <- dataCar[values,]
testing <- dataCar[-values,]


pred <- function (veh_value, veh_body , veh_age , gender , area ,agecat)
{
  data<-data.frame(veh_value, exposure=.5 , veh_body , veh_age , gender , area ,agecat)
  model.fit<-train (clm ~ veh_value + exposure + veh_body + veh_age + gender + area + agecat , data=training, method="rpart")
  pred<-predict(model.fit, data,type = "prob")
  round(pred[[1]]+rnorm(n = 1, mean=0, sd=0.05), digits=4)
}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  

output$claimProbability <- renderText({
    paste("Claim probability : ",pred(input$veh_value/10000, input$veh_body , input$veh_age , input$gender , input$area ,input$agecat))
  })
   
  output$claimsPlot <- renderPlot({
    
    
    plotData<-dataCar[dataCar$veh_body==input$veh_body,]
    ggplot(plotData, aes(agecat,claimcst0)) +geom_col()
    
  })
  
  output$claimsPlotLabel<-renderText({paste("Claims distribution for vehicles of type ",input$veh_body)})
  
})
