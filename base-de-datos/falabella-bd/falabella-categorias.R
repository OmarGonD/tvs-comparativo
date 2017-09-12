library(ggplot2)
library(dplyr)
library(urltools)
library(stringr)



#setwd("D:\\RCoursera\\r-s-l\\extraer-datos\\falabella") #PC

setwd("D:\\rls\\tvs-comparativo\\extraer-datos\\falabella") #LAPTOP




falabella <- dir(getwd(), full.names = TRUE) %>%
             map(read_csv, col_names = TRUE) %>% bind_rows()




falabella$producto <- gsub(";.*", "", falabella$producto)

falabella$producto <- gsub("\\?.*", "", falabella$producto)



#falabella$producto <- str_split(falabella$producto, "/")


for (i in seq_along(falabella$producto)) {
  
  falabella$producto[i] <- str_split(falabella$producto[i], "/")[[1]][5]
  
}



falabella$producto <- gsub("\\-", " ", falabella$producto)



str_split(falabella$producto[22], "/")[[1]][5]




# Nombrar categorias: se nombran manualmente a partir de las subcategorias
# que se obtienen de las URLs.




hombre <- paste("Accesorios-Hombre", "Marcas-Destacadas",
                "Moda-Hombre", "Ropa-Formal",
                "Ropa-Interior", "Solo-Jeans-Hombre",
                "Zapatos-Hombre", sep = "|")



falabella$categoria <- gsub(hombre, "Hombre",
                            falabella$subcategoria)



###



accesorios <- paste("Carteras-y-Bolsos", "Joyas",
                    "Marcas-Accesorios", "Relojes",
                    "Accesorios-Mujer", "Lentes-de-Sol",
                    sep = "|")



falabella$categoria <- gsub(accesorios, "Accesorios",
                            falabella$categoria)




###


belleza <- paste("Belleza-Hombre", "Cuidado-del-Cabello",
                 "Cuidado-del-Cuerpo", "Cuidado-del-Rostro",
                 "Secadoras-de-Cabello", 
                 "Alisadoras-de-Cabello", "Onduladores-de-Cabello",
                 "Depiladoras", "Afeitadoras",
                 "Bienestar", "Ver-Todo-Cuidado-Personal", 
                 "Maquillaje", "Marcas-de-Belleza",
                 "Perfumes", "Promos-ocultas", sep = "|")




falabella$categoria <- gsub(belleza, "Belleza",
                            falabella$categoria)


###


deportes <- paste("Bicicletas", "Campamentos-y-Ocio", "Hombre",
                  "Mujer", "Mundo-Deportes", "Mundo-Fitness",
                  "Ninos", "Zapatillas", sep= "|")


falabella$categoria <- gsub(deportes, "Deportes",
                            falabella$categoria)




###



dormitorio <- paste("Blanco", "Camas-Box-Spring", 
                    "Camas-Box-Tarima", "Colchones",
                    "Dormitorio-Infantil", "Marcas-Destacadas",
                    "Muebles-de-Dormitorio", "Promociones-dormitorio",
                    "Ropa-de-Cama", "Sets-de-Dormitorio", sep = "|")




falabella$categoria <- gsub(dormitorio, "Dormitorio",
                            falabella$categoria)





###


electrohogar <- paste("Audio", "Computadoras",
                      "Camara-de-fotos", "Linea-Blanca",
                      "Promociones-electro", "TV-LED",
                      "4K-Ultra-HD", "Curvo", "LED-Smart-TV",
                      "Full-HD", "OLED", "QLED", "Smartphones",
                      "Celulares-Desbloqueados", "Fundas-para-Celulares-y-Laminas",
                      "Cargadores-de-Celulares", "Smartwatch", "Audifonos",
                      "Parlantes-Bluetooth", "Realidad-Virtual", "Camaras-Instantaneas",
                      "Accesorios-Fotografia", "Drones", "Camaras-Reflex",
                      "PS4", "PS3", "Xbox-One", "Wii-U", "3DS", "Nintendo-Switch", "Juegos",
                      "Accesorios-Videojuegos", "Electrodomesticos-de-Cocina",
                      sep= "|")




falabella$categoria <- gsub(electrohogar, "Electrohogar y Tecnologia",
                            falabella$categoria)




###



muebles <- paste("Maletas-y-Mochilas", "Comedor",
                 "Decoracion", "Espacios-del-Hogar",
                 "Menaje-Cocina", "Menaje-Comedor",
                 "Muebles", "Sala", sep= "|")




falabella$categoria <- gsub(muebles, "Muebles y Decohogar",
                            falabella$categoria)




###



mujer <- paste("Accesorios-Mujer", "Marcas-Destacadas",
               "Moda-Juvenil", "Moda-Mujer", "Ropa-Interior-Mujer",
               "Solo-Jeans-Mujer", "Zapatos-Mujer",
               sep= "|")



falabella$categoria <- gsub(mujer, "Mujer",
                            falabella$categoria)


###


ninos <- paste("Dormitorio-Infantil", "Juegos-de-Exterior-e-Interior",
               "Juguetes-Bebe-y-Preescolares", "Juguetes-Ninas",
               "Juguetes-Ninos", "Moda-Infantil", "Mundo-Bebe",
               sep= "|")



falabella$categoria <- gsub(ninos, "Niños",
                            falabella$categoria)



###



zapatos <- paste("Zapatillas", "Zapatos-Hombre",
                 "Zapatos-Mujer", "Marcas-Deportivas",
                 "Marcas-Zapatos-Hombre", "Marcas-Zapatos-Mujer",
                 "Zapatos-Ninos", sep= "|")


falabella$categoria <- gsub(zapatos, "Zapatos",
                            falabella$categoria)





### Ordenando columnas 

falabella <- falabella[, c(1,3,8,2,4,5,6,7)]



### 
#setwd("D:\\RCoursera\\r-s-l\\base-de-datos\\falabella-bd") #PC
setwd("D:\\rls\\tvs-comparativo\\base-de-datos\\falabella-bd") #Laptop




file <- paste( as.character(Sys.Date()),"falabella-bd", sep = "-")

falabella_csv <- paste(file, "csv", sep = ".")


write.csv(falabella, falabella_csv, row.names = F)






