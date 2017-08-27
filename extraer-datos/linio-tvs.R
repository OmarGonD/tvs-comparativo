#### Primero carga RSelenium, Luego RVEST, Dplyr.
#### Sino no te deja descargar el contenido de la web. ERROR JSON

library(RSelenium)
library(rvest)
library(dplyr)


#setwd("D:\\RCoursera\\Linio")
setwd("D:\\RCoursera\\r-s-l\\extraer-datos")

#start RSelenium


rD  <- rsDriver(port = 2654L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = FALSE, check = TRUE)



remDr <- rD[["client"]]



### URLS ###


linio_tvs_urls <- c("https://www.linio.com.pe/c/tv-y-video/televisores",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=2",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=3",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=4",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=5",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=6",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=7",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=8",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=9")




linio_computo_urls <- c("https://www.linio.com.pe/c/portatiles/laptops?page=1",
                        "https://www.linio.com.pe/c/portatiles/laptops?page=2",
                        "https://www.linio.com.pe/c/portatiles/laptops?page=3",
                        "https://www.linio.com.pe/c/portatiles/laptops?page=4",
                        "https://www.linio.com.pe/c/portatiles/laptops?page=5",
                        "https://www.linio.com.pe/c/portatiles/laptops?page=6",
                        "https://www.linio.com.pe/cm/laptops-alto-rendimiento",
                        "https://www.linio.com.pe/c/portatiles/notebooks?page=1",
                        "https://www.linio.com.pe/c/portatiles/notebooks?page=2",
                        "https://www.linio.com.pe/c/portatiles/notebooks?page=3",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=1",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=2",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=3",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=4",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=5",
                        "https://www.linio.com.pe/c/computacion/pc-escritorio?page=1",
                        "https://www.linio.com.pe/c/computacion/pc-escritorio?page=2",
                        "https://www.linio.com.pe/c/computacion/pc-escritorio?page=3",
                        "https://www.linio.com.pe/c/computacion/pc-escritorio?page=4",
                        "https://www.linio.com.pe/c/computacion/pc-escritorio?page=5",
                        "https://www.linio.com.pe/c/pc-escritorio/all-in-one",
                        "https://www.linio.com.pe/c/pc-escritorio/monitores?page=1",
                        "https://www.linio.com.pe/c/pc-escritorio/monitores?page=2",
                        "https://www.linio.com.pe/c/pc-escritorio/monitores?page=3",
                        "https://www.linio.com.pe/c/pc-escritorio/monitores?page=4",
                        "https://www.linio.com.pe/c/computacion/accesorios-de-computadoras?page=1",
                        "https://www.linio.com.pe/c/computacion/accesorios-de-computadoras?page=2",
                        "https://www.linio.com.pe/c/computacion/accesorios-de-computadoras?page=3",
                        "https://www.linio.com.pe/c/computacion/accesorios-de-computadoras?page=4",
                        "https://www.linio.com.pe/c/computacion/accesorios-de-computadoras?page=5",
                        "https://www.linio.com.pe/c/almacenamiento/discos-duros?page=1",
                        "https://www.linio.com.pe/c/almacenamiento/discos-duros?page=2",
                        "https://www.linio.com.pe/c/almacenamiento/discos-duros?page=3",
                        "https://www.linio.com.pe/c/almacenamiento/discos-duros?page=4",
                        "https://www.linio.com.pe/c/almacenamiento/discos-duros?page=5",
                        "https://www.linio.com.pe/c/almacenamiento/memorias-usb?page=1",
                        "https://www.linio.com.pe/c/almacenamiento/memorias-usb?page=2",
                        "https://www.linio.com.pe/c/almacenamiento/memorias-usb?page=3",
                        "https://www.linio.com.pe/c/almacenamiento/memorias-usb?page=4",
                        "https://www.linio.com.pe/c/almacenamiento/memorias-usb?page=5",
                        "https://www.linio.com.pe/c/almacenamiento/tarjetas-de-memoria?page=1",
                        "https://www.linio.com.pe/c/almacenamiento/tarjetas-de-memoria?page=2",
                        "https://www.linio.com.pe/c/almacenamiento/tarjetas-de-memoria?page=3",
                        "https://www.linio.com.pe/c/almacenamiento/tarjetas-de-memoria?page=4",
                        "https://www.linio.com.pe/c/almacenamiento/tarjetas-de-memoria?page=5",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=1",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=2",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=3",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=4",
                        "https://www.linio.com.pe/c/computacion/zona-gamer?page=5",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/impresoras?page=1",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/impresoras?page=2",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/impresoras?page=3",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/impresoras?page=4",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/impresoras?page=5",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/multifuncionales?page=1",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/multifuncionales?page=2",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/multifuncionales?page=3",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/multifuncionales?page=4",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/multifuncionales?page=5",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/scanners?page=1",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/scanners?page=2",
                        "https://www.linio.com.pe/c/impresoras-y-scanners/scanners?page=3")












