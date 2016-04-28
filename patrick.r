library(ggplot2)
library(plotly)

plotTwoCategorical = function(var1, var2, df)
{
    var1.c = c()
    var2.c= c()
    
    # data frame creation
    var1.list = unique(df[[var1]])
    var2.list = unique(df[[var2]])
    for(i in unique(df[[var1]])){
        var1.c = c(var1.c, rep(i,length(unique(df[[var2]]))))
    }
    var2.c = rep(var2.list,length(var1.list))
    temp.df = as.data.frame(as.character(var1.c))
    colnames(temp.df) = "var.1"
    temp.df$var.2 = as.character(var2.c)
    temp.df$var.1 = as.character(temp.df$var.1)
    temp.df$count = rep(0, nrow(temp.df))
    temp.df$freq = rep(0,nrow(temp.df))
    for(i in 1:nrow(temp.df)){
        temp.df$count[i] = nrow(subset(df, df[[var1]] == temp.df$var.1[i] & 
                                           df[[var2]] == temp.df$var.2[i]))
    }
    for(i in 1:nrow(temp.df)){
        temp.df$freq[i] = temp.df$count[i] / sum(temp.df$count[which(temp.df$var.1 == temp.df$var.1[i])]) 
    }
    
    plot1 = ggplot(temp.df) + geom_point(aes(x=var.1,y=var.2, size = freq)) +
        scale_size(range = c(0, 25)) +
        ggtitle(paste("Proportion Breakdown of ",gsub("_", " ", var1),
                      " and ", gsub("_", " ", var2), sep="")) + 
        labs(x=gsub("_", " ", var1),y=gsub("_", " ", var2))
    plot1
}

render_patricks_graphs <- function(input, output, profiles)
{
    output$plotTwoCategorical <- renderPlot({
        print(profiles[[input$var1]][1])
        print(input$var2)
        plotTwoCategorical(input$var1,input$var2, profiles)
    })
}