library(RSelenium)
library(rvest)
library(dplyr)



setwd("D:\\rls\\tvs-comparativo\\extraer-datos")
#setwd("D:\\RCoursera\\Falabella")
#setwd("D:\\RCoursera\\r-s-l\\extraer-datos")


#start RSelenium


rD  <- rsDriver(port = 4444L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]




### URLS ###



falabella_tvs_urls <- c("http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=0&Nrpp=16",
                        "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=16&Nrpp=16",
                        "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=32&Nrpp=16",
                        "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=48&Nrpp=16",
                        "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=64&Nrpp=16",
                        "http://www.falabella.com.pe/falabella-pe/category/cat6370557/Ver-Todo-TV?No=80&Nrpp=16")





falabella_tvs_data_list <- list()




falabella_computo_urls <- c()

page_a = "http://www.falabella.com.pe/falabella-pe/category/cat50678/Computadoras?No="
page_b = "&Nrpp=16"


for (i in 1:37) {
  
  num_page = i
  num_page = (i - 1) * 16
  
  falabella_computo_urls <- c(falabella_computo_urls, paste0(page_a, num_page, page_b))
  
  
}




falabella_computo_data_list <- list()







#############################



for (i in falabella_tvs_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  page_source<-remDr$getPageSource()
  
  
  product_info <- function(node){
    
    s.marca <- html_nodes(node,"div.marca a") %>% html_text
    s.producto <- html_nodes(node,"div.detalle a") %>% html_attr("href")
    s.precio.antes <- html_nodes(node, "div.precio2 span") %>% html_text
    s.precio.actual <- html_nodes(node, "div.precio1 span") %>% html_text 
    #s.precio.antes <- html_nodes(node, "div.precio3 span") %>% html_text 
    #s.recojo.tienda <- html_nodes(node, ".ico_cuatro") %>% html_text 
    #s.solo.online <- html_nodes(node, ".ico_dos") %>% html_text
    
    
    
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
      #recojo.tienda = ifelse(length(s.recojo.tienda) == 0, NA, s.recojo.tienda),
      #solo.online = ifelse(length(s.solo.online) == 0, NA, s.solo.online),
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
    html_nodes(".cajaLP4x")
  
  
  
  
  tvs <- lapply(doc, product_info) %>%
         bind_rows()
  
  
  falabella_tvs_data_list[[i]] <- tvs # add it to your list
  
  
  
  
}



falabella_tvs = do.call(rbind, falabella_tvs_data_list)


#falabella_tvs <- cbind(fecha = as.character(Sys.Date()), falabella_tvs)

rownames(falabella_tvs) <- NULL




#############################


for (i in falabella_computo_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  page_source<-remDr$getPageSource()
  
  
  product_info <- function(node){
    
    s.marca <- html_nodes(node,"div.marca a") %>% html_text
    s.producto <- html_nodes(node,"div.detalle a") %>% html_attr("href")
    s.precio.antes <- html_nodes(node, "div.precio2 span") %>% html_text
    s.precio.actual <- html_nodes(node, "div.precio1 span") %>% html_text 
    #s.precio.antes <- html_nodes(node, "div.precio3 span") %>% html_text 
    #s.recojo.tienda <- html_nodes(node, ".ico_cuatro") %>% html_text 
    #s.solo.online <- html_nodes(node, ".ico_dos") %>% html_text
    
    
    
    data.frame(
      fecha = as.character(Sys.Date()),
      categoria = "cómputo",
      ecommerce = "falabella",
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
  
  
  
  
  computo <- lapply(doc, product_info) %>%
    bind_rows()
  
  
  falabella_computo_data_list[[i]] <- computo # add it to your list
  
  
  
  
}



falabella_computo = do.call(rbind, falabella_computo_data_list)


#falabella_computo <- cbind(fecha = as.character(Sys.Date()), falabella_computo)

rownames(falabella_computo) <- NULL




###############################################
###############################################




falabella <- rbind(falabella_tvs, falabella_computo)

falabella <- unique(falabella)


###########################################################
###########################################################






falabella$producto <- sub(".*\\/", "", falabella$producto)

falabella$producto <- sub("\\?.*$", "", falabella$producto)


falabella$producto <- sub("\\;.*$", "", falabella$producto)





#####################################################################
#####################################################################






file <- paste( as.character(Sys.Date()),"falabella", sep = "-")

falabella_csv <- paste(file, "csv", sep = ".")


write.csv(falabella, falabella_csv, row.names = F)
