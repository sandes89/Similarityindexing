library(shiny)

shinyUI(fluidPage(
  headerPanel(title = "Similarity Indexing"),
  sidebarLayout(
    sidebarPanel(
      textInput("job_name", "Job Name"),
      
      fileInput("file", "Upload file", multiple = FALSE,
                accept = ".sdf", placeholder = "upload only .sdf file"),
      #submitButton("RUN")
      
    ),
    mainPanel(
      
      tabsetPanel(
        tabPanel(title = uiOutput("input_file2"), tableOutput("input_file"))
        #tabPanel(title = uiOutput("input_file2"), tableOutput("input_file"), downloadButton("downloadData","Download Data"))
      )
     
    )
  )
))