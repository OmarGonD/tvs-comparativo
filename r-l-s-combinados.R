library(dplyr)
library(reshape2)
library(gridExtra)
library(grid)
library(ggplot2)
library(scales)


setwd("D:\\RCoursera\\r-s-l")

ripley.tv <- read.csv("D:\\RCoursera\\Ripley\\2016-05-14-r-tvs.csv", stringsAsFactors = F,
                      na.strings = "")



saga.tv <- read.csv("D:\\RCoursera\\Saga_falabella\\2016-05-14-s-tvs.csv",
                    stringsAsFactors = F)




linio.tv <- read.csv("D:\\RCoursera\\Linio\\2016-05-14-l-tvs.csv",
                     stringsAsFactors = F)





######################################################
### Saga cambiando nombre de columnas para que ###### 
### hagan match con los otros data frames ############
######################################################



# Precio Internet tiene que llamarse "Precio Antes"
# Precio Unica tiene que llamarse "Precio Actual"

colnames(saga.tv)[4] <- "precio.antes"
colnames(saga.tv)[5] <- "precio.actual"





######################################################
######################################################
############# TVs: Unir 3 dataframes  ################
######################################################
######################################################





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





# tvs$marca <- factor(tvs$marca, levels = c("hisense","nex", "continental",
#                                                       "haier", "aoc",
#                                                       "sharp", "imaco","panasonic","sony",
#                                                       "lg", "samsung", "daewoo", "hyundai"),
#                           ordered = T)

###


### Reemplazar nombres reales de Ecommerce por nombres clave

# Ripley <- A
# Saga <- B
# Linio <- C

# 
# 
# tvs$ecommerce <- gsub("ripley", "a", tvs$ecommerce)
# tvs$ecommerce <- gsub("falabella", "b", tvs$ecommerce)
# tvs$ecommerce <- gsub("linio", "c", tvs$ecommerce)



tvs.cantidad <- tvs  %>%
        group_by(ecommerce) %>%
        summarise(cantidad = length(marca))



# tvs.cantidad$ecommerce <- factor(tvs.cantidad$ecommerce, levels = c("c",
#                                                           "a",
#                                                           "b"),
#                     ordered = T)



tvs.cantidad$ecommerce <- factor(tvs.cantidad$ecommerce, levels = c("linio",
                                                                    "ripley",
                                                                    "falabella"),
                                 ordered = T)




tt1 <- "Ecommerce con más TVs"
stt1 <- "Linio, Ripley y Saga Falabella (Falabella) son los 3 principales ecommerce del Perú.\n"
cptn <- "\nomargonzalesdiaz.com | Data Analyst"




