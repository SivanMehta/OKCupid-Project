library(shinydashboard)
library(shiny)

 # sidebar
sidebar <- dashboardSidebar( sidebarMenu(
        menuItem("Problem 1a", tabName = "Problem_1a", icon = icon("chevron-right")),
        menuItem("Problem 1b", tabName = "Problem_1b", icon=icon("chevron-right"))
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "Problem_1a",
                selectInput(inputId = "n_breaks",
                            label = "Number of bins in histogram (approximate):",
                            choices = c(10, 20, 35, 50),
                            selected = 20),
                
                checkboxInput(inputId = "individual_obs",
                              label = strong("Show individual observations"),
                              value = FALSE),
                
                checkboxInput(inputId = "density",
                              label = strong("Show density estimate"),
                              value = FALSE),
                
                plotOutput(outputId = "hist_plot", height = "300px")
        ),
        
        tabItem(tabName = "Problem_1b",
                
                mainPanel( tabsetPanel(
                    tabPanel("Graph 1",
                        checkboxInput(inputId = "smooth_line",
                                      label = "Smoothing Line?",
                                      value = FALSE),
                        plotOutput(outputId = "scatter_plot", height = "300px")
                    ),
                    tabPanel("Graph 2",
                        checkboxInput(inputId = "add_points", 
                                      label = "Add Points?", 
                                      value = FALSE),
                        plotOutput(outputId = "density_plot", 
                                   height = "300px")
                    )
                ))
        )
    )
)

# Put them together into a dashboardPage
dashboardPage(
    dashboardHeader(title = "Lab 13"),
    sidebar,
    body
)