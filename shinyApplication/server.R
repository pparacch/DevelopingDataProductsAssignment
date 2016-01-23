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
    
    # Return the formula caption
    output$caption <- renderText({
        formulaText()
    })
    
    output$plot <- renderPlot({
        if(any(input$variable == c("cyl", "am", "gear", "vs", "carb"))){
            boxplot(as.formula(formulaText()),
                    data = data,
                    outline = input$outliers, ylim = c(10,35), ylab = "mpg", xlab = input$variable)
        }else{
            g <- ggplot(data, aes(y = data[,"mpg"], x = data[,input$variable]))
            g <- g + xlab(input$variable)
            g <- g + ylab("mpg")
            g <- g + geom_point(size = 5, color = "blue", alpha = 0.2)
            g <- g + geom_smooth(method = "lm", color = "black")
            g
               
        }
    })
  
  
})