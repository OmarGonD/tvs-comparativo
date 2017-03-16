library(dplyr)
library(reshape2)
library(gridExtra)
library(grid)
library(ggplot2)
library(scales)


setwd("D:\\RCoursera\\r-s-l")

ripley.tv <- read.csv("D:\\RCoursera\\Ripley\\r-tvs-2016-03-04.csv", stringsAsFactors = F,
                      na.strings = "")



saga.tv <- read.csv("D:\\RCoursera\\Saga_falabella\\s-tv-2016-03-04.csv",
                    stringsAsFactors = F)




linio.tv <- read.csv("D:\\RCoursera\\Linio\\l-tv-2015-12-26.csv",
                     stringsAsFactors = F)




### Saga cleaning

saga.tv$categoria <- NULL

saga.tv$precio.normal <- NULL

saga.tv$recojo.tienda <- NULL

saga.tv$solo.online <- NULL


# Precio Internet tiene que llamarse "Precio Antes"
# Precio Unica tiene que llamarse "Precio Actual"

colnames(saga.tv)[4] <- "precio.antes"
colnames(saga.tv)[5] <- "precio.actual"


saga.tv$precio.antes <- gsub(",", "", saga.tv$precio.antes)
saga.tv$precio.actual <- gsub(",", "", saga.tv$precio.actual)






###


### Unión de los 3 dfs

tvs <- rbind(ripley.tv, saga.tv,
             linio.tv)



### as numeric





tvs$marca <- trimws(tvs$marca, which = c("both"))
tvs$producto <- trimws(tvs$producto, which = c("both"))
tvs$precio.antes <- trimws(tvs$precio.antes, which = c("both"))
tvs$precio.actual <- trimws(tvs$precio.actual, which = c("both"))
tvs$pulgadas <- trimws(tvs$pulgadas, which = c("both"))


#Linio es el que tiene más variedad de productos

### En realidad Saga termina siendo el que ofrece menos 
### productos. Será una estrategia para mostrar que cuentan con un
### mayor surtido de TVs. La teoría dice que entre menos elecciones tenga
### el consumidor, mejor decidirá.

#¿Por qué los ids son diferentes, si ya quitamos los duplicados?

tvs$precio.antes <- as.numeric(tvs$precio.antes)
tvs$precio.actual <- as.numeric(tvs$precio.actual)
tvs$pulgadas <- as.numeric(tvs$pulgadas)


### Linio no tiene mucha información en Precio Antes




### Rango de precios - basados en Ripley.com.pe 


tvs  <- tvs  %>%
        mutate(rangos = ifelse(precio.actual <= 500, "< S/.500",
                               ifelse(precio.actual > 500 & precio.actual <= 1500,
                                      "S/.500 - S/.1500",
                                      ifelse(precio.actual > 1500 & precio.actual <= 2500,"S/.1500 - S/.2500",
                                             ifelse(precio.actual > 2500 & precio.actual <= 3500,"S/.2500 - S/.3500",
                                                    ifelse(precio.actual > 3500 & precio.actual <= 4500,"S/.3500 - S/.4500",
                                                           "> S/.4,500"))))))



tvs$rangos <- factor(tvs$rangos, levels = c("< S/.500",
                                                       "S/.500 - S/.1500",
                                                       "S/.1500 - S/.2500",
                                                       "S/.2500 - S/.3500",
                                                       "S/.3500 - S/.4500",
                                                       "> S/.4,500"),
                          ordered = T)

###





tvs$marca <- factor(tvs$marca, levels = c("hisense","nex", "continental",
                                                      "haier", "aoc",
                                                      "sharp", "imaco","panasonic","sony",
                                                      "lg", "samsung", "daewoo", "hyundai"),
                          ordered = T)

###


### Reemplazar nombres reales de Ecommerce por nombres clave

# Ripley <- A
# Saga <- B
# Linio <- C



tvs$ecommerce <- gsub("ripley", "a", tvs$ecommerce)
tvs$ecommerce <- gsub("falabella", "b", tvs$ecommerce)
tvs$ecommerce <- gsub("linio", "c", tvs$ecommerce)



tvs.cantidad <- tvs  %>%
        group_by(ecommerce) %>%
        summarise(cantidad = length(marca))



tvs.cantidad$ecommerce <- factor(tvs.cantidad$ecommerce, levels = c("linio",
                                                          "ripley",
                                                          "falabella"),
                    ordered = T)





