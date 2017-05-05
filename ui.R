#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)

ui <- dashboardPage(
        dashboardHeader(title = "El-Nino/La-Nina Indicators"),
        
        dashboardSidebar(
                sidebarMenu(
                        
                        menuItem("How to use", tabName = "howto"),
                        menuItem("Graph", tabName = "graph")
                        
                        
                        
                )
        ),
        
        
        dashboardBody(
                tabItems(
                        tabItem(tabName = "graph",
                                fluidPage(
                                        
                                        selectInput("select", "Select variable:",choices = c("nino12_SST" , "nino12_SSTA", "nino3_SST" , "nino3_SSTA", "nino34_SST" , "nino34_SSTA","nino4_SST" , "nino4_SSTA")),
                                        plotlyOutput("plot")
                                        
                                )
                        ),
                        
                        
                        
                        # Transport tab
                        tabItem(tabName = "howto",
                                fluidPage(
                                        
                                        h1("Definitions and how to use"),
                                        uiOutput("myList")
                                        
                                        
                                        
                                )
                        ))))
