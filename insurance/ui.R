
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Insurance Claims Prediction"),
  p("Insert, in the left panel, the information related to a car insurance. The probability of a claim will be shown on the rigth panel. "),
  p("Also in the right panel, there is a plot showing the claims distribution by type of vehicle (the 'vehicle body' selected)"),
  p("(Source code at https://github.com/enrique-repulles/data-products-shiny)"),

  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("veh_value", "Vehicle Value", 0,40000,10000,1000),
       selectInput("veh_body", "Vehicle Body", c("BUS", "CONVT", "COUPE","HBACK","HDTOP","MCARA","MIBUS","PANVN","RDSTR","SEDAN","STNWG","TRUCK","UTE")),
       sliderInput("veh_age","Vehicle Age", 1,4,2),
       selectInput("gender","Driver Gender",c("Female"="F","Male"="M")),
       selectInput("area","Area", c("Northeast"="A","Midwest"="B","South"="C","West"="D","other US territories"="E" ,"Canada"="F")),
       selectInput("agecat","Driver Age", c("18-29"="1","30-39"="2","40-49"="3","50-59"="4","60-69"="5" ,"70+"="6"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(verticalLayout(
      h3("Claims prediction"),
       textOutput("claimProbability"),
      h3("Claims distribution plot"),
       textOutput("claimsPlotLabel"), 
       plotOutput("claimsPlot")
    ))
  )
))
