library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Exploring 'Miles Per Gallons' consumptions (based on Motor Trend Car Road Tests)"),
    br(),
    
    # Sidebar 
    sidebarLayout(
        #Sidebar Panel - a box containing the list of variables that could be selected in order to explore how
        # consumption (mile per gallons) depends on such a variable.
        sidebarPanel(
            p("Please select a specific variable to view how the fuel consumption changes",
                     "based on the available observations."),
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
            tags$h3(textOutput("caption")),
            br(),
            p("The data used for such exploration analysis is the 'mtcars' dataset - Motor Trend Car Road Tests.",
              "It was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and",
              "10 aspects of automobile design and performance for 32 automobiles (1973–74 models)."),
            
            helpText("Note:"),
            helpText("'Plot' tab: a scatterplot of the observations and the fitted linear model with 'mpg' (as the response) and selected",
                    "variable as the predictor is shown. Optional, if the selected variable is categorical a box-and-whiskers plot is shown."),
            
            helpText("'Summary' tab: summaries for the selected variable and the fitted linear regression model are shown."),
            
            helpText("'Data' tab: the data used for the plots and the linear regression model, a subset of the 'mtcars' dataset.")
            ),
        # The main panel contains a set of tabs
        # Plot: 
        #   - scatterplot of available observations, and predictions of fitted linear regression based on given observations
        #   - for categorical variables show a box-and-whisker plot with outliers
        #
        # Summary, some basic information about the selected variables, the linear regression model info (for continuous variables)
        #
        # Data, a table of the raw data included in the mtcars dataset
        
        mainPanel(
            tabsetPanel(
                tabPanel("Plot",
                         br(),
                         plotOutput("scatterPlot"),
                         # Optional boxPlot for categorical variables
                         conditionalPanel("input.variable == 'cyl' || 
                                          input.variable == 'am' || input.variable == 'gear' || 
                                          input.variable == 'vs' || input.variable == 'carb'",
                                          plotOutput("boxPlot")
                                          )
                         ),
                tabPanel("Summary",
                         br(),
                         h5("Summary for the selected variable"),
                         verbatimTextOutput("summaryVariable"),
                         h5("Summary for the fitted linear regression model"),
                         verbatimTextOutput("summaryLm")
                         ),
                        
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