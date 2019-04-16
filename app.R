
library(dplyr)
library(shiny)
library(ggplot2)
library(viridis)
library(markdown)

source("linked_scatter.R")
source("radial_plots.R")

cammet <- readRDS("data/CamMetCleanish.RData")


ui <- shinyUI(fluidPage(

  navbarPage("Cambridge Weather",
    tabPanel("Basic",
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
    
    tabPanel("Brushed",
      textOutput("summary"),
      linkedScatterUI("scatters")
    ),
    
    tabPanel("Radial",
      radialUI("radials")
    ),
    
    # Coming soon ...
    #tabPanel("Models",
    #  includeMarkdown("models.md")
    #),
    
    tabPanel("About",
      includeMarkdown("README.md")
    )

)))


server <- shinyServer(function(input, output, session) {
  df <- callModule(linkedScatter, 
                   "scatters", 
                   reactive(cammet %>% 
                              filter(year == input$advYear)),
                   left  = reactive(c(input$selectLeftX,  input$selectLeftY)),
                   right = reactive(c(input$selectRightX, input$selectRightY))
  )
  
  output$summary <- renderText({
    sprintf("%d observation(s) selected", sum(df()$selected_))
  })
  
  
  radDF <- reactive(cammet %>% 
                      filter(year == input$radialYear) %>%
                      group_by(as_date = as.Date(ds)) %>% 
                      summarise(minx = min(!! rlang::sym(input$radialX)),
                                maxx = max(!! rlang::sym(input$radialX)),
                                meanx = mean(!! rlang::sym(input$radialX))))
  
  callModule(radialPlot, 
             "radials", 
             radDF, 
             reactive(input$radialYear),
             reactive(input$radialX))
 
   
  data <- reactive({
    cammet %>% 
      filter(year == input$year)
  })
  
  output$plot <- renderPlot({
    ggplot(data(), aes_string(x = input$selectX, y = input$selectY)) +
      geom_point() +
      scale_color_manual(guide = FALSE)
  })
  
})


shinyApp(ui = ui, server = server)
