library(shiny)

# Define the UI for random distribution application
shinyUI(fluidPage(
  
# app title
titlePanel("Generate Distribution"),
  
# Sidebar with controls to 
# 1. select the random distribution type
# 2. the number of observations to generate
# 3. the mean (average) of the data
# 4. the standard deviation of the data
# 5. a download button

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

    h6('Use this slider to change the number of samples in the generated distribution.'),
    
    sliderInput("mean", 
                "Mean:", 
                value = 0,
                min = -1000, 
                max = 1000),

    h6('Use this slider to change the mean of the generated distribution.'),
    
    sliderInput("sd", 
                "Std. Deviation:", 
                value = 1,
                min = 0.1, 
                max = 3),

    h6('Use this slider to change the standard deviation of the generated distribution.'),
    
    downloadButton("downloadData", "Download"),
    
    h6('Press this button to download a .csv file of the data that can be opened in a spreadsheet.')
    
  ),
    
  # show a histogram, boxplot, summary, and a table of the generated distribution
  #
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("Histogram", plotOutput("plot")),
                tabPanel("Box Plot", plotOutput("boxPlot")), 
                tabPanel("Summary", verbatimTextOutput("summary")), 
                tabPanel("Table", tableOutput("table")),
    
    h5('Select the tab(s) above to switch the view between Histogram, Box Plot, Summary, and Table.'),
    br(),
    h5('The rnorm() function generates n random numbers whose distribution is normal.'),
    h5('The runif() function is used to simulate n independent uniform random variables.')
    )
  )
)))
