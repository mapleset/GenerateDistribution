# Generate Distribution App
# derived and improved from sample code
# for the Coursera Data Products class
# 11/22/2015
# mapleset

library(shiny)

# Define server logic for application
shinyServer(function(input, output) {
  
  # Reactive expression to generate the distribution
  distData <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm(input$n, mean=input$mean, sd=input$sd),
                   unif = runif(input$n),
                   lnorm = rlnorm(input$n, mean=input$mean, sd=input$sd),
                   exp = rexp(input$n),
                   rnorm(input$n))
    
  })

  # Generate a plot of the data
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
