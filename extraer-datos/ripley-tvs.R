library(RSelenium)
library(rvest)
library(dplyr)
library(tidyr)
library(stringr)
library(urltools)

#setwd("D:\\RCoursera\\Ripley")
#setwd("D:\\rls\\tvs-comparativo\\extraer-datos") #LAPTOP
setwd("D:\\RCoursera\\r-s-l\\extraer-datos") #PC



#start RSelenium


rD  <- rsDriver(port = 4544L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]



#### URLS #####


ripley_urls <- read.csv2("ripley-urls-totales.csv")



###############




#### Data Lists #####



ripley_data_list <- list()

#### Extracci?n de datos ####




for (i in ripley_urls$url) {
  
  remDr$navigate(i)
  
  print(i)
  
  Sys.sleep(03)
  
  #1 == Categoria: C?mputo
  #2 == Subcategoria: Proyectores y monitores
  #3 == Producto: Monitores
    
  categoria_url <- (str_split(path(i), "\\/")[[1]][1])
  subcategoria_url <- (str_split(path(i), "\\/")[[1]][2])
  #producto_url <- (str_split(path(i), "\\/")[[1]][3])
  
  
  
  page_source<-remDr$getPageSource()
  
  
  
  product_info <- function(node){
    # r.categoria <- categoria
    # r.subcategoria <- subcategoria
    # r.producto <- producto
    r.precio.antes <- html_nodes(node, 'span.catalog-product-list-price') %>% html_text
    r.precio.actual <- html_nodes(node, 'span.catalog-product-offer-price') %>% html_text 
    r.producto <- html_nodes(node,"span.catalog-product-name") %>% html_text
    
    
    
    
    
    data.frame(
      fecha = as.character(Sys.Date()),
      ecommerce = "Ripley",
      categoria = categoria_url,
      subcategoria = subcategoria_url,
      #producto_url = producto_url,
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
  
  
  ripley_data_list[[i]] <- tvs # add it to your list
  
  
}



ripley = do.call(rbind, ripley_data_list)


#ripley_tvs <- cbind(fecha = as.character(Sys.Date()), ripley_tvs)


rownames(ripley) <- NULL



#####################################################################
#####################################################################



# 
file <- paste( as.character(Sys.Date()),"ripley", sep = "-")

ripley_csv <- paste(file, "csv", sep = ".")


write.csv(ripley, ripley_csv, row.names = F)
