# ComLabWeatherShiny

![Lifecycle
](https://img.shields.io/badge/lifecycle-experimental-orange.svg?style=flat)
![R
%>%= 3.0.2](https://img.shields.io/badge/R->%3D3.0.2-blue.svg?style=flat)

Interactive exploration of the Cambridge University
Computer Laboratory [weather station](https://www.cl.cam.ac.uk/research/dtg/weather/) measurements.


## Details
The [Digital Technology Group](https://www.cl.cam.ac.uk/research/dtg/) in the Cambridge University 
[Computer Laboratory](https://www.cl.cam.ac.uk/) maintain a [weather station](https://www.cl.cam.ac.uk/research/dtg/weather/).

This R [shiny](https://shiny.rstudio.com/) app provides an interactive exploration of some of this data.

### Variables
The weather measurements include the following variables.
  
| Variables         | Units                      |
|-------------------|----------------------------|
| Temperature       | Celsius (°C)               |
| Dew Point         | Celsius (°C)               |
| Humidity          | Percent                    |
| Pressure          | mBar                       |
| Wind Speed Mean   | Knots                      |
| Wind Bearing Mean | Degrees                    |
| Timestamp         | Data Hours:Minutes:Seconds |

Dew point is the temperature at which air, at a level of constant pressure, can no longer hold all the water it contains. 

Dew point is defined [here](https://www.cl.cam.ac.uk/research/dtg/weather/dewpoint.html) and in more detail [here](http://www.faqs.org/faqs/meteorology/temp-dewpoint/).

There are known issues with the sunlight and rain sensors.  These measurements are not included for now.


### Cleaning

The data included in the app start on 2008-08-01 when the weather station was moved to it's current [location](https://www.cl.cam.ac.uk/research/dtg/weather/map.html).

Unrealistically high wind speed (> 60), low humidity (< 10) and low temperature (< -20) values were removed.

[Cook's distance](https://en.wikipedia.org/wiki/Cook%27s_distance) was used to remove the remaining influential observations.

Some problems may remain in the data.  Such as long series of repeated values.

The Digital Technology Group list [inaccuracies](https://www.cl.cam.ac.uk/research/dtg/weather/inaccuracies.html) in the
weather data.

I have no affiliation with Cambridge University, the Computer Laboratory or the Digital Technology Group.


## Installation/Usage
Usage is probably best done within [RStudio](https://www.rstudio.com/).

```
# Install shiny if necessary
install.packages("shiny")

library(shiny)

# Only run in interactive R sessions
if (interactive()) {
  runGitHub("makeyourownmaker/ComLabWeatherShiny")
}
```


## Roadmap

* Improve documentation
  * Add screenshots to README
* Add tests
* Make app available on [shinyapps.io](https://shinyapps.io/)


## Contributing
Pull requests are welcome.  For major changes, please open an issue first to discuss what you would like to change.


## License
[GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