ggplot(tvs.cantidad, aes(x=ecommerce, y= cantidad)) + 
        geom_bar(stat = "identity", width = .7, fill= "#1F96FF") +
        #facet_grid(~ ecommerce) +
        labs(title = "Ecommerce con más TVs\n",
             x = "", y = "") +
        theme(axis.text.x = element_text(colour="grey10",size=22,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey10",size=20,,hjust=0,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey40",size=6,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey40",size=6,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=2,face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16)) +
        geom_text(aes(label=cantidad), vjust=-0.25, size = 8) +
        ylim(0, 220) +
        labs(title = tt1, subtitle = stt1, caption = cptn,
             x = "", y = "")




ggsave(file="tvs-cantidad.jpg", width = 12, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")


### 


tvs.rangos <- tvs %>%
        group_by(ecommerce, rangos) %>%
        summarise(cantidad = length(rangos))


# 
# tvs.rangos$ecommerce <- factor(tvs.rangos$ecommerce, levels = c("c",
#                                                                 "a",
#                                                                 "b"),
#                                ordered = T)

unique(tvs.rangos$ecommerce)


tvs.rangos$ecommerce <- factor(tvs.rangos$ecommerce, levels = c("linio",
                                                                    "ripley",
                                                                    "falabella"),
                                 ordered = T)





tvs.rangos$rangos <- factor(tvs.rangos$rangos, levels = c("< S/.500",
                                            "S/.500 - S/.1500",
                                            "S/.1500 - S/.2500",
                                            "S/.2500 - S/.3500",
                                            "S/.3500 - S/.4500",
                                            "> S/.4,500"),
                     ordered = T)



# To use for fills, add

###


tt2 <- "Cantidad de TVs por rango de precios"
stt2 <- "\n"



ggplot(tvs.rangos, aes(x = rangos, y = cantidad, fill = ecommerce)) +
        geom_bar(stat = "identity") + 
        scale_fill_manual("ecommerce",
                values = c("linio" = "#FF5500","ripley" = "#802D69","falabella" = "#BED800")) +
        facet_wrap(~ ecommerce, nrow = 3) +
        coord_flip() + 
        theme(axis.text.x = element_text(colour="grey10",size=14,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey10",size=16,,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey40",size=16,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey40",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=4, face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.title = element_text(colour="grey40", size=16, face="bold"),
              legend.text = element_text(colour="grey10", size=16, face="bold"),
              strip.text.x = element_text(size = 20, angle = 0),
              legend.position = "none") +
        geom_text(aes(label=cantidad), hjust=-0.25, size = 6) +
        ylim(0, 125) +
        labs(title = tt2, subtitle = stt2, caption = cptn,
                 x = "", y = "")


ggsave(file="tvs-rango-precios.jpg", width = 12, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")

####




###






### Gráficos individuales por ecommerce ###

### ripley ###


tvs.ripley <- tvs[tvs$ecommerce == "ripley",]

tvs.ripley.porcentajes <- tvs.ripley  %>%
        group_by(rangos, marca) %>%
        summarise(cantidad.marca = length(marca)) %>% 
        mutate(porcentaje = cantidad.marca/sum(cantidad.marca))


tt3 <- "Ripley.com.pe % marcas de tvs por rango de precio"
stt3 <- "\n"






ggplot(tvs.ripley.porcentajes, aes(x=rangos, y= porcentaje ,fill=marca)) + 
        geom_bar(stat = "identity", width = .7) +
        theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(vjust=2, size = 24,face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.position = "top",
              legend.box = "horizontal",
              legend.title=element_blank(),
              legend.text=element_text(size=18)) +
        scale_y_continuous(labels=percent) +
        scale_fill_manual(
                values = c("haier" = "#8DD3C8","sony" = "#003366","panasonic" = "#FCB462",
                           "samsung" = "#7ec0ee", "lg" = "#A21420",
                           "aoc" = "#9DCC27", "sharp" = "#986FE8")) +
        labs(title = tt3, subtitle = stt3, caption = cptn,
             x = "", y = "")





ggsave(file="r-tvs-rango-precios.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")





### Ripley - BoxPlot





tvs.ripley.porcentajes <- tvs.ripley %>%
        group_by(marca, precio.antes, precio.actual) %>%
        mutate(dif.precios = precio.antes - precio.actual,
               dif.porcentual = round(100*dif.precios/precio.antes,2))


# 
# means.linio <- aggregate(dif.porcentual ~ rangos , tvs.linio.porcentajes, mean)
# means.linio$dif.porcentual <- round(medians$dif.porcentual,0)
# 
# max.percentage <- aggregate(dif.porcentual ~ rangos , ripley.tv.precios, max)
# max.percentage$dif.porcentual <- round(max.percentage$dif.porcentual,0)




tt4 <- "Ripley - variación % descuentos según rango de precios"
stt4 <- "\n"






a <- ggplot(tvs.ripley.porcentajes, aes(factor(rangos), dif.porcentual))


#p + geom_boxplot(fill = "white", colour = "#3366FF")
a + geom_boxplot(aes(colour = rangos), outlier.colour = "red", outlier.shape = 1, outlier.size = 4) + 
         theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=4,face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.position = "none") +
        labs(title = tt4, subtitle = stt4, caption = cptn,
             x = "", y = "")
 
               



ggsave(file="r-tvs-porcentajes.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")









### falabella ###



tvs.falabella <- tvs[tvs$ecommerce == "falabella",]

tvs.falabella.porcentajes <- tvs.falabella  %>%
        group_by(rangos, marca) %>%
        summarise(cantidad.marca = length(marca)) %>% 
        mutate(porcentaje = cantidad.marca/sum(cantidad.marca))




tt5 <- "Sagafalabella - % marcas de tvs por rango de precios"
stt5 <- "\n"



ggplot(tvs.falabella.porcentajes, aes(x=rangos, y= porcentaje ,fill=marca)) + 
        geom_bar(stat = "identity", width = .7) +
        theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(vjust=2, size = 24,face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.position = "top",
              legend.box = "horizontal",
              legend.title=element_blank(),
              legend.text=element_text(size=18)) +
        scale_y_continuous(labels=percent) +
        scale_fill_manual(
                values = c("hisense" = "#F39EF7","sony" = "#003366","panasonic" = "#FCB462",
                           "samsung" = "#7ec0ee", "lg" = "#A21420",
                           "aoc" = "#9DCC27", "sharp" = "#BEBBDA")) +
        labs(title = tt5, subtitle = stt5, caption = cptn,
             x = "", y = "")



ggsave(file="s-tvs-rango-precios.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")

### Falabella BoxPlot




tvs.falabella.porcentajes <- tvs.falabella %>%
        group_by(marca, precio.antes, precio.actual) %>%
        mutate(dif.precios = precio.antes - precio.actual,
               dif.porcentual = round(100*dif.precios/precio.antes,2))


# 
# means.linio <- aggregate(dif.porcentual ~ rangos , tvs.linio.porcentajes, mean)
# means.linio$dif.porcentual <- round(medians$dif.porcentual,0)
# 
# max.percentage <- aggregate(dif.porcentual ~ rangos , ripley.tv.precios, max)
# max.percentage$dif.porcentual <- round(max.percentage$dif.porcentual,0)



tt6 <- "Saga Falabella - variación % descuentos según rango de precios"
stt6 <- "\n"




b <- ggplot(tvs.falabella.porcentajes, aes(factor(rangos), dif.porcentual))

b + geom_boxplot(aes(colour = rangos), outlier.colour = "red", outlier.shape = 1,
                 outlier.size = 4) + 
        theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=4, face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.position = "none") +
        labs(title = tt6, subtitle = stt6, caption = cptn,
             x = "", y = "")



ggsave(file="s-tvs-porcentajes.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")










### linio ###



tvs.linio <- tvs[tvs$ecommerce == "linio",]
# 
# tvs.linio.porcentajes <- tvs.linio  %>%
#         group_by(rangos, marca) %>%
#         summarise(cantidad.marca = length(marca)) %>% 
#         mutate(porcentaje = cantidad.marca/sum(cantidad.marca))
# 





tvs.linio.porcentajes <- tvs.linio  %>%
        group_by(rangos, marca) %>%
        summarise(cantidad.marca = length(marca)) %>% 
        mutate(porcentaje = cantidad.marca/sum(cantidad.marca))






tt7 <- "Linio - % marca de tvs por rango de precios"
stt7 <- "\n"





ggplot(tvs.linio.porcentajes, aes(x=rangos, y= porcentaje ,fill=marca)) + 
        geom_bar(stat = "identity", width = .7) +
        theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(vjust=2, size = 24,face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.position = "top",
              legend.box = "horizontal",
              legend.title=element_blank(),
              legend.text=element_text(size=18)) +
        scale_y_continuous(labels=percent) +
        scale_fill_manual(
                values = c("hisense" = "#EE6CF5","sony" = "#003366","panasonic" = "#FCB462",
                           "samsung" = "#7ec0ee", "lg" = "#A21420", "altron" = "#E6981C",
                           "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "olitec" = "#3A76D6",
                           "imaco" = "#00C18C", "nex" = "#DE8D00", "haier" = "#01BA38",
                           "continental" = "#BD9C00", "daewoo" = "#968363", "king master" = "#EDED6F",
                           "blackline" = "#5BD4BA", "hyundai" = "#01B3EF", "miray" = "#ED6F87",
                           "royal" = "#5A9AED")) +
        labs(title = tt7, subtitle = stt7, caption = cptn,
             x = "", y = "")




ggsave(file="l-tvs-rango-precios.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")



### Linio BoxPlot



### Linio




tvs.linio.porcentajes <- tvs.linio %>%
        group_by(marca, precio.antes, precio.actual) %>%
        mutate(dif.precios = precio.antes - precio.actual,
               dif.porcentual = round(100*dif.precios/precio.antes,2))





tt8 <- "Linio - variación % descuentos según rango de precios"
stt8 <- "\n"



l <- ggplot(tvs.linio.porcentajes, aes(factor(rangos), dif.porcentual))



l + geom_boxplot(aes(colour = rangos), outlier.colour = "red", outlier.shape = 1,
                 outlier.size = 4) + 
        labs(title = tt8,
             x = "\nrango de precios", y = "descuentos en %\n") +
        theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=4,face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.position = "none") +
        labs(title = tt8, subtitle = stt8, caption = cptn,
             x = "", y = "")






ggsave(file="l-tvs-porcentajes.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")




# 
# ### Todos
# 
# 
# ##### Porcentajes BoxPlot
# 
# tvs.aaa <- tvs %>% 
#         group_by(marca) %>%
#         summarise(p = sum(precio.actual))
# 
# 
tvs.porcentajes <- tvs %>%
        group_by(marca, precio.antes, precio.actual) %>%
        # summarise(precio.antes = sum(precio.antes, na.rm = T),
        #           precio.actual = sum(precio.actual, na.rm = T)) %>%
        mutate(dif.precios = precio.antes - precio.actual,
               dif.porcentual = round(dif.precios/precio.antes,2))
# 
# 

#Utilizamos median en vez de mean en los boxplots
#
medians <- aggregate(dif.porcentual ~ rangos , tvs.porcentajes, median)
medians$dif.porcentual <- round(medians$dif.porcentual,0)
#
# max.percentage <- aggregate(dif.porcentual ~ rangos , ripley.tv.precios, max)
# max.percentage$dif.porcentual <- round(max.percentage$dif.porcentual,0)



tt9 <- "Total Ecommerce - variación % descuentos según rango de precios"
stt9 <- "\n"





p <- ggplot(tvs.porcentajes, aes(factor(rangos), dif.porcentual))




#p + geom_boxplot(fill = "white", colour = "#3366FF")
p + geom_boxplot(fill = "white", colour = "#3366FF", outlier.colour = "blue", outlier.shape = 1,
        outlier.size = 4) +
        theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),
              axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=4,face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.position = "none") +
         # geom_text(data = medians, aes(label = dif.porcentual, y = dif.porcentual + 1.5),
         #           colour = "grey20", size = 6, vjust = -0.01) +
        scale_y_continuous(label=percent) +
        labs(title = tt9, subtitle = stt9, caption = cptn,
             x = "", y = "")



