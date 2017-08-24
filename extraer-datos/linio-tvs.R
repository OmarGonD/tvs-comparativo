#### Primero carga RSelenium, Luego RVEST, Dplyr.
#### Sino no te deja descargar el contenido de la web. ERROR JSON

library(RSelenium)
library(rvest)
library(dplyr)


setwd("D:\\RCoursera\\Linio")

#start RSelenium


rD  <- rsDriver(port = 2652L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = FALSE, check = TRUE)



remDr <- rD[["client"]]



linio_urls <- c("https://www.linio.com.pe/c/tv-y-video/televisores",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=2",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=3",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=4",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=5",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=6",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=7",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=8",
                "https://www.linio.com.pe/c/tv-y-video/televisores?page=9")



linio_data_list <- list()


######################





for (i in linio_urls) {
  
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
  
  
  linio_data_list[[i]] <- tvs # add it to your list
  
  
  
  
}



linio_tvs = do.call(rbind, linio_data_list)


#linio_tvs <- cbind(fecha = as.character(Sys.Date()), linio_tvs)



rownames(linio_tvs) <- NULL




######################

linio_tvs <- linio_tvs[,c(1,2,3,4,5,6)]




file <- paste( as.character(Sys.Date()),"linio-tvs", sep = "-")

linio_tvs_csv <- paste(file, "csv", sep = ".")


write.csv(linio_tvs, linio_tvs_csv, row.names = F)


