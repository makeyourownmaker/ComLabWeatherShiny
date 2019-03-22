
library(shiny)
library(data.table)

cammet <- readRDS("data/CamMetCleanishData.RData")


ui <- shinyUI(fluidPage(

  titlePanel("Cambridge Weather"),

  sidebarLayout(
    sidebarPanel(
      helpText("Explore ", tags$a(href="https://www.cl.cam.ac.uk/research/dtg/weather/", "ComLab"),  "weather measurements:"),
      selectInput("year", 
                  strong("Choose year"), 
                  choices = c("2019" = 2019,
                              "2018" = 2018,
                              "2017" = 2017,
                              "2016" = 2016,
                              "2015" = 2015,
                              "2014" = 2014,
                              "2013" = 2013,
                              "2012" = 2012,
                              "2011" = 2011,
                              "2010" = 2010,
                              "2009" = 2009,
                              "2008" = 2008),
                  selected = "2019"),
      selectInput("selectX", 
                  strong("Choose x variable"), 
                  choices = c("Temperature" = "temperature", 
                              "Dew Point"   = "dew.point", 
                              "Humidity"    = "humidity", 
                              "Pressure"    = "pressure",
                              "Wind Speed Mean"    = "wind.speed.mean",
                              "Wind Bearing Mean" = "wind.bearing.mean",
                              "Time" = "ds"),
                  selected = "temperature"),
      selectInput("selectY", 
                  strong("Choose y variable"), 
                  choices = c("Temperature" = "temperature", 
                              "Dew Point"   = "dew.point", 
                              "Humidity"    = "humidity", 
                              "Pressure"    = "pressure",
                              "Wind Speed Mean"   = "wind.speed.mean",
                              "Wind Bearing Mean" = "wind.bearing.mean"),
                  selected = "dew.point")
    ),

    mainPanel(
      plotOutput("plot"),
      textOutput("selected_x")
    )

)))


server <- shinyServer(function(input, output) {

  # debuging
  output$selected_x <- renderText({ 
    paste("You have selected", input$selectX)
  })

  data <- reactive({
      cammet[year==input$year, .(get(input$selectX), get(input$selectY))]
  })
  
  output$plot <- renderPlot({
    if ( input$selectX == "ds" ) { 
      labelX <- "timestamp"
    } else {
      labelX <- input$selectX
    }
    
    plot(data(), xlab=labelX, ylab=input$selectY, pch=20)
  })
  
})


shinyApp(ui = ui, server = server)
