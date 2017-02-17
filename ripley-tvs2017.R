library(RSelenium)
library(rvest)
library(dplyr)


setwd("D:\\RCoursera\\Ripley")

#start RSelenium


rD  <- rsDriver(port = 4588L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]




#navigate to your page
remDr$navigate("http://www.ripley.com.pe/ripley-peru/tv-todas")

Sys.sleep(10)


page_source<-remDr$getPageSource()

#parse it







####


product_info <- function(node){
        r.precio.antes <- html_nodes(node, 'span.catalog-product-list-price') %>% html_text
        r.precio.actual <- html_nodes(node, 'span.catalog-product-offer-price') %>% html_text 
        r.producto <- html_nodes(node,"span.catalog-product-name") %>% html_text
        
        
        r.precio.antes <-   gsub("\\S\\/\\. ", "", r.precio.antes)
        r.precio.actual <-   gsub("\\S\\/\\. ", "", r.precio.actual)
        
        
        data.frame(
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




r.tv.pag1 <- lapply(doc, product_info) %>%
            bind_rows()





####





##################################################
##################################################
# PAGE 2 #########################################
##################################################
##################################################




# page2 <- remDr$findElement(
#         using = 'css', 
#         value = ".pagination li:nth-child(2) a")
# 
# page2$clickElement()


remDr$navigate("http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=3&orderBy=")



Sys.sleep(10)


page_source<-remDr$getPageSource()



#parse it
product_info <- function(node){
        r.precio.antes <- html_nodes(node, 'p.normal_encontrado') %>% html_text
        r.precio.actual <- html_nodes(node, 'div.price') %>% html_text 
        r.producto <- html_nodes(node,"div.product_name a") %>% html_text
        
        
        r.precio.antes <-   gsub("\\S\\/\\. ", "", r.precio.antes)
        r.precio.actual <-   gsub("\\S\\/\\. ", "", r.precio.actual)
        
        
        data.frame(
                ecommerce = "ripley",
                producto = r.producto,
                precio.antes = ifelse(length(r.precio.antes)==0, NA, r.precio.antes),
                precio.actual = ifelse(length(r.precio.actual)==0, NA, r.precio.actual), 
                #tarjeta.ripley = ifelse(length(r.tarjeta)==0, NA, r.tarjeta),
                stringsAsFactors=F
        )
        
        
}



doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
        html_nodes("div.product_info")




r.tv.pag2 <- lapply(doc, product_info) %>%
        rbind_all
#####


page3 <- remDr$findElement(
        using = 'css', 
        value = "#WC_SearchBasedNavigationResults_pagination_link_3_categoryResults")

page3$clickElement()

Sys.sleep(10)

page_source <- remDr$getPageSource()


#parse it
product_info <- function(node){
        r.precio.antes <- html_nodes(node, 'p.normal_encontrado') %>% html_text
        r.precio.actual <- html_nodes(node, 'div.price') %>% html_text 
        r.producto <- html_nodes(node,"div.product_name a") %>% html_text
        
        
        r.precio.antes <-   gsub("\\S\\/\\. ", "", r.precio.antes)
        r.precio.actual <-   gsub("\\S\\/\\. ", "", r.precio.actual)
        
        
        data.frame(
                ecommerce = "ripley",
                producto = r.producto,
                precio.antes = ifelse(length(r.precio.antes)==0, NA, r.precio.antes),
                precio.actual = ifelse(length(r.precio.actual)==0, NA, r.precio.actual), 
                #tarjeta.ripley = ifelse(length(r.tarjeta)==0, NA, r.tarjeta),
                stringsAsFactors=F
        )
        
        
}



doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
        html_nodes("div.product_info")




r.tv.pag3 <- lapply(doc, product_info) %>%
        rbind_all
#####



page4 <- remDr$findElement(
        using = 'css', 
        value = "#WC_SearchBasedNavigationResults_pagination_link_4_categoryResults")

page4$clickElement()

Sys.sleep(10)

page_source <- remDr$getPageSource()


#parse it

product_info <- function(node){
        r.precio.antes <- html_nodes(node, 'p.normal_encontrado') %>% html_text
        r.precio.actual <- html_nodes(node, 'div.price') %>% html_text 
        r.producto <- html_nodes(node,"div.product_name a") %>% html_text
        
        
        r.precio.antes <-   gsub("\\S\\/\\. ", "", r.precio.antes)
        r.precio.actual <-   gsub("\\S\\/\\. ", "", r.precio.actual)
        
        
        data.frame(
                ecommerce = "ripley",
                producto = r.producto,
                precio.antes = ifelse(length(r.precio.antes)==0, NA, r.precio.antes),
                precio.actual = ifelse(length(r.precio.actual)==0, NA, r.precio.actual), 
                #tarjeta.ripley = ifelse(length(r.tarjeta)==0, NA, r.tarjeta),
                stringsAsFactors=F
        )
        
        
}



doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
        html_nodes("div.product_info")




r.tv.pag4 <- lapply(doc, product_info) %>%
              rbind_all

#####





#####################

#############################
### Combining the dfs #######
#############################



r.tv <- rbind(r.tv.pag1, r.tv.pag2, r.tv.pag3,
               r.tv.pag4)

######


r.tv$precio.antes <- trimws(r.tv$precio.antes, which = "both")

r.tv$precio.actual <- trimws(r.tv$precio.actual, which = "both")



r.tv$precio.antes <- gsub(",", "", r.tv$precio.antes)
r.tv$precio.actual <- gsub(",", "", r.tv$precio.actual)


r.tv$precio.antes <- as.numeric(r.tv$precio.antes)
r.tv$precio.actual <- as.numeric(r.tv$precio.actual)




r.tv$producto <- gsub("Ã¢Â???Â", '"',r.tv$producto)


##### Marca

r.tv$marca <- ifelse(grepl("samsung", r.tv$producto, ignore.case = T), "samsung",r.tv$producto) 

r.tv$marca <- ifelse(grepl("lg", r.tv$producto, ignore.case = T), "lg",r.tv$marca) 

r.tv$marca <- ifelse(grepl("haier", r.tv$producto, ignore.case = T), "haier",r.tv$marca)

r.tv$marca <- ifelse(grepl("panasonic", r.tv$producto, ignore.case = T), "panasonic",r.tv$marca)

r.tv$marca <- ifelse(grepl("sony", r.tv$producto, ignore.case = T), "sony",r.tv$marca)

r.tv$marca <- ifelse(grepl("sharp", r.tv$producto, ignore.case = T), "sharp",r.tv$marca)

r.tv$marca <- ifelse(grepl("aoc", r.tv$producto, ignore.case = T), "aoc",r.tv$marca)


##### Hay algunas TVs que no dicen ni Smart, solo tv hd.
##### Hay que entrar a la ficha del producto para enterarte que es LED.

# 
# r.tv$tecnologia <- ifelse(grepl("smart tv", r.tv$producto, ignore.case = T), "smart tv", r.tv$producto)
# 
# 
# r.tv$tecnologia <- ifelse(grepl("tv smart", r.tv$producto, ignore.case = T), "smart tv", r.tv$tecnologia)
# 
# 
# r.tv$tecnologia <- ifelse(grepl("tv led", r.tv$producto, ignore.case = T), "led", r.tv$tecnologia)
# 
# 
# r.tv$tecnologia <- ifelse(grepl("tv hd", r.tv$producto, ignore.case = T), "led", r.tv$tecnologia)
# 
# 
# r.tv$tecnologia <- ifelse(grepl("televisor led", r.tv$producto, ignore.case = T), "led", r.tv$tecnologia)


#####


r.tv$pulgadas <- sub(".*?(\\d+['\"]).*", "\\1", r.tv$producto)

r.tv$pulgadas[72] <- 23.6


r.tv$pulgadas <- sub('"', "", r.tv$pulgadas)
r.tv$pulgadas <- sub("'", "", r.tv$pulgadas)



### To lower 


r.tv <- as.data.frame(apply(r.tv[,],2,tolower))




##### Dif de precios
### Se hará cuando se junten los datos de los 3 ecommerce

# r.tv <- r.tv %>%
#         mutate(dif.precios = precio.antes - precio.actual)
#         
# 
# 
# r.tv$dif.precios <- ifelse(is.na(r.tv$dif.precios), 0, r.tv$dif.precios)




### Ordenar columnas

r.tv <- r.tv[,c(1,5,2,3,4,6)]

###


file <- paste(as.character(Sys.Date()), "r-tvs", sep = "-")

r.tv.csv <- paste(file, "csv", sep = ".")


write.csv(r.tv, r.tv.csv, row.names = F)


