# import libraries
library(shiny)
library(data.table)

# Import data
#cammet <- readRDS("data/CamMetCleanishData2018.RData")
cammet <- readRDS("data/CamMetCleanishData.RData")
  
# Clean data


# initiating the UI
ui <- shinyUI(fluidPage(

  # Add a title
  titlePanel("Cambridge Weather"),

  # This creates a layout with a left sidebar and main section
  sidebarLayout(
    # sidebar section
    #  usually includes inputs
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

    # main section
    mainPanel(
      plotOutput("plot"),
      textOutput("selected_x")
    )

)))


# initiating the SERVER 
server <- shinyServer(function(input, output) {

  # ...
  output$selected_x <- renderText({ 
    paste("You have selected", input$selectX)
  })

  # define any reactive elements of the app
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


# launches the app
shinyApp(ui = ui, server = server)
