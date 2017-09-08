#"https://www.linio.com.pe/c/computacion/b/lenovo?page=2"

library(rvest)     


linio_paths <- read_html("https://www.linio.com.pe/directorio") %>%
               html_nodes(".title") %>% html_attr("href")

linio_paths



linio_dominio <- "https://www.linio.com.pe"


linio_urls <- c()


for (i in seq_along(linio_paths)) {
  
  for (n in 1:11) {
    
    linio_urls <- c(linio_urls, paste0(linio_dominio, linio_paths[i], "?page=", n))
    
  }   
  
}


linio_urls
