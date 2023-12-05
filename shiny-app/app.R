#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# install.packages(c('shiny','sf','ggplot2','viridis'))

library(shiny)
library(sf)
library(ggplot2)
library(viridis)


#Load Data
hx<-read.csv(file="./data.csv",h=T)

#shape files for hartford
#From: https://openhartford-hartfordgis.opendata.arcgis.com/
#neigh<- st_read("C:./Hartford shapefiles/Neighborhood_District/Neighborhood_District.shp")

#ycols<-c("Race2","Gender2","Age.class","Over.16","NEIGH")


ui <- fluidPage(
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
      
      # Select variable for y-axis
      selectInput(
        inputId = "y",
        label = "Y-axis:",
        choices = c("Race" ="Race2",
                    "Gender"= "Gender2",
                    "Age Class"="Age.class",
                    "Over 16"="Over.16",
                    "Neighborhood"="NEIGH"),
        selected = "Race"
      ),
      
      #Select input for facet
      selectInput(
        inputId = "facet",
        label = "Group by:",
        choices = c("Race" ="Race2",
                    "Gender"= "Gender2",
                    "Age Class"="Age.class",
                    "Over 16"="Over.16",
                    "Neighborhood"="NEIGH"),
        selected = "Age.class"
      )
      
      
    ), #End sidbarPanel
  
    # Output: Show chart
    mainPanel(
      plotOutput(outputId = "chart")
    )
  )#end sidebarLayout
)#end fluid page


server <- function(input, output) {
  output$chart <- renderPlot({

    #summarize within ggplot
    ggplot(data=hx,aes(y=get(input$y),x=tally))+
      stat_summary(fun="sum", geom="col",fill="#41b6c4") +
      facet_grid(year~get(input$facet))+
      labs(x="Number of Participants", y=input$y)+
      theme_bw()+
      theme(strip.text=element_text(size=14,color="white"),
            strip.background = element_rect(fill="#0D1442"),
            axis.text=element_text(size=12),
            axis.title=element_text(size=14),
            legend.text=element_text(size=12),
            legend.title=element_text(size=14))
  })
}

shinyApp(ui = ui, server = server)
