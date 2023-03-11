setwd("D:/Desktop/DataScienceMSc/ProcessDataR")

library(shiny)
library(ggplot2)
library(dplyr)

data <- read.csv("movies.csv")
ui <- fluidPage(
  titlePanel("movies data Distribution"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins","Number of bins:",min = 1,max = 50,value = 30),
      radioButtons("typeInput", "Movie Type",
                   choices = c("Adventure", "Comedy", "Action", "Drama","Black Comedy","Romantic Comedy"),
                   selected = "Comedy"),
      selectInput("distributionInput", "Distributor",
                  choices = c("Universal", "Walt Disney", "Lionsgate","Sony Pictures")),
      textOutput("txt"),
      dataTableOutput("results1")
    ),
    mainPanel(
      plotOutput("plothist"),
      fluidRow(splitLayout(
        cellWidths = c("50%", "50%"),
      plotOutput("plotbox"),
      plotOutput("plotbar"))),
      br(), br(),
      verbatimTextOutput("summary"),
      dataTableOutput("results")
    )
  )
)
server <- function(input, output) {
  
  output$plothist <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- data[,8]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    ggplot() + geom_histogram(aes(data$Tickets_Sold),bins = input$bins, color='blue', fill='black')
  })
  output$plotbox <- renderPlot({
    ggplot(data) + geom_boxplot(aes(x =data$Tickets_Sold , y =data$Gross_Sales), fill = 'lightblue')
    
  })
  output$plotbar <- renderPlot({
    ggplot(data) + geom_bar(aes(Genre),bins = 10)+
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  })
  output$results <- renderDataTable({
    filtered <-
      data %>%
      filter(
             Genre == input$typeInput,
             Distributor == input$distributionInput
      )
  })
  output$txt <- renderText({

    paste("The dataset has:", nrow(data),"rows and", ncol(data),"columns")})
  
  output$results1 <- renderDataTable({
    avg_calcul <- function(x,y){
      aggregate(x ~ y, data , mean)
    }
    avg_calcul(data$Tickets_Sold,data$Genre)
  })
  

  }



shinyApp(ui = ui, server = server)