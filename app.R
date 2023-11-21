library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)

ui <- fluidPage( 
  titlePanel("Palmer Penguins Body Mass"),
  "This shiny app explores three penguin species' body mass in grams across three Antarctic islands using the palmerpenguins package, credit to: 
    Horst AM, Hill AP, Gorman KB (2020). palmerpenguins: Palmer Archipelago (Antarctica) penguin data. R package version 0.1.0. 
    https://allisonhorst.github.io/palmerpenguins/. doi:10.5281/zenodo.3960218.",
  br(),
  br(),
  "Images are courtesy of Creative Commons and the attributed photographers.",

# Feature 1: I added an interactive sidebar to the app that allows the user to select which island (Torgersen, Biscoe or Dream) 
# they wish to view the body mass data by penguin species for that works for both the boxplot and the table. This is useful as it allows
# the user to separate the data by island, making it easier to see the differences between islands and also between penguin species. Islands
# are interesting to compare across species as they can have drastically different food availability, sizes, etc.
  
  sidebarLayout(
    sidebarPanel(
      selectInput("islandInput", "island", 
                  choices = c("Torgersen", "Biscoe", "Dream"),
                  selected = "Torgersen"), 
      br(),
      
# Feature 2: I added an image that I created from Creative Commons free-to-use (with attribution) licensed images of each species of penguin
# found within the palmerpenguins dataset - Adelie, Gentoo and Chinstrap penguins, and labeled each image with the species. I did this to
# make it easier for the user to visualize the actual species for which they are viewing the data, which will hopefully make the app and the
# data more engaging.
      
      img(src='penguins.png', height = "100%", width = "100%",  align = "middle")
                 ),
    mainPanel(
      
# Feature 3: I added tabs to separate the boxplot and the table into two separate tabs within the main panel, allowing the user to select
# which data visualization they would like to view at any given time. This is useful because it cleans up the app interface and also makes
# it more interactive for the viewer.
      
      tabsetPanel(
        tabPanel("Boxplot", plotOutput("body_mass_plot")),
        tabPanel("Table", DT::dataTableOutput("penguins_table"))
      )
    )
  )
)

server <- function(input, output) {
  penguins_filtered <- reactive({
    penguins %>%
      filter(island == input$islandInput)
  })
  
  output$body_mass_plot <- renderPlot({
    ggplot(penguins_filtered(), aes(species, body_mass_g)) +
      geom_boxplot()
  })
  
  output$penguins_table <- DT::renderDataTable({
    penguins_filtered()
  })
}

shinyApp(ui = ui, server = server)