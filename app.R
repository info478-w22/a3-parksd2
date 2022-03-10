library("shiny")
library("plotly")




# load the ui and server
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)