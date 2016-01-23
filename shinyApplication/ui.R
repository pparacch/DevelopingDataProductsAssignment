library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Miles Per Gallons"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            # Select the variable from the mtcars dataset that you would like to investigate
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
                                    "Number Of Carburetors" = "carb"),
                        selected = "cyl"),
            checkboxInput("outliers", "Show outliers", FALSE)
        ),
        # Show a plot of the generated distribution
        mainPanel(
            h2(textOutput("caption")),
            plotOutput("plot")
        )
    ))
)