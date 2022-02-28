#This function gives an interactive plot f(binwith)

library(ggplot2)

freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-13, 13)) {
  df <- data.frame(
    x = c(x1, x2),
    g = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )
  
  ggplot(df, aes(x, colour = g)) +
    geom_freqpoly(binwidth = binwidth, size = 1) +
    coord_cartesian(xlim = xlim)
}
##################################################################

ui <- fluidPage(
  sliderInput("obs", "Number of observations", 0, 1000, 500),
  actionButton("goButton", "Go!"),
  plotOutput("distPlot")
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Take a dependency on input$goButton. This will run once initially,
    # because the value changes from NULL to 0.
    input$goButton
    # Use isolate() to avoid dependency on input$obs
    dist <- isolate(rnorm(input$obs))
    hist(dist)
  })
}
shinyApp(ui, server)

#################################################################
library(shiny)
shinyApp(
  ui = fluidPage(
    fluidRow(
      div(style = "display: inline-block;vertical-align:center;",
          actionButton("left", label = "<<")),
      div(style = "display: inline-block;vertical-align:center;",
          sliderInput("obs", "Number of observations:",
                      min = 0, max = 1000, value = 500
          )),
      div(style = "display: inline-block;vertical-align:center;",
          actionButton("right", label = ">>")),
    ),
    plotOutput("distPlot")
  ),
  # Server logic
  server = function(input, output, session) {
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })
    observeEvent(input$left, {
      updateSliderInput(session, "obs", value = input$obs - 10)
    })
    observeEvent(input$right, {
      updateSliderInput(session, "obs", value = input$obs + 10)
    })
  }
)
shinyApp(ui, server)





