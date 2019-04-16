
yearChoices <- c("2019" = 2019,
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
                 "2008" = 2008)

plotChoices = c("Temperature" = "temperature", 
                "Dew Point"   = "dew.point", 
                "Humidity"    = "humidity", 
                "Pressure"    = "pressure",
                "Wind Speed Mean"   = "wind.speed.mean",
                "Wind Bearing Mean" = "wind.bearing.mean",
                "Time" = "ds")


linkedScatterUI <- function(id) {
  ns <- NS(id)

  fluidRow(
    column(6,  plotOutput(ns("plot1"), brush = ns("brush"))),
    column(6,  plotOutput(ns("plot2"), brush = ns("brush"))),
    column(12, selectInput("advYear", 
                 strong("Choose year"), 
                 choices  = yearChoices,
                 selected = "2019")),
    column(6,  selectInput("selectLeftX", 
                 strong("Choose left plot x variable"), 
                 choices  = plotChoices,
                 selected = "humidity"),
               selectInput("selectLeftY", 
                 strong("Choose left plot y variable"), 
                 choices  = plotChoices,
                 selected = "temperature")),
    column(6,  selectInput("selectRightX", 
                 strong("Choose right plot x variable"), 
                 choices  = plotChoices,
                 selected = "dew.point"),
               selectInput("selectRightY", 
                 strong("Choose right plot y variable"), 
                 choices  = plotChoices,
                 selected = "temperature"))
  )
}


linkedScatter <- function(input, output, session, data, left, right) {
  # Yields the data frame with an additional column "selected_"
  # that indicates whether that observation is brushed
  dataWithSelection <- reactive({
    brushedPoints(data(), input$brush, allRows = TRUE)
  })

  output$plot1 <- renderPlot({
    scatterPlot(dataWithSelection(), left())
  })

  output$plot2 <- renderPlot({
    scatterPlot(dataWithSelection(), right())
  })

  return(dataWithSelection)
}


scatterPlot <- function(data, cols) {
  ggplot(data, aes_string(x = cols[1], y = cols[2])) +
    geom_point(aes(color = selected_)) +
    scale_color_manual(values = c("black", "#66D65C"), guide = FALSE)
}
