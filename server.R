library(shiny)
library(dplyr)
library(ggplot2)
library(scales)
library(gridExtra)


setwd("D:\\RCoursera\\r-s-l")

ripley.tv <- read.csv("D:\\RCoursera\\Ripley\\r-tvs.csv", stringsAsFactors = F)




ripley.tv.cantidad <- ripley.tv  %>%
        group_by(marca) %>%
        summarise(cantidad = length(marca))




####




tbl.precio.nuevo <- tableGrob(t(prettyNum(summary(ripley.tv$precio.nuevo), big.mark = ",")))

tbl.precio.antes <- tableGrob(t(prettyNum(summary(ripley.tv$precio.antes), big.mark = ",")))





####






# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        # Expression that generates a histogram. The expression is
        # wrapped in a call to renderPlot to indicate that:
        #
        #  1) It is "reactive" and therefore should re-execute automatically
        #     when inputs change
        #  2) Its output type is a plot
       
                
      
        
        output$plot1 <- renderPlot({
                ### Gráficos 
                
                
                ### Gráfico 1:
                
                
                
                
                
                
               g <- ggplot(ripley.tv.cantidad, aes(x=marca, y= cantidad)) + 
                        geom_bar(stat = "identity", width = .7, fill= "lightblue") +
                        labs(title = "",
                             x = "", y = "") +
                        geom_text(aes(label=cantidad), vjust=-0.2, size = 06)  +
                        theme(axis.text.x = element_text(colour="grey10",size=12,hjust=.5,vjust=.5,face="plain"),
                              axis.text.y = element_text(colour="grey10",size=12,,hjust=1,vjust=0,face="plain"),  
                              axis.title.x = element_text(colour="grey40",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
                              axis.title.y = element_text(colour="grey40",size=14,angle=90,hjust=.5,vjust=.5,face="plain"),
                              plot.title = element_text(vjust=2)) +
                       scale_y_continuous(limits = c(0, 50))
               
                
               grid.arrange(input$radio, g,
                            nrow=2,
                            as.table=TRUE,
                            heights=c(1,3))
               
               
                
               
                
        })
        
        
        # Generate a summary of the dataset
        output$summary <- renderPrint({
                precio.nuevo <- ripley.tv$precio.nuevo
                summary(precio.nuevo)
                
        })
        
        
        
        
        output$summary2 <- renderPrint({
                precio.antes <- ripley.tv$precio.antes
                summary(precio.antes)
                
        })
        
        
})