ggsave(file="todos-tvs-porcentajes.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")



### Scaterplot Pulgadas vs Precios


tt10 <- "Precio de televisores según su tamaño (pulgadas)"
stt10 <- "\n"






pulgadas_precio <- ggplot(tvs, aes(x = pulgadas, y = precio.actual))


pulgadas_precio + geom_point(aes(color=factor(marca)),size = 4,alpha = 0.6) +
        facet_grid(. ~ ecommerce) +
        theme(axis.text.x = element_text(colour="grey10",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey10",size=18,,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey40",size=16,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey40",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
              plot.title = element_text(size = 24,vjust=4, face="bold"),
              plot.subtitle = element_text(vjust=2, size = 16),
              plot.caption = element_text(vjust=2, size = 16),
              legend.title = element_text(colour="grey40",size=14,hjust=.5,vjust=.5,face="bold"),
              legend.text = element_text(colour="grey10", size=18, face="plain"),
              strip.text.x = element_text(size = 20, angle = 0)) +
        scale_y_continuous(label=comma) +
        labs(title = tt10, subtitle = stt10, caption = cptn,
             x = "pulgadas \n", y = "precio en S/. \n") +
        scale_color_discrete(name="marcas de tvs")

        
        
        
ggsave(file="tvs-pulgadas-precios.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")        
        
        
        


### Write CSV con datos totales TVS


file <- paste(as.character(Sys.Date()),"total-tvs", sep = "-")

total.tvs.csv <- paste(file, "csv", sep = ".")


## 1er arg es l.tv // 2do arg es nombres del archivo

write.csv(tvs, total.tvs.csv, row.names = F)


