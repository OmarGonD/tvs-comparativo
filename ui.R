library(shiny)


shinyUI(fluidPage(
        includeCSS("D:\\RCoursera\\r-s-l\\www\\rsl.css"),
        titlePanel("R - Tvs"),
        sidebarLayout(
                sidebarPanel(
                        p("This dashboards muestra los tvs en la sección"),
                        p("La data se obtuvo de esta sección: \n",
                          a("R TV todas", 
                            href = "http://www")),
                        img(src="", height = 60, width = 120),
                        br(),
                        br(),
                        p("Se consideraron los siguientes atributos: marca, producto y precio")
                        
                        
                        
                ),
                mainPanel(
                        tabsetPanel(
                                tabPanel("Por marca", h4("Summary"),
                                         verbatimTextOutput("summary"),
                                         plotOutput("plot1"),
                                tabPanel("Por rango de precio", plotOutput("plot2"),
                                         dataTableOutput('mytable')),
                                tabPanel("Dif. descuento %", plotOutput("plot3"))
                        )
                )
        )
))
)
