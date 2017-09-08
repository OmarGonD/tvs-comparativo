library(rvest)
library(dplyr)
library(stringr)
library(urltools)




###


# Aquí solo faltan los de TV y Electrohogar que no se puede obtener
# desde la misma página de Falabella.


falabella_paths <- read_html("http://www.falabella.com.pe/falabella-pe/browse/siteMap.jsp") %>%
  html_nodes(".linkgrismapasitio") %>% html_attr("href")




for (i in seq_along(falabella_paths)) {
  
  falabella_paths[i] <- gsub(";.*", "", falabella_paths[i])
  
}



falabella_paths <- falabella_paths[!grepl("#|myaccount|servicio|static|bancofalabella|viajes|falabellapro|falabella\\.com\\.[ar|pe]|venta",
                                          falabella_paths, ignore.case = T)]


falabella_dominio <- "www.falabella.com.pe"


falabella_dominio_path <- c()




for (i in seq_along(falabella_paths)) {
  
  
  falabella_dominio_path <- paste0(falabella_dominio, falabella_paths)
  
}



falabella_dominio_path








