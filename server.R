library(shiny)
library("ChemmineR")



server <- function(input, output, session) {
  output$input_file <- renderTable({
    filePath <- input$file$datapath
    if (is.null(filePath)){
      return(NULL)
    }
    
    sdfset <- read.SDFset(filePath)
    unique_ids <- makeUnique(sdfid(sdfset))
    cid(sdfset) <- unique_ids
    save(sdfset, file = "sdfset.rda", compress = TRUE)
    load("sdfset.rda")
    apset <- sdf2ap(sdfset)
    save(apset, file = "apset.rda", compress = TRUE)
    load("apset.rda")
    fpset <- desc2fp(apset, descnames=1024, type="FPset")
    fpma <- as.matrix(fpset)
    fpSim(fpset[1], fpset, method="Tanimoto")
    Sim_Tanimoto <- fpSim(fpset[1], fpset, method="Tanimoto")
    
    datafile <- reactive({
      Sim_Tanimoto[,c("sim",)]
    })
    write.csv(Sim_Tanimoto, "similarity_Tanimoto.csv")
    read.table("similarity_Tanimoto.csv", dec = ",", sep = ",", stringsAsFactors = FALSE, header = TRUE, blank.lines.skip = TRUE)
    
  })
  
  output$input_file2 <- renderText(input$job_name)
  #output$downloadData <- downloadHandler(
  #  filename = function(){
     # paste(job_name,"csv", sep = ",")
    #},
    #content = function(file){
    #  write.csv(Sim_Tanimoto(),file)
   # }
  #)
}