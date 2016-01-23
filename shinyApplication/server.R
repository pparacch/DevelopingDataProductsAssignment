#Load dataset - library containing the mtcars dataset used by the app
library(datasets)
library(ggplot2)
library(shiny)

shinyServer(function(input, output) {
    data <- mtcars
    data$am <- factor(data$am, labels = c("Automatic", "Manual"))
    
    # Compute the formula text in a reactive expression cause
    # shared by the output$caption and output$plot functions
    formulaText <- reactive({
        paste("mpg ~", input$variable)
    })
    
    # Output: the formula caption
    output$caption <- renderText({
        paste("Formula:" , formulaText())
    })
    
    # Output: the plot to be rendered in the UI
    output$boxPlot <- renderPlot({
        # If selected variable is categorical
        if (any(input$variable == c("cyl", "am", "gear", "vs", "carb"))) {
            boxplot(
                as.formula(formulaText()),
                data = data,
                outline = TRUE, ylim = c(10,35), ylab = "mpg", xlab = input$variable,
                main = paste("Box-and-whisker plot", formulaText()) 
            )
        }
    })
    
    # Output: the plot to be rendered in the UI
    output$scatterPlot <- renderPlot({
        # If selected variable is continuous
        g <-
            ggplot(data, aes(y = data[,"mpg"], x = data[,input$variable]))
        g <- g + xlab(input$variable)
        g <- g + ylab("mpg")
        g <- g + ggtitle(paste("Scatterplot", formulaText()))
        g <- g + geom_point(size = 5, color = "blue", alpha = 0.2)
        g <- g + geom_smooth(method = "lm", color = "black")
        g
        
        
    })
    
    # Output: a dataTable containing the raw data - car model, mpg, and selected variable
    output$rawData <- renderDataTable({
        data$models <- row.names(data)
        data[, c("models", "mpg", input$variable)]
    }, options = list(pageLength = 10,lengthMenu = list(
        c(5,10,15,25,40,-1), c("5","10","15","25","40","All")
    )))
    
    
})
