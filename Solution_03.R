library(shiny)

ui <- fluidPage(
  h1("Example app"),
  sidebarLayout(
    sidebarPanel(
      numericInput("nrows", "Number of rows", 10),
      actionButton("save", "Save")
    ),
    mainPanel(
      plotOutput("plot"),
      tableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  df <- reactive({
    head(cars, input$nrows)
  })
  
  output$plot <- renderPlot({
    plot(df())
  })
  
  output$table <- renderTable({
    df()
  })

  # Use observeEvent to tell Shiny what action to take
  # when input$save is clicked.
  observeEvent(input$save, {
    write.csv(df(), "data.csv")
  })
}

shinyApp(ui, server)
