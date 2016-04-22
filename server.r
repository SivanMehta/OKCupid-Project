library(ggplot2)

shinyServer(function(input, output) {
    
    output$hist_plot <- renderPlot({
        
        plot1 <- ggplot(data = faithful) +
            aes(x = eruptions) +
            geom_histogram(aes(y = ..density..)) +
            ggtitle("Histogram of Eruption Times")
        
        if (input$individual_obs)
        {
            plot1 <- plot1 + geom_rug()
        }
        
        if (input$density)
        {
            plo1t <- plot1 + geom_density()
        }
        
        plot1
    })
    
    output$scatter_plot <- renderPlot({
       
        ## Scatter Plot of Eruption vs. Waiting
        
        plot2 <- ggplot(data = faithful) +
            aes(x = eruptions, y = waiting) + 
            geom_point() + 
            ggtitle("Scatterplot of Eruptions vs. Waiting")
        
        if(input$smooth_line)
        {
            plot2 <- plot2 + geom_smooth()
        }
        
        plot2
    })
    
    output$density_plot <- renderPlot({
        plot3 <- ggplot(data = faithful) +
            aes(x = eruptions, y = waiting) +
            geom_density2d() +
            ggtitle("Contour map of Eruptions vs. Waiting")
        
        if(input$add_points)
        {
            plot3 <- plot3 + geom_point()
        }
        
        plot3
    })
})