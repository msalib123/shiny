#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(lubridate)
library(ggvis)
library(dplyr)

x <- read_fwf(
        file="http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for",   
        skip=4,
        fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4)))

names(x) <- c("Date", "nino12_SST" , "nino12_SSTA", "nino3_SST" , "nino3_SSTA", "nino34_SST" , "nino34_SSTA","nino4_SST" , "nino4_SSTA")

x$Date <- dmy(x$Date)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
        
        loadData <- eventReactive(input$select, {
                
                
                cols <- input$select
                
                dat <- select_(x, 'Date', input$select)
                   
                
                dat$year <- format(dat$Date, "%Y")
                
                dat <- dat %>% filter(year >= 2010)
                
                dat
                
                
        })
        
        
        output$plot <- renderPlotly({
                
                
                
                # Render a ggplot
                
                print(ggplotly(        ggplot(loadData(), aes( x = Date , y = loadData()[,2], colour = year))  +
                                               geom_line() +
                                               ggtitle(input$select)+
                                               xlab("Date")+
                                               ylab("value")
                                               
                                       
                ))
                
                
                
        })  
                 
                
        output$myList <- renderUI(HTML("<ul><li>Source Data: <http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for></li><li>Background on definitions related to Sea temperature: https://www.ncdc.noaa.gov/teleconnections/enso/indicators/sst.php</li><li>Select the sea surface variable you wish to graph in the below chart page</li><li>the ui.R and server.R files are located here https://github.com/msalib123/shiny</li></ul>"))       
                
                
                
                
        })
        
        
        
