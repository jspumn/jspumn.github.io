library(shiny)

# Sample size data
data <- list(
  `10` = list(`6` = 10, `2` = 10),
  `20` = list(`6` = 19, `2` = 20),
  `30` = list(`6` = 24, `2` = 30),
  `40` = list(`6` = 29, `2` = 40),
  `50` = list(`6` = 31, `2` = 48),
  `60` = list(`6` = 34, `2` = 55),
  `70` = list(`6` = 35, `2` = 62),
  `80` = list(`6` = 37, `2` = 68),
  `90` = list(`6` = 38, `2` = 73),
  `100` = list(`6` = 39, `2` = 78),
  `120` = list(`6` = 40, `2` = 86),
  `140` = list(`6` = 41, `2` = 92),
  `160` = list(`6` = 42, `2` = 97),
  `180` = list(`6` = 43, `2` = 101),
  `200` = list(`6` = 43, `2` = 105),
  `250` = list(`6` = 44, `2` = 112),
  `300` = list(`6` = 45, `2` = 117),
  `350` = list(`6` = 46, `2` = 121),
  `400` = list(`6` = 46, `2` = 124),
  `450` = list(`6` = 46, `2` = 127),
  `500` = list(`6` = 47, `2` = 129),
  `600` = list(`6` = 47, `2` = 132),
  `700` = list(`6` = 47, `2` = 134),
  `800` = list(`6` = 47, `2` = 136),
  `900` = list(`6` = 48, `2` = 137),
  `1000` = list(`6` = 48, `2` = 138),
  `1200` = list(`6` = 48, `2` = 140),
  `1400` = list(`6` = 48, `2` = 141),
  `1600` = list(`6` = 48, `2` = 142),
  `1800` = list(`6` = 48, `2` = 143),
  `2000` = list(`6` = 48, `2` = 143),
  `3000` = list(`6` = 49, `2` = 145),
  `4000` = list(`6` = 49, `2` = 146),
  `5000` = list(`6` = 49, `2` = 147),
  `6000` = list(`6` = 49, `2` = 147),
  `7000` = list(`6` = 49, `2` = 147),
  `8000` = list(`6` = 49, `2` = 147),
  `9000` = list(`6` = 49, `2` = 148),
  `10000` = list(`6` = 49, `2` = 148)
)

# Function to get sample size
get_sample_size <- function(population, prevalence) {
  if (!is.null(data[[as.character(population)]]) && !is.null(data[[as.character(population)]][[as.character(prevalence)]])) {
    return(paste("Sample Size:", data[[as.character(population)]][[as.character(prevalence)]]))
  } else {
    return("Data not available for the given inputs")
  }
}

# Define UI
ui <- fluidPage(
  titlePanel("Sample Size Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("population", "Population Size", choices = c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 120, 140, 160, 180, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000)),
      selectInput("prevalence", "Prevalence (%)", choices = c(2, 6))
    ),
    
    mainPanel(
      textOutput("sample_size_output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$sample_size_output <- renderText({
    get_sample_size(input$population, input$prevalence)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
