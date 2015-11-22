library(shiny)
require(ggplot2)

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the requested distribution.
  # This is called whenever the inputs change. The output
  # functions defined below then all use the value computed from
  # this expression
  distData <- reactive({
    #dist <- switch(input$dist, norm = rnorm, unif = runif, lnorm = rlnorm, exp = rexp, rnorm)
    #dist(input$n, mean=100, sd=0.2)
    
    dist <- switch(input$dist,
                   norm = rnorm(input$n, mean=input$mean, sd=input$sd),
                   unif = runif(input$n),
                   lnorm = rlnorm(input$n, mean=input$mean, sd=input$sd),
                   exp = rexp(input$n),
                   rnorm(input$n))
    
  })

  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  output$plot <- renderPlot({
    distTypeLabel <- paste('r', input$dist, '(', input$n, ', mean=', input$mean, ', sd=', input$sd, ')', sep='')
    
    if( input$dist == 'unif' || input$dist == 'exp')
      distTypeLabel <- paste('r', input$dist, '(', input$n, ')', sep='')

    hist(x=distData(), main=distTypeLabel)
  })

  output$boxPlot <- renderPlot({ boxplot(x=distData()) })
  

  # Generate a summary of the data
  output$summary <- renderPrint({summary(distData())})
  
  # Generate an HTML table view of the data
  output$table <- renderTable({data.frame(x=distData())})
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dist, '.csv', sep='') },
    content = function(file) { write.csv(data.frame(x=distData()), file, sep=",")}
  )


})
