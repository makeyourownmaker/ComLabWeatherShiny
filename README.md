# ComLabWeatherShiny

Interactive exploration of the data from the Cambridge University
Computer Laboratory [weather station](https://www.cl.cam.ac.uk/research/dtg/weather/).


## Details
The [Digital Technology Group](https://www.cl.cam.ac.uk/research/dtg/) in the Cambridge University 
[Computer Laboratory](https://www.cl.cam.ac.uk/) maintain a [weather station](https://www.cl.cam.ac.uk/research/dtg/weather/).

This R [shiny](https://shiny.rstudio.com/) app provides an interactive exploration of some of this data.

Describe data ...

Describe cleaning ...

I have no affiliation with Cambridge University, the Computer Laboratory or the Digital Technology Group.


## Installation/Usage
This is probably best done within [RStudio](https://rstudio.com/).

```
#install.packages("shiny") # Install shiny if necessary

library(shiny)

# Only run in interactive R sessions
if (interactive()) {
  runGitHub("makeyourownmaker/ComLabWeatherShiny")
}
```


## Roadmap

* Add documentation
  * Add screenshots to README
  * Describe data
  * Describe cleaning
* Add tests
* Make app available on shinyapps.io


## Contributing
Pull requests are welcome.  For major changes, please open an issue first to discuss what you would like to change.


## License
[GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
