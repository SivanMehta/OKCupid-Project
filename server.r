library(ggplot2)
library(plotly)

# load in data
if(!file.exists("sample.csv"))
{
    source("preprocess.r")
}
profiles <- read.csv("sample.csv")

shinyServer(function(input, output) {
    
    # Sivan's graphs
    
    output$wc_vs_sentiment <- renderPlot({
        
        ggplot(profiles) + 
            geom_point(aes(x = polarity, y = wc)) + 
            ggtitle("Word Count vs. Sentiment")
        
    })
    
    output$age_income_sentiment <- renderPlot({
       
        correlation <- cor(profiles$income, profiles$age, use = "na.or.complete") ** 2
        
        mytext <- paste("Age vs. Income with", "r^2 = ", correlation, ", colored by polarity")
        
        ggplot(subset(profiles, income < 250000 & income > 0)) + 
            aes(x = age, y = income) + 
            geom_point(aes(colour = polarity)) + 
            scale_colour_gradientn(colours=c("#FF0000", "#ffffff", "#440088","#0000FF")) + 
            geom_smooth(method = "lm") + 
            ggtitle(mytext)
    })
})