ggplot(tvs.cantidad, aes(x=ecommerce, y= cantidad)) + 
        geom_bar(stat = "identity", width = .7, fill= "lightblue") +
        #facet_grid(~ ecommerce) +
        labs(title = "Ecommerce con más TVs\n",
             x = "", y = "") +
        theme(axis.text.x = element_text(colour="grey10",size=22,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey10",size=20,,hjust=0,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey40",size=6,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey40",size=6,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=2))




ggsave(file="tvs-cantidad.jpg", width = 12, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")


### 


tvs.rangos <- tvs %>%
        group_by(ecommerce, rangos) %>%
        summarise(cantidad = length(rangos))



tvs.rangos$ecommerce <- factor(tvs.rangos$ecommerce, levels = c("linio",
                                                                "ripley",
                                                                "falabella"),
                               ordered = T)

# To use for fills, add

###

ggplot(tvs.rangos, aes(x = rangos, y = cantidad, fill = ecommerce)) +
        
        geom_bar(stat = "identity") + 
        scale_fill_manual("ecommerce",
                values = c("linio" = "#FF5500","ripley" = "#802D69","falabella" = "#BED800")) +
        labs(title = "Cantidad de TVs\nsegún rangos de precios\n",
             x = "rangos de precios\n", y = "cantidad de tvs") +
        facet_wrap(~ ecommerce, nrow = 3) +
        coord_flip() +
        theme(axis.text.x = element_text(colour="grey10",size=16,hjust=.5,vjust=.5,face="bold"),
              axis.text.y = element_text(colour="grey10",size=18,,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey40",size=16,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey40",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 18,vjust=4),
              legend.title = element_text(colour="grey40", size=16, face="bold"),
              legend.text = element_text(colour="grey10", size=16, face="bold"),
              strip.text.x = element_text(size = 20, angle = 0),
              legend.position = "none")





####




###






### Gráficos individuales por ecommerce ###

### ripley ###


tvs.ripley <- tvs[tvs$ecommerce == "ripley",]

tvs.ripley.porcentajes <- tvs.ripley  %>%
        group_by(rangos, marca) %>%
        summarise(cantidad.marca = length(marca)) %>% 
        mutate(porcentaje = cantidad.marca/sum(cantidad.marca))




ggplot(tvs.ripley.porcentajes, aes(x=rangos, y= porcentaje ,fill=marca)) + 
        geom_bar(stat = "identity", width = .7) +
        scale_fill_brewer(palette="Set3") +
        labs(title = "Ripley Perú \n % marca de tvs por rango de precios",
             x = "rango de precios", y = "% cantidad de tvs") +
        theme(axis.text.x = element_text(colour="grey20",size=14,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=14,,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=14,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(vjust=2)) +
        scale_y_continuous(labels=percent)


### falabella ###



tvs.falabella <- tvs[tvs$ecommerce == "falabella",]

tvs.falabella.porcentajes <- tvs.falabella  %>%
        group_by(rangos, marca) %>%
        summarise(cantidad.marca = length(marca)) %>% 
        mutate(porcentaje = cantidad.marca/sum(cantidad.marca))




ggplot(tvs.falabella.porcentajes, aes(x=rangos, y= porcentaje ,fill=marca)) + 
        geom_bar(stat = "identity", width = .7) +
        scale_fill_brewer(palette="Set3") +
        labs(title = "Falabella Perú \n % marca de tvs por rango de precios",
             x = "rango de precios", y = "% cantidad de tvs") +
        theme(axis.text.x = element_text(colour="grey20",size=14,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=14,,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=14,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(vjust=2)) +
        scale_y_continuous(labels=percent)




### linio ###



tvs.linio <- tvs[tvs$ecommerce == "linio",]

tvs.linio.porcentajes <- tvs.linio  %>%
        group_by(rangos, marca) %>%
        summarise(cantidad.marca = length(marca)) %>% 
        mutate(porcentaje = cantidad.marca/sum(cantidad.marca))




ggplot(tvs.linio.porcentajes, aes(x=rangos, y= porcentaje ,fill=marca)) + 
        geom_bar(stat = "identity", width = .7) +
        scale_fill_brewer(palette="Set3") +
        labs(title = "Linio Perú \n % marca de tvs por rango de precios",
             x = "rango de precios", y = "% cantidad de tvs") +
        theme(axis.text.x = element_text(colour="grey20",size=14,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=14,,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=14,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(vjust=2)) +
        scale_y_continuous(labels=percent)


