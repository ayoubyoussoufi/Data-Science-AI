#Create a slider input to select values between 0 and 100
########################
########################
library(shiny)
ui = fluidPage(
  sliderInput(inputId =  "num", value =  10,
            label = "Choose a number",step = 5, min = 0, max = 100)

)

server = function(input, output){
  data = reactive({ reactiveValues(data  = rnorm(input$num))})
}

shinyApp(ui = ui, server = server)

#add animation button to the input widget 
########################
########################

ui = fluidPage(
  fluidRow(
    div(style = "display: inline-block;vertical-align:center;",
        actionButton("left", label = "<<")),
    div(style = "display: inline-block;vertical-align:center;",
        sliderInput("num", "Choose a number",
                    min = 0, max = 100, value = 10
        )),
    div(style = "display: inline-block;vertical-align:center;",
        actionButton("right", label = ">>")),
  ),
)
server = function(input, output, session) {
  observeEvent(input$left, {
    updateSliderInput(session, "num", value = input$num -5)
  })
  observeEvent(input$right, {
    updateSliderInput(session, "num", value = input$num + 5)
  })
}

shinyApp(ui = ui, server = server)

#Create an app that compare 2 two simulated datasets with a plot and a hypothesis test
########################
########################
library(shiny)
library(ggplot2)

freqhist <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
  df <- data.frame(
    x = c(x1, x2),
    graph = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )

  ggplot(df, aes(x, colour = graph)) +
    geom_histogram(binwidth = binwidth, size = 1) +
    coord_cartesian(xlim = xlim)
}

t_test <- function(x1, x2) {
  test <- t.test(x1, x2)

  # use sprintf() to format t.test() results compactly
  sprintf(
    "p value: %0.3f\n[%0.2f, %0.2f]",
    test$p.value, test$conf.int[1], test$conf.int[2]
  )
}
ui <- fluidPage(
  fluidRow(
    column(4,
           "Distribution 1",
           numericInput("n1", label = "n", value = 1000, min = 1),
           numericInput("mean1", label = "µ", value = 0, step = 0.1),
           numericInput("sd1", label = "??", value = 0.5, min = 0.1, step = 0.1)
    ),
    column(4,
           "Distribution 2",
           numericInput("n2", label = "n", value = 1000, min = 1),
           numericInput("mean2", label = "µ", value = 0, step = 0.1),
           numericInput("sd2", label = "??", value = 0.5, min = 0.1, step = 0.1)
    ),
    column(4,
           "Frequency Hist",
           numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
           sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
    )
  ),
  fluidRow(
    column(9, plotOutput("hist")),
    column(3, verbatimTextOutput("ttest"))
  )
)
server <- function(input, output) {
  output$hist <- renderPlot({
    x1 <- rnorm(input$n1, input$mean1, input$sd1)
    x2 <- rnorm(input$n2, input$mean2, input$sd2)

    freqhist(x1, x2, binwidth = input$binwidth, xlim = input$range)
  }, res = 96)

  output$ttest <- renderText({
    x1 <- rnorm(input$n1, input$mean1, input$sd1)
    x2 <- rnorm(input$n2, input$mean2, input$sd2)

    t_test(x1, x2)
  })
}
shinyApp(ui = ui, server = server)










