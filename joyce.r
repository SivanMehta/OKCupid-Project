library(ggplot2)

render_joyces_graphs <- function(input, output, profiles)
{
    output$eda_age <- renderPlot({
        ggplot(data = profiles, aes_string(x = input$x)) +
            geom_violin(aes(y = age)) + 
            ggtitle("Violin Plot of Age vs. Lifestyle Variable") +
            theme(axis.text.x = element_text(angle = 90)) + 
            coord_flip()
    })
    
    output$offer_vs_demand <- renderPlot({
        ggplot(data = profiles, aes(x = n_traits, y = n_demands)) +
            geom_point(aes_string(col = input$color)) +
            ggtitle("Offer vs Demand")
    })
}