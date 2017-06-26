library(shiny)

shinyUI(fluidPage(
  titlePanel("Seasonality"),
  absolutePanel(
    tags$p(
      em(paste0("Last updated:", format.Date(Sys.Date(),"%d-%b-%Y")), tags$br(), "By Macro Strategy Team")
    ),
    
    top="1%", right="1%", left=NULL, bottom="100%", width=NULL, height=NULL, draggable=FALSE, fixed=FALSE, cursor=c("auto", "move", "default", "inherit")
  ),
  absolutePanel(tags$img(src = "https://www.dymonasia.com/wp-content/uploads/2014/11/dymon-asia-logo.png", alt=NULL, width = "300px", height = "75px"), top="4%", right="1%"),
  fluidRow(
    column( 6, tags$p(tags$b("Instructions:"), tags$br(),"
                      1. Click the Table or Chart tab to view data in table ot chart form" ,tags$br(),
                      "2. In Table tab, type/choose the month from the drop down box",tags$br(),
                      "3. To sort the table, click on table headers on the column title", tags$br(),
                      "4. In Chart tab type/choose month and currency from the drop down box:", tags$br(),
                      "5. Quick serch from the upper right box of the table"
    ))),
  
  navbarPage(" ",
             
             tabPanel("Table",
                      fluidRow(
                        column(3, selectInput("table.duration", "Type / Select Years of Study", choices = table.duration.choices)),
                        column(3, selectInput("table.month", "Type / Select month", choices = month.abb)),
                        hr(),
                        dataTableOutput("table"))),
             tabPanel("Chart",
                      fluidRow(
                        column(3,
                               selectInput("chart.duration", "Type / Select Years of Study", choices = chart.duration.choices)),
                        column(3,
                               selectInput("chart.month", "Type / Select month", choices = month.abb)),
                        column(3,
                               selectInput("chart.currency", "Type / Select currency ", choices = tSho ))
                      ),
                      hr(),
                      plotOutput("chart"))
             
  )
))



