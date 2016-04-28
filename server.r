library(ggplot2)
library(plotly)

# load in data
if(!file.exists("sample.csv"))
{
    source("preprocess.r")
}
profiles <- read.csv("sample.csv")

shinyServer(function(input, output) {
    
    source("sivan.r")
    render_sivans_graphs(output, profiles)
    
    source("patrick.r")
    render_patricks_graphs(input, output, profiles)
    
    source("suvrath.r")
    render_suvraths_graphs(input, output, profiles)
})