linio_tvs_data_list <- list()

linio_computo_data_list <- list()


######################





for (i in linio_tvs_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  page_source<-remDr$getPageSource()
  
  
  
  product_info <- function(node){
    
    l.precio.antes <- html_nodes(node, 'div.discount-container span.original-price') %>% html_text()
    l.precio.actual <- html_nodes(node, "div.price-section div.price-secondary, div.price-section span.price-secondary") %>% html_text()
    l.producto <- html_nodes(node, "div.detail-container h2 a") %>% html_attr("title")
    l.shipping <- html_nodes(node,".delivery-date-text") %>% html_text()
    l.warning <-  html_nodes(node,".warning-label") %>% html_text()
    # l.precio.antes <-   gsub("\\S\\/\\. ", "", l.precio.antes)
    # l.precio.actual <-   gsub("\\S\\/\\. ", "", l.precio.actual)
    # 
    
    data.frame(
      fecha = as.character(Sys.Date()),
      categoria = "televisores",
      ecommerce = "linio",
      producto = l.producto,
      precio.antes = ifelse(length(l.precio.antes)==0, NA, l.precio.antes),
      precio.actual = ifelse(length(l.precio.actual)==0, NA, l.precio.actual), 
      product.shipping = ifelse(length(l.shipping)==0, NA, l.shipping), 
      advertencia = ifelse(length(l.warning)==0, NA, l.warning),
      # precio.antes = l.precio.antes,
      # precio.actual = l.precio.actual,
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  ### Ir a cada item de la seccion: cada item contiene TV imagen, Nombre, precios,
  ### shipping
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
         html_nodes("div.catalogue-product")
  
  
  
  
  tvs <- lapply(doc, product_info) %>%
         bind_rows()
  
  
  linio_tvs_data_list[[i]] <- tvs # add it to your list
  
  
  
  
}



linio_tvs = do.call(rbind, linio_tvs_data_list)


#linio_tvs <- cbind(fecha = as.character(Sys.Date()), linio_tvs)



rownames(linio_tvs) <- NULL




### Cómputo ###

for (i in linio_computo_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  page_source<-remDr$getPageSource()
  
  
  
  product_info <- function(node){
    
    l.precio.antes <- html_nodes(node, 'div.discount-container span.original-price') %>% html_text()
    l.precio.actual <- html_nodes(node, "div.price-section div.price-secondary, div.price-section span.price-secondary") %>% html_text()
    l.producto <- html_nodes(node, "div.detail-container h2 a") %>% html_attr("title")
    l.shipping <- html_nodes(node,".delivery-date-text") %>% html_text()
    l.warning <-  html_nodes(node,".warning-label") %>% html_text()
    # l.precio.antes <-   gsub("\\S\\/\\. ", "", l.precio.antes)
    # l.precio.actual <-   gsub("\\S\\/\\. ", "", l.precio.actual)
    # 
    
    data.frame(
      fecha = as.character(Sys.Date()),
      categoria = "cómputo",
      ecommerce = "linio",
      producto = l.producto,
      precio.antes = ifelse(length(l.precio.antes)==0, NA, l.precio.antes),
      precio.actual = ifelse(length(l.precio.actual)==0, NA, l.precio.actual), 
      product.shipping = ifelse(length(l.shipping)==0, NA, l.shipping), 
      advertencia = ifelse(length(l.warning)==0, NA, l.warning),
      # precio.antes = l.precio.antes,
      # precio.actual = l.precio.actual,
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  ### Ir a cada item de la seccion: cada item contiene TV imagen, Nombre, precios,
  ### shipping
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
    html_nodes("div.catalogue-product")
  
  
  
  
  computo <- lapply(doc, product_info) %>%
    bind_rows()
  
  
  linio_computo_data_list[[i]] <- computo # add it to your list
  
  
  
  
}



linio_computo = do.call(rbind, linio_computo_data_list)


#linio_computo <- cbind(fecha = as.character(Sys.Date()), linio_computo)



rownames(linio_computo) <- NULL


###


linio <- rbind(linio_tvs, linio_computo)

linio <- unique(linio)



######################

linio <- linio[,c(1,2,3,4,5,6)]




file <- paste( as.character(Sys.Date()),"linio", sep = "-")

linio_csv <- paste(file, "csv", sep = ".")


write.csv(linio, linio_csv, row.names = F)


