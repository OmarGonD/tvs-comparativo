library(RSelenium)
library(rvest)
library(dplyr)


#setwd("D:\\RCoursera\\Ripley")
setwd("D:\\rls\\tvs-comparativo\\extraer-datos")
#setwd("D:\\RCoursera\\r-s-l\\extraer-datos")



#start RSelenium


rD  <- rsDriver(port = 4535L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]



#### URLS ######



ripley_tvs_urls <- c("http://www.ripley.com.pe/ripley-peru/tv-todas",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=2&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=3&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=4&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=5&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=6&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=7&orderBy=")








ripley_computo_urls <- c("http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=1",
                         "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=2",
                         "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=3",
                         "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=4",
                         "http://simple.ripley.com.pe/computo/2-en-1-convertibles/laptops-2-en-1",
                         "http://simple.ripley.com.pe/computo/computadoras/pc-all-in-one",
                         "http://simple.ripley.com.pe/computo/zona-gamer/laptops-gamer",
                         "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/tablets-y-phablets?page=1",
                         "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/tablets-y-phablets?page=2",
                         "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/tablets-y-phablets?page=3",
                         "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/estuches-y-fundas",
                         "http://simple.ripley.com.pe/computo/impresoras-y-tintas/todo-impresoras?page=1",
                         "http://simple.ripley.com.pe/computo/impresoras-y-tintas/todo-impresoras?page=2",
                         "http://simple.ripley.com.pe/computo/impresoras-y-tintas/multifuncionales",
                         "http://simple.ripley.com.pe/computo/impresoras-y-tintas/toners-y-tintas?page=1",
                         "http://simple.ripley.com.pe/computo/impresoras-y-tintas/toners-y-tintas?page=2",
                         "http://simple.ripley.com.pe/computo/accesorios-y-software/mouse-teclados-y-parlantes?page=1",
                         "http://simple.ripley.com.pe/computo/accesorios-y-software/mouse-teclados-y-parlantes?page=2",
                         "http://simple.ripley.com.pe/computo/accesorios-y-software/estuches-y-maletines?page=1",
                         "http://simple.ripley.com.pe/computo/accesorios-y-software/estuches-y-maletines?page=2",
                         "http://simple.ripley.com.pe/computo/accesorios-y-software/cargadores-cables-y-otros",
                         "http://simple.ripley.com.pe/computo/accesorios-y-software/software-y-antivirus",
                         "http://simple.ripley.com.pe/computo/almacenamiento/memorias-usb",
                         "http://simple.ripley.com.pe/computo/almacenamiento/discos-duros?page=1",
                         "http://simple.ripley.com.pe/computo/almacenamiento/discos-duros?page=2",
                         "http://simple.ripley.com.pe/computo/almacenamiento/pendrives",
                         "http://simple.ripley.com.pe/computo/proyectores-y-monitores/proyectores",
                         "http://simple.ripley.com.pe/computo/proyectores-y-monitores/monitores?page=1",
                         "http://simple.ripley.com.pe/computo/proyectores-y-monitores/monitores?page=2"
)




#### Data Lists #####



ripley_tvs_data_list <- list()

ripley_computo_data_list <- list()



#### Extracción de datos ####




for (i in ripley_tvs_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  page_source<-remDr$getPageSource()
  
  
  
  product_info <- function(node){
    r.precio.antes <- html_nodes(node, 'span.catalog-product-list-price') %>% html_text
    r.precio.actual <- html_nodes(node, 'span.catalog-product-offer-price') %>% html_text 
    r.producto <- html_nodes(node,"span.catalog-product-name") %>% html_text
    
    
    
    
    
    data.frame(
      fecha = as.character(Sys.Date()),
      categoria = "televisores",
      ecommerce = "ripley",
      producto = r.producto,
      precio.antes = ifelse(length(r.precio.antes)==0, NA, r.precio.antes),
      precio.actual = ifelse(length(r.precio.actual)==0, NA, r.precio.actual), 
      #tarjeta.ripley = ifelse(length(r.tarjeta)==0, NA, r.tarjeta),
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
    html_nodes("div.product-description")
  
  
  
  
  
  
  
  tvs <- lapply(doc, product_info) %>%
    bind_rows()
  
  
  ripley_tvs_data_list[[i]] <- tvs # add it to your list
  
  
  
  
}



ripley_tvs = do.call(rbind, ripley_tvs_data_list)


#ripley_tvs <- cbind(fecha = as.character(Sys.Date()), ripley_tvs)


rownames(ripley_tvs) <- NULL


###################################################
#### Computo #################






for (i in ripley_computo_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  page_source<-remDr$getPageSource()
  
  
  
  product_info <- function(node){
    r.precio.antes <- html_nodes(node, 'span.catalog-product-list-price') %>% html_text
    r.precio.actual <- html_nodes(node, 'span.catalog-product-offer-price') %>% html_text 
    r.producto <- html_nodes(node,"span.catalog-product-name") %>% html_text
    
    
    
    
    
    data.frame(
      fecha = as.character(Sys.Date()),
      categoria = "computo",
      ecommerce = "ripley",
      producto = r.producto,
      precio.antes = ifelse(length(r.precio.antes)==0, NA, r.precio.antes),
      precio.actual = ifelse(length(r.precio.actual)==0, NA, r.precio.actual), 
      #tarjeta.ripley = ifelse(length(r.tarjeta)==0, NA, r.tarjeta),
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
    html_nodes("div.product-description")
  
  
  
  
  
  
  
  computo <- lapply(doc, product_info) %>%
    bind_rows()
  
  
  ripley_computo_data_list[[i]] <- computo # add it to your list
  
  
  
  
}



ripley_computo = do.call(rbind, ripley_computo_data_list)


#ripley_computo <- cbind(fecha = as.character(Sys.Date()), ripley_computo)


rownames(ripley_computo) <- NULL


###################################################



#ripley_tvs2 <- ripley_tvs[,c(1,2,3,4,5,6)]


### Completar las pulgadas de 2 TVs a mano



ripley <- rbind(ripley_tvs, ripley_computo)


#####################################################################
#####################################################################






file <- paste( as.character(Sys.Date()),"ripley", sep = "-")

ripley_csv <- paste(file, "csv", sep = ".")


write.csv(ripley, ripley_csv, row.names = F)
