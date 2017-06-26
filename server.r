
library(shiny)
library(htmltools)
library(DT)
library(dplyr)
library(rsconnect)
#source("YoY.R")
# runApp(host="192.168.3.87", port=5050)
shinyServer <- function(input, output) {
  output$chart <- renderPlot({
    plot(normalizedplot(input$chart.month, input$chart.currency, input$chart.duration ))
  }, height = 550)
  
  
  output$table <- DT::renderDataTable({
   
   
    
    datTable = createTable(input$table.month, input$table.duration ) # chosen from month.abb
    
    

    tabLabelCont = htmltools::withTags(table(
      class = 'compact nowrap',
      thead(
        tr( th(colspan = 4, ''), th(colspan = 4, 'Rolling Return Summary' ), th(colspan = 4, 'Full Month Return Breakdown'), th(colspan = 3, 'Intra-month Average Return')),
        tr(lapply(c(" ", colnames(datTable)), th))
      )))

    datatable(datTable,
              escape=F,
              class=c("compact"),
              container=tabLabelCont,
              colnames = TRUE,
              options=list(pageLength=100, 
                           autoWidth = TRUE,
                           columnDefs = list(
                             list(className = 'dt-center  table-bordered' , targets =c(0:ncol(datTable))),
                             list(width = "160px", targets = c(3:ncol(datTable))))))%>%
      formatPercentage(5, 0)%>% # success.rate is formated with o decimal place
      formatPercentage(c(3:4,6:ncol(datTable)), 2)%>% # return rates are with 2 dec places
      formatStyle(c(1:2,6,12), color="black", backgroundColor="white")%>%
      formatStyle(7:11, color="royalblue")%>%
      # formatStyle(11:13, color="darkgrey")%>%
     # formatStyle(3:5, color="darkgrey")%>%
      formatStyle(3, backgroundColor = styleInterval(quantile(as.matrix(datTable[,3]), c(.20, .40, .60, .80)), c('#F8696B', '#FBABAD', '#FCFCFF','#A0D8AF', '#63BE7B')))%>%
      formatStyle(4, backgroundColor = styleInterval(quantile(as.matrix(datTable[,4]), c(.20, .40, .60, .80)), c('#F8696B', '#FBABAD', '#FCFCFF','#A0D8AF', '#63BE7B')))%>%
      formatStyle(5, backgroundColor = styleInterval(c(-0.75, -0.5, 0.5, 0.75), c('#F8696B', '#FBABAD', '#FCFCFF','#A0D8AF', '#63BE7B')))%>% # success rate:  -0.5- 0.5 is white
      formatStyle(7:11, backgroundColor = styleInterval(quantile(as.matrix(datTable[,7:11]), c(.20, .40, .60, .80)), c('#F8696B', '#FBABAD', '#FCFCFF','#A0D8AF', '#63BE7B')))%>%
      formatStyle(13:15, backgroundColor = styleInterval(quantile(as.matrix(datTable[,13:15]), c(.20, .40, .60, .80)), c('#F8696B', '#FBABAD', '#FCFCFF','#A0D8AF', '#63BE7B')))
  
    
    
    })
  
}

