library(ggplot2)
library(plotly)
library(ggmap)

render_suvraths_graphs <- function(input, output, profiles)
{
    output$map <- renderPlot({
        map <- get_map(location = c(lon = -122.286884, lat = 37.670770), zoom = 10)
        plot1 <- ggmap(map) + ggtitle("OKCupid Users in Calfornia Under 30")
        geom_point(aes(x = lon, y = lat, size = number_of_people, color = smokes), 
                   data = profiles) 
        if(input$map_option == "Smokes"){
            plot1 <-  ggmap(map) + ggtitle("OKCupid Users in Calfornia Under 30") +
                geom_point(aes(x = lon, y = lat, size = number_of_people, color = smokes), 
                           data = profiles)
        }
        if(input$map_option == "Drugs"){
            plot1 <-  ggmap(map) + ggtitle("OKCupid Users in Calfornia Under 30") +
                geom_point(aes(x = lon, y = lat, size = number_of_people, color = drugs), 
                           data = profiles)
        }
        plot1
    })
}