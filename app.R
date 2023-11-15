library(shiny)
library(tidyverse)
coffee <- read_csv("https://bit.ly/gacttCSV")

ui <- fluidPage(
  plotOutput()
)

server <- function(input, output) {
  output$age_histogram <- renderPlot({
    ggplot(coffee, aes()) +
      geom_histogram()
  })
}

shinyApp(ui = ui, server = server)
