library(RSelenium)
library(rvest)
library(reshape2)
library(stringr)
library(dplyr)
library(ggplot2)


setwd("D:\\RCoursera\\Falabella")




#start RSelenium


rD  <- rsDriver(port = 5625L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]



falabella_urls <- c("http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=0&Nrpp=16",
               "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=16&Nrpp=16",
               "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=32&Nrpp=16",
               "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=48&Nrpp=16",
               "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=64&Nrpp=16",
               "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=80&Nrpp=16")





falabella_data_list <- list()


for (i in falabella_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  page_source<-remDr$getPageSource()
  
  
  product_info <- function(node){
    
    s.marca <- html_nodes(node,"div.marca a") %>% html_text
    s.producto <- html_nodes(node,"div.detalle a") %>% html_attr("href")
    s.precio.antes <- html_nodes(node, "div.precio2 span") %>% html_text
    s.precio.actual <- html_nodes(node, "div.precio1 span") %>% html_text 
    #s.precio.antes <- html_nodes(node, "div.precio3 span") %>% html_text 
    s.recojo.tienda <- html_nodes(node, ".ico_cuatro") %>% html_text 
    s.solo.online <- html_nodes(node, ".ico_dos") %>% html_text
    
    
    
    data.frame(
      fecha = as.character(Sys.Date()),
      categoria = "televisores",
      ecommerce = "falabella",
      marca = s.marca,
      producto = s.producto,
      precio.antes = ifelse(length(s.precio.antes) == 0, NA, s.precio.antes),
      precio.actual = ifelse(length(s.precio.actual) == 0, NA, s.precio.actual),
      #precio.normal = ifelse(length(s.precio.antes) == 0, NA, s.precio.antes),
      #precio.internet = ifelse(length(s.precio.internet) == 0, NA, s.precio.internet),
      #precio.unica = s.precio.unica,
      recojo.tienda = ifelse(length(s.recojo.tienda) == 0, NA, s.recojo.tienda),
      solo.online = ifelse(length(s.solo.online) == 0, NA, s.solo.online),
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
    html_nodes(".cajaLP4x")
  
  
  
  
  tvs <- lapply(doc, product_info) %>%
    bind_rows()
  
  
  falabella_data_list[[i]] <- tvs # add it to your list
  
  
  
  
}



falabella_tvs = do.call(rbind, falabella_data_list)


#falabella_tvs <- cbind(fecha = as.character(Sys.Date()), falabella_tvs)

rownames(falabella_tvs) <- NULL




#############################


falabella_tvs$producto <- sub(".*\\/", "", falabella_tvs$producto)

falabella_tvs$producto <- sub("\\?.*$", "", falabella_tvs$producto)


falabella_tvs$producto <- sub("\\;.*$", "", falabella_tvs$producto)


#####################################################################
########### REMOVIENDO PRECOJO EN TIENDA Y SOLO ONLINE ##############
#####################################################################



falabella_tvs2 <- falabella_tvs[,c(1,2,3,4,5,6,7)]


### Completar las pulgadas de 2 TVs a mano


#####################################################################
#####################################################################






file <- paste( as.character(Sys.Date()),"falabella-tvs", sep = "-")

falabella_tvs2_csv <- paste(file, "csv", sep = ".")


write.csv(falabella_tvs2, falabella_tvs2_csv, row.names = F)
