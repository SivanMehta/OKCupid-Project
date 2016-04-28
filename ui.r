library(shinydashboard)
library(shiny)

 # sidebar
sidebar <- dashboardSidebar( sidebarMenu(
        menuItem("Sentiment Analysis",   tabName = "Sivan",   icon = icon("chevron-right")),
        menuItem("Patrick", tabName = "Patrick", icon = icon("chevron-right")),
        menuItem("Joyce",   tabName = "Joyce",   icon = icon("chevron-right")),
        menuItem("Suvrath", tabName = "Suvrath", icon = icon("chevron-right"))
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "Sivan",
                plotOutput(outputId = "wc_vs_sentiment", height = "300px"),
                plotOutput(outputId = "age_income_sentiment", height = "300px"),
                plotOutput(outputId = "drinks_vs_words", height = "300px")
                
        ),
        tabItem(tabName = "Patrick",
                h1("Patrick")
        ),
        tabItem(tabName = "Joyce",
                h1("Joyce")
        ),
        tabItem(tabName = "Suvrath",
                h1("Suvrath")        
        )
    )
)

# Put them together into a dashboardPage
dashboardPage(
    dashboardHeader(title = "36-315: The Clusters in our Stars"),
    sidebar,
    body
)