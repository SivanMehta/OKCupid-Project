library(shinydashboard)
library(shiny)

 # sidebar
sidebar <- dashboardSidebar( sidebarMenu(
        menuItem("Sentiment Analysis",    tabName = "sentiment",   icon = icon("chevron-right")),
        menuItem("Two Categorical Plots", tabName = "two_cats",    icon = icon("chevron-right")),
        menuItem("Word Clouds",           tabName = "clouds",      icon = icon("chevron-right")),
        menuItem("Livestyle vs. Age",     tabName = "life_v_age",  icon = icon("chevron-right")),
        menuItem("Traits Offered vs. Demanded", tabName = "offered_v_demanded",  icon = icon("chevron-right")),
        menuItem("Maps",               tabName = "maps",           icon = icon("chevron-right")),
        menuItem("Mosiac Plot",        tabName = "mosaic",         icon = icon("chevron-right"))
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "sentiment",
                plotOutput(outputId = "wc_vs_sentiment", height = "300px"),
                plotOutput(outputId = "age_income_sentiment", height = "300px"),
                plotOutput(outputId = "drinks_vs_words", height = "300px")
        ),
        tabItem(tabName = "two_cats",
                selectInput(inputId = "var1",
                                        label = "Variable 1 (appears on x-axis):",
                                        choices = c("drinks","smokes","sex","status","body_type","diet"),
                                        selected = "body_type"),
                            
                selectInput(inputId = "var2",
                            label = "Variable 2 (appears on y-axis):",
                            choices = c("drinks","smokes","sex","status","body_type","diet"),
                            selected = "drinks"),
                
                plotOutput(outputId = "plotTwoCategorical", height = "300px")
        ),
        tabItem(tabName = "clouds",
                mainPanel(
                    tabsetPanel(
                        tabPanel("Fit",
                                 plotOutput(outputId = "wordCloud.fit", height = "600px")
                        ),
                        tabPanel("A little extra",
                                 plotOutput(outputId = "wordCloud.extra", height = "600px")
                        ),
                        tabPanel("Jacked",
                                 plotOutput(outputId = "wordCloud.jacked", height = "600px")
                        ),
                        tabPanel("Athletic",
                                 plotOutput(outputId = "wordCloud.athletic", height = "600px")
                        )
                    )
                )
        ),
        tabItem(tabName = "life_v_age",
            selectInput('x', 'X Variable', c("drinks", "diet", "body_type", "smokes")),
            plotOutput(outputId = "eda_age", height = "450px", width = "600px")
        ),
        tabItem(tabName = "offered_v_demanded",
            selectInput('color', 'Color According To', c("age", "drinks", "diet", "body_type", "smokes")),
            plotOutput(outputId = "offer_vs_demand", height = "450px", width = "600px")
        ),
        tabItem(tabName = "maps",
            plotOutput(outputId = "map", height = "300px"),
            selectInput(inputId = "map_option",
                        label = h3("Select Variable"),
                        choices = list("Smokes", "Drugs"))
        ),
        tabItem(tabName = "mosaic",
            plotOutput(outputId = "mosaicplot", height = "300px")
        )
    )
)

# Put them together into a dashboardPage
dashboardPage(
    dashboardHeader(title = "Final Project"),
    sidebar,
    body
)