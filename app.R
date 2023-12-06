library(shiny)
library(tidyverse)
library(palmerpenguins)
library(DT)
library(bslib)
library(thematic)

ui <- function(request) {
  fluidPage(
  theme = bs_theme(version = , bootswatch = "sketchy"),
  
  titlePanel(h1("Palmer Penguins Body Mass")),
  "This shiny app explores three penguin species' body mass in grams across three Antarctic islands using the palmerpenguins package, credit to: 
    Horst AM, Hill AP, Gorman KB (2020). palmerpenguins: Palmer Archipelago (Antarctica) penguin data. R package version 0.2.0. 
    https://allisonhorst.github.io/palmerpenguins/. doi:10.5281/zenodo.3960218.",
  br(),
  br(),
  "Images are courtesy of Creative Commons and the attributed photographers.",
  br(),
  br(),

# Assignment B3 Feature 1: I added an interactive sidebar to the app that allows the user to select which island (Torgersen, Biscoe or Dream) 
# they wish to view the body mass data by penguin species for that works for both the boxplot and the table. This is useful as it allows
# the user to separate the data by island, making it easier to see the differences between islands and also between penguin species. Islands
# are interesting to compare across species as they can have drastically different food availability, sizes, etc.
  
  sidebarLayout(
    sidebarPanel(
      h4("Select an Antarctic Island to view it's penguin body mass data!"),
      selectInput("islandInput", "island", 
                  choices = c("Torgersen", "Biscoe", "Dream"),
                  selected = "Torgersen"),
      selectInput("xinput", "x axis",
                  choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"), 
                  selected = "flipper_length_mm"),
      selectInput("yinput", "y axis",
                  choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"),
                  selected = "body_mass_g"),
      br(),
      
# Assignment B3 Feature 2: I added an image that I created from Creative Commons free-to-use (with attribution) licensed images of each species of penguin
# found within the palmerpenguins dataset - Adelie, Gentoo and Chinstrap penguins, and labeled each image with the species. I did this to
# make it easier for the user to visualize the actual species for which they are viewing the data, which will hopefully make the app and the
# data more engaging.
      
      img(src='penguins.png', height = "100%", width = "100%",  align = "middle"),

      br(),
      br(),

# Assignment B4 Feature 1: I added a button that downloads the PalmerPenguins dataset that this used in this Shinyapp. This is a really helpful
# addition to this webpage because it allows the users to download the dataset that is being displayed through online so that they can work
# with the csv data file themselves via easy and quick access.

      downloadButton("downloadData", "Download Penguins Dataset"),
      ),

  mainPanel(
      
# Assignment B3 Feature 3: I added tabs to separate the boxplot and the table into two separate tabs within the main panel, allowing the user to select
# which data visualization they would like to view at any given time. This is useful because it cleans up the app interface and also makes
# it more interactive for the viewer.
      
      tabsetPanel(
        tabPanel(h4("Boxplot"),
                 plotOutput("body_mass_plot"),
                 br(),
                 br(),
                 
# Assignment B4 Feature 2: I added the bookmark button to the plot tab of Shiny app so that people are able to bookmark a specific version of my webpage
# to share with other people or save. For example, if you select to view the Dream island data you can bookmark this and send the URL to someone and they will open the app to those exact settings.
# This is quite helpful for the sharing of this data. 
         
                 bookmarkButton(
                   label = "Bookmark these settings!",
                   title = "Bookmark the current state of the application to share with others or save.")),

        tabPanel(h4("Table"), DT::dataTableOutput("penguins_table")),
        tabPanel(h4("Scatterplot"),
                 plotOutput("penguins_scatterplot"))
       )
     )
   )
 )
}

server <- function(input, output) {
  thematic::thematic_shiny()
  
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

# Assignment B4 Feature 3: I added a scatterplot to my app with interactive x and y axes that allow the user to compare the correlation 
# between flipper length, bill length, bill depth and body mass. This is a super useful visualization of the trends in the penguins, and 
# because I am still also using the reactive dataset that filters by island, you can compare these trends across islands to see if they
# are similar or not.
  
output$penguins_scatterplot <- renderPlot({
    ggplot(penguins_filtered(), aes_string(x = input$xinput, y = input$yinput)) +
    geom_point(size = 3, color = "orange")
})
  
  penguinsdata <- penguins
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("penguinsdata", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(penguinsdata, file)
    }
  )
}

enableBookmarking("url")
shinyApp(ui = ui, server = server)