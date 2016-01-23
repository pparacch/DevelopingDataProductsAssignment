library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Exploring 'Miles Per Gallons' consumptions using the Motor Trend Car Road Tests dataset."),
    br(),
    
    # Sidebar 
    sidebarLayout(
        #Sidebar Panel - a box containing the list of variables that could be selected in order to explore how
        # consumption (mile per gallons) depends on such a variable.
        sidebarPanel(
            # Select the variable from the mtcars dataset that you would like to use as a predictor
            selectInput(inputId = "variable",
                        label = "Variable:",
                        choices = c("Number Of Cylindres" = "cyl",
                                    "Displacement" = "disp",
                                    "Gross Horsepower" = "hp",
                                    "Rear Axle Ratio" = "drat",
                                    "Weight" = "wt",
                                    "1/4 mile time" = "qsec",
                                    "V/S" = "vs",
                                    "Transmission (0 = auto, 1 = man)" = "am",
                                    "Number Of Forward Gears" = "gear",
                                    "Number Of Carburetors" = "carb")
                        ),
            br(),
            hr(),
            tags$h3(textOutput("caption")),
            br(),
            helpText("Note:"),
            helpText("* The data set used for such exploration analysis is the 'mtcars' dataset."),
            helpText("* The response is 'mpg' (it cannot be changed) while the predictor/ regressor is selected using the 'Variable' box."),
            br(),
            helpText("Selecting a specific predictor is possible to view how the consumption changes for the available observations.")
            
            ),
        # The main panel contains a set of tabs
        # Plot: 
        #   - for continuous variables shows the observations, and linear regression based on given observations
        #   - for categorical variables show a box-and-whisker plot with outliers
        #
        # Summary, some basic information about the selected variables, the linear regression model info (for continuous variables)
        #
        # Data, a table of the raw data included in the mtcars dataset
        
        mainPanel(
            tabsetPanel(
                tabPanel("Plot",
                         plotOutput("plot")
                         ),
                tabPanel("Summary"),
                tabPanel("Data", 
                         tags$br(),
                         tags$div(
                             tags$p("The used subset of the 'mtcars' dataset including the following features:",
                                    "the car models, the 'mile per gallon' consumption and the selected variable",
                                    "for all of the available observations.")
                         ),
                         hr(),
                         dataTableOutput("rawData")
                         )
            )
        )
    )
)
)