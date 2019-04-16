
radialUI <- function(id) {
  ns <- NS(id)
  
  sidebarLayout(
    sidebarPanel(
      selectInput("radialYear", 
                  strong("Choose year"), 
                  # Not enough data for 2019 yet
                  choices  = yearChoices[!yearChoices %in% c("2019")],
                  selected = "2018"),
      selectInput("radialX", 
                  strong("Choose variable"), 
                  choices  = plotChoices[!plotChoices %in% c("wind.bearing.mean","ds")],
                  selected = "temperature")
    ),
    
    mainPanel(
      plotOutput(ns("radialPlot"))
    )
  )
}


radialPlot <- function(input, output, session, data, radYear, radVar) {
  
  radLabels <- reactive({
    if ( radVar() == "temperature" || radVar() == "dew.point" ) {
      radSeq <-  seq(-100, 400, 100)
    } else if ( radVar() == "pressure" ) {
      radSeq <- seq(950, 1050, 20) 
    } else if ( radVar() == "humidity" ) {
      radSeq <- seq(0, 100, 20)   
    } else if ( radVar() == "wind.speed.mean" ) {
      radSeq <- seq(0, 300, 50)   
    }
    
    data.frame(x = rep(as.Date(paste0(radYear(), '-01-01')), length(radSeq)),
               y = radSeq,
               label = radSeq)
  })
  
  radLegendTitle <- reactive({
    if ( radVar() == "temperature" ) {
      "Mean\nTemperature\n(\u00B0C * 10)"
    } else if ( radVar() == "dew.point" ) {
      "Mean\nDew point\n(\u00B0C * 10)"
    } else if ( radVar() == "pressure" ) {
      "Mean\nPressure\n(mBar)" 
    } else if ( radVar() == "humidity" ) {
      "Mean\nHumidity\n(%)"   
    } else if ( radVar() == "wind.speed.mean" ) {
      "Mean\nWind speed\n(knots * 10)"   
    }
  })
  
  output$radialPlot <- renderPlot({
    ggplot(data()) + 
      coord_polar() + 
      scale_x_date(date_breaks = '1 month', 
                   labels=c('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', '')) + 
      scale_color_viridis(option = 'magma', 
                          end = 0.8, 
                          limits = c(radLabels()$y[[1]] - 5, 
                                     radLabels()$y[[length(radLabels()$y)]] + 5), 
                          breaks = radLabels()$y, 
                          labels = as.character(radLabels()$label)) + 
      guides(color = guide_colorbar(title = radLegendTitle(),
                                    raster = F, 
                                    title.position = "top"))+
      geom_linerange(aes(x = as_date, 
                         ymin = minx, 
                         ymax = maxx, 
                         color = meanx), 
                     size = 1) +
      geom_text(data = radLabels(), aes(x = x, y = y, label = label),
                size = 3, color = "black", hjust = 0.5) +
      theme(axis.title  = element_blank(),
            axis.text.x = element_text(),
            axis.text.y = element_blank(),
            axis.ticks.y = element_blank())
  })
  
}
