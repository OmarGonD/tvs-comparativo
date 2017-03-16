library(dplyr)
library(ggplot2)
library(hrbrthemes)
library(scales)
library(tibble)
library(plotly)


setwd("D:\\RCoursera\\r-s-l")



ripley.tv <- read.csv("D:\\RCoursera\\Ripley\\2017-02-22-r-tvs.csv", stringsAsFactors = F,
                      na.strings = "")



saga.tv <- read.csv("D:\\RCoursera\\Saga_falabella\\2017-s-tv.csv",
                    stringsAsFactors = F)




linio.tv <- read.csv("D:\\RCoursera\\Linio\\2017-02-19-l-tvs.csv",
                     stringsAsFactors = F)




### Añade columna marca en Ripley y Linio



linio.tv <-   linio.tv %>%
              add_column(marca = NA, .after = "ecommerce")



ripley.tv <- ripley.tv %>%
             add_column(marca = NA, .after = "ecommerce")






######################################################
### Saga cambiando nombre de columnas para que ###### 
### hagan match con los otros data frames ############
######################################################



linio.tv <- linio.tv[,c(1,2,3,4,5)]

saga.tv <- saga.tv[,c(1,2,3,4,5)]









# Precio Internet tiene que llamarse "Precio Antes"
# Precio Unica tiene que llamarse "Precio Actual"






######################################################
######################################################
############# TVs: Unir 3 dataframes  ################
######################################################
######################################################





### Unión de los 3 dfs

tvs <- rbind(ripley.tv, saga.tv,
             linio.tv)



tvs <- tvs %>%
       add_column(periodo = 2017, .before = "ecommerce")






#####


tvs$precio.antes <- gsub(".*s/\\.?", "", tvs$precio.antes, ignore.case = T)

tvs$precio.actual <- gsub(".*s/\\.?", "", tvs$precio.actual, ignore.case = T)



tvs$precio.antes <- gsub(",", "", tvs$precio.antes, ignore.case = T)



tvs$precio.actual <- gsub(",", "", tvs$precio.actual, ignore.case = T)



#
# 
# tvs$pulgadas <- sub(".*?(\\d+['\"]).*", "\\1", tvs$producto)
# tvs$pulgadas <- sub(".*?(\\d+{2}).*", "\\1", tvs$pulgadas)
# 
# 
# 
# 
# tvs$pulgadas <- sub('"', "", tvs$pulgadas)
# tvs$pulgadas <- sub("'", "", tvs$pulgadas)





tvs$pulgadas <- ifelse(grepl("23.6", tvs$producto),"23.6", sub(".*?(\\d+['\"]).*", "\\1", tvs$producto))



tvs$pulgadas <- ifelse(grepl("[a-zA-Z]", tvs$pulgadas),sub(".*?(\\d+{2}).*", "\\1", tvs$pulgadas), tvs$pulgadas)



tvs$pulgadas <- sub('"', "", tvs$pulgadas)
tvs$pulgadas <- sub("'", "", tvs$pulgadas)


sum(grepl("23.6", tvs$pulgadas))

######################################
##### Limpiar espacios en blanco #####
######################################



#tvs$marca <- trimws(tvs$marca, which = c("both"))
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
        mutate(rango = ifelse(precio.actual <= 500, "< S/.500",
                               ifelse(precio.actual > 500 & precio.actual <= 1500,
                                      "S/.500 -\n S/.1500",
                                      ifelse(precio.actual > 1500 & precio.actual <= 2500,"S/.1500 -\n S/.2500",
                                             ifelse(precio.actual > 2500 & precio.actual <= 3500,"S/.2500 -\n S/.3500",
                                                    ifelse(precio.actual > 3500 & precio.actual <= 4500,"S/.3500 -\n S/.4500",
                                                           "> S/.4,500"))))))



tvs$rango <- factor(tvs$rango, levels = c("< S/.500",
                                                       "S/.500 -\n S/.1500",
                                                       "S/.1500 -\n S/.2500",
                                                       "S/.2500 -\n S/.3500",
                                                       "S/.3500 -\n S/.4500",
                                                       "> S/.4,500"),
                          ordered = T)




########## Obtener Marca #############


tvs$marca <- ifelse(grepl("samsung", tvs$producto, ignore.case = T), "samsung",tvs$marca) 

tvs$marca <- ifelse(grepl("lg", tvs$producto, ignore.case = T), "lg",tvs$marca) 

tvs$marca <- ifelse(grepl("haier", tvs$producto, ignore.case = T), "haier",tvs$marca)

tvs$marca <- ifelse(grepl("panasonic", tvs$producto, ignore.case = T), "panasonic",tvs$marca)

tvs$marca <- ifelse(grepl("sony", tvs$producto, ignore.case = T), "sony",tvs$marca)

tvs$marca <- ifelse(grepl("sharp", tvs$producto, ignore.case = T), "sharp",tvs$marca)

tvs$marca <- ifelse(grepl("aoc", tvs$producto, ignore.case = T), "aoc",tvs$marca)

tvs$marca <- ifelse(grepl("imaco", tvs$producto, ignore.case = T), "imaco",tvs$marca)

tvs$marca <- ifelse(grepl("royal", tvs$producto, ignore.case = T), "royal",tvs$marca)

tvs$marca <- ifelse(grepl("daewoo", tvs$producto, ignore.case = T), "daewoo",tvs$marca)

tvs$marca <- ifelse(grepl("daewoo", tvs$producto, ignore.case = T), "daewoo",tvs$marca)

tvs$marca <- ifelse(grepl("miray", tvs$producto, ignore.case = T), "miray",tvs$marca)

tvs$marca <- ifelse(grepl("nex", tvs$producto, ignore.case = T), "nex",tvs$marca)

tvs$marca <- ifelse(grepl("xenon", tvs$producto, ignore.case = T), "xenon",tvs$marca)

tvs$marca <- ifelse(grepl("hyundai", tvs$producto, ignore.case = T), "hyundai",tvs$marca)

tvs$marca <- ifelse(grepl("altron", tvs$producto, ignore.case = T), "altron",tvs$marca)

tvs$marca <- ifelse(grepl("jvc", tvs$producto, ignore.case = T), "jvc",tvs$marca)

tvs$marca <- ifelse(grepl("blackline", tvs$producto, ignore.case = T), "blackline",tvs$marca)

tvs$marca <- ifelse(grepl("olitec", tvs$producto, ignore.case = T), "olitec",tvs$marca)





### Descuento en porcentajes ###



tvs <- tvs %>%
       mutate(descuento = precio.actual/precio.antes - 1)


################################

date <- Sys.Date()

tvsfile <- paste(paste(date, "tvs", sep = "-"), "csv", sep = ".")


write.csv(tvs, tvsfile, row.names = F)


################################

