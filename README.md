# ComLabWeatherShiny

![Lifecycle
](https://img.shields.io/badge/lifecycle-maturing-blue.svg?style=flat)
![R
%>%= 3.0.2](https://img.shields.io/badge/R->%3D3.0.2-blue.svg?style=flat)

Interactive exploration of the Cambridge University
Computer Laboratory [weather station](https://www.cl.cam.ac.uk/research/dtg/weather/) measurements.

If you like ComLabWeatherShiny, give it a star, or fork it and contribute!


<img src="figures/tabs.gif" width="85%" height="85%">


## Details
The [Digital Technology Group](https://www.cl.cam.ac.uk/research/dtg/) in the Cambridge University 
[Computer Laboratory](https://www.cl.cam.ac.uk/) maintain a [weather station](https://www.cl.cam.ac.uk/research/dtg/weather/).

I live close to this weather station.  Hence my interest.

This R [shiny](https://shiny.rstudio.com/) app provides an interactive exploration of some of this data.
It includes basic scatter plots, interactive plots (linked plots with data brushing) and also radial plots 
showing annual changes.

### Variables
The weather measurements include the following variables.
  
| Variables         | Units                      |
|-------------------|----------------------------|
| Temperature       | Celsius (°C) * 10          |
| Dew Point         | Celsius (°C) * 10          |
| Humidity          | Percent                    |
| Pressure          | mBar                       |
| Wind Speed Mean   | Knots * 10                 |
| Wind Bearing Mean | Degrees                    |
| Timestamp         | Data Hours:Minutes:Seconds |

Dew point is the temperature at which air, at a level of constant pressure, can no longer hold all the 
water it contains.  Dew point is defined [here](https://www.cl.cam.ac.uk/research/dtg/weather/dewpoint.html) 
and in more detail [here](http://www.faqs.org/faqs/meteorology/temp-dewpoint/).

There are known issues with the sunlight and rain sensors.  These measurements are not included for now.


### Cleaning

The data included in the app start on 2008-08-01 when the weather station was moved to it's current 
[location](https://www.cl.cam.ac.uk/research/dtg/weather/map.html).  Unrealistically high wind speed (> 60), 
low humidity (< 25) and low temperature (< -20) values were removed.  The Digital Technology 
Group list [inaccuracies](https://www.cl.cam.ac.uk/research/dtg/weather/inaccuracies.html) in the weather 
data.  All measurements for the entire day or days was removed for each of the listed inaccuracies.
[Cook's distance](https://en.wikipedia.org/wiki/Cook%27s_distance) 
was used to remove the remaining influential observations but some problems may remain in the data, such as 
long series of repeated values.  The remaining measurements have no missing values.  

There are two cleaning scripts included in the scripts directory: 
  * [1-load.R](scripts/1-load.R) which loads the data and adds some date and time related fields.
  * [2-clean.R](scripts/2-clean.R) which removes unrealistic and inaccurate measurements.

I have no affiliation with Cambridge University, the Computer Laboratory or the Digital Technology Group.


## Installation/Usage
Usage is probably best done within [RStudio](https://www.rstudio.com/).

```r
# Install required libraries
install.packages("shiny")
install.packages("data.table")

library(shiny)

# Only run in interactive R sessions
if (interactive()) {
  runGitHub("makeyourownmaker/ComLabWeatherShiny")
}
```


## Roadmap

* Update data to include 2020
* Improve documentation
  * Describe each of the interactive plots in more detail
* Add tests
  * Using [shinytest](https://rstudio.github.io/shinytest/)
* Make app available on [shinyapps.io](https://shinyapps.io/)


## See Also

* My related weather repositories:
  * [Cambridge Temperature Forecasts in R](https://github.com/makeyourownmaker/CambridgeTemperatureModel)
  * [Forecasting surface temperature based on latitude, longitude, day of year and hour of day](https://github.com/makeyourownmaker/ParametricWeatherModel)
  * [Time series and other models for Cambridge UK temperature forecasts in python](https://github.com/makeyourownmaker/CambridgeTemperatureNotebooks)


## Contributing
Pull requests are welcome.  For major changes, please open an issue first to discuss what you would like to change.


## License
[GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
