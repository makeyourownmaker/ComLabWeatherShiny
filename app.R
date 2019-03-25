
library(shiny)
library(ggplot2)
library(markdown)
library(data.table)

source("linked_scatter.R")

cammet <- readRDS("data/CamMetCleanish.RData")


ui <- shinyUI(fluidPage(

  navbarPage("Cambridge Weather",
    tabPanel("Plot",
      sidebarLayout(
        sidebarPanel(
          helpText("Explore ", tags$a(href = "https://www.cl.cam.ac.uk/research/dtg/weather/", 
                                      "ComLab"),
                   "weather measurements:"),
          selectInput("year", 
             strong("Choose year"), 
             choices  = yearChoices,
             selected = "2019"),
          selectInput("selectX", 
             strong("Choose x variable"), 
             choices  = plotChoices,
             selected = "temperature"),
          selectInput("selectY", 
             strong("Choose y variable"), 
             choices  = plotChoices,
             selected = "dew.point")
        ),
    
        mainPanel(
          plotOutput("plot")
        )
      )
    ),
    
    tabPanel("Advanced",
      textOutput("summary"),
      linkedScatterUI("scatters")
    ),
    
    tabPanel("About",
      includeMarkdown("README.md")
    )

)))


server <- shinyServer(function(input, output, session) {
  df <- callModule(linkedScatter, "scatters", reactive(cammet[year==input$advYear,]),
    left  = reactive(c(input$selectLeftX,  input$selectLeftY)),
    right = reactive(c(input$selectRightX, input$selectRightY))
  )
  
  output$summary <- renderText({
    sprintf("%d observation(s) selected", sum(df()$selected_))
  })

  data <- reactive({
    cammet[year == input$year,]
  })
  
  output$plot <- renderPlot({
    ggplot(data(), aes_string(x = input$selectX, y = input$selectY)) +
      geom_point() +
      scale_color_manual(guide = FALSE)
  })
  
})


shinyApp(ui = ui, server = server)
