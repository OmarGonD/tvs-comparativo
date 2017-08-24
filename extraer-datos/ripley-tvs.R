library(RSelenium)
library(rvest)
library(dplyr)


#setwd("D:\\RCoursera\\Ripley")
setwd("D:\\rls\\tvs-comparativo\\extraer-datos")

#start RSelenium


rD  <- rsDriver(port = 4532L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]




ripley_tvs_urls <- c("http://www.ripley.com.pe/ripley-peru/tv-todas",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=2&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=3&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=4&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=5&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=6&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=7&orderBy=")







ripley_tvs_data_list <- list()


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
#### LAPTOPS #################


library(RSelenium)
library(rvest)
library(dplyr)


#setwd("D:\\RCoursera\\Ripley")
setwd("D:\\rls\\pcs-comparativo\\extraer-datos")

#start RSelenium


rD  <- rsDriver(port = 4532L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]




ripley_pcs_urls <- c("http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=1",
                     "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=2",
                     "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=3",
                     "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=4")







ripley_pcs_data_list <- list()


for (i in ripley_pcs_urls) {
  
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
  
  
  
  
  
  
  
  pcs <- lapply(doc, product_info) %>%
    bind_rows()
  
  
  ripley_pcs_data_list[[i]] <- pcs # add it to your list
  
  
  
  
}



ripley_pcs = do.call(rbind, ripley_pcs_data_list)


#ripley_pcs <- cbind(fecha = as.character(Sys.Date()), ripley_pcs)


rownames(ripley_pcs) <- NULL


###################################################



ripley_tvs2 <- ripley_tvs[,c(1,2,3,4,5,6)]


### Completar las pulgadas de 2 TVs a mano


#####################################################################
#####################################################################






file <- paste( as.character(Sys.Date()),"ripley-tvs", sep = "-")

ripley_tvs2_csv <- paste(file, "csv", sep = ".")


write.csv(ripley_tvs2, ripley_tvs2_csv, row.names = F)
