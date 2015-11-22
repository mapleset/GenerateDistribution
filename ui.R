library(shiny)

# Define UI for random distribution application
shinyUI(fluidPage(
  
# app title
titlePanel("Generate Distribution"),
  
# Sidebar with controls to select the random distribution type
# and number of observations to generate. Note the use of the
# br() element to introduce extra vertical spacing
sidebarLayout(
  sidebarPanel(
    radioButtons("dist", "Distribution type:",
                 c("Normal" = "norm",
                   "Uniform" = "unif",
                   "Log-normal" = "lnorm",
                   "Exponential" = "exp")),
    br(),
    
    sliderInput("n", 
                "Number of observations:", 
                value = 500,
                min = 1, 
                max = 1000),

    sliderInput("mean", 
                "Mean:", 
                value = 0,
                min = -1000, 
                max = 1000),

    sliderInput("sd", 
                "Std. Deviation:", 
                value = 1,
                min = 0.1, 
                max = 3),
    
    downloadButton("downloadData", "Download")
  ),
    
  # show a histogram, boxplot, summary, and a table of the generated distribution
  #
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("Plot", plotOutput("plot")),
                tabPanel("Box Plot", plotOutput("boxPlot")), 
                tabPanel("Summary", verbatimTextOutput("summary")), 
                tabPanel("Table", tableOutput("table")),
    
    h5('The rnorm() function generates n random numbers whose distribution is normal.'),
    h5('The runif() function is used to simulate n independent uniform random variables.')
    )
  )
)))
