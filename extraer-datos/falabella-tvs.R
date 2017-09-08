library(RSelenium)
library(rvest)
library(dplyr)
library(stringr)
library(urltools)



setwd("D:\\rls\\productos-comparativo\\extraer-datos")
#setwd("D:\\RCoursera\\Falabella")
#setwd("D:\\RCoursera\\r-s-l\\extraer-datos")


#start RSelenium


rD  <- rsDriver(port = 4503L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]




### URLS ###



falabella_urls <- read.csv("falabella-urls-totales.csv", stringsAsFactors = F)


#falabella_urls$url[1]

#############################



falabella_data_list <- list()



for (i in falabella_urls$url) {
  
  remDr$navigate(i)
  
  Sys.sleep(05)
  
  page_source<-remDr$getPageSource()
  
  
  
  
  product_info <- function(node){
    
    
    subcategoria_url <- str_split(path(i), "\\/")[[1]][4]
    s.marca <- html_nodes(node,"div.marca a") %>% html_text
    s.producto <- html_nodes(node,"div.detalle a") %>% html_attr("href")
    s.precio.antes <- html_nodes(node, "div.precio2 span") %>% html_text
    s.precio.actual <- html_nodes(node, "div.precio1 span") %>% html_text 
    #s.precio.antes <- html_nodes(node, "div.precio3 span") %>% html_text 
    #s.recojo.tienda <- html_nodes(node, ".ico_cuatro") %>% html_text 
    #s.solo.online <- html_nodes(node, ".ico_dos") %>% html_text
    
    
    
    data.frame(
      fecha = as.character(Sys.Date()),
      subcategoria = subcategoria_url,
      ecommerce = "Falabella",
      marca = s.marca,
      producto = s.producto,
      precio.antes = ifelse(length(s.precio.antes) == 0, NA, s.precio.antes),
      precio.actual = ifelse(length(s.precio.actual) == 0, NA, s.precio.actual),
      #precio.normal = ifelse(length(s.precio.antes) == 0, NA, s.precio.antes),
      #precio.internet = ifelse(length(s.precio.internet) == 0, NA, s.precio.internet),
      #precio.unica = s.precio.unica,
      #recojo.tienda = ifelse(length(s.recojo.tienda) == 0, NA, s.recojo.tienda),
      #solo.online = ifelse(length(s.solo.online) == 0, NA, s.solo.online),
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
    html_nodes(".cajaLP4x")
  
  
  
  
  productos <- lapply(doc, product_info) %>%
         bind_rows()
  
  
  falabella_data_list[[i]] <- productos # add it to your list
  
  
  
  
}



falabella = do.call(rbind, falabella_data_list)


#falabella <- cbind(fecha = as.character(Sys.Date()), falabella)

rownames(falabella) <- NULL






file <- paste( as.character(Sys.Date()),"falabella", sep = "-")

falabella_csv <- paste(file, "csv", sep = ".")


write.csv(falabella, falabella_csv, row.names = F)
