library(rvest)     


ripley_paths <- read_html("http://simple.ripley.com.pe") %>%
                html_nodes(".child-category-name") %>% html_attr('href')


page <- "http://simple.ripley.com.pe"


ripley_urls <- c()


for (i in seq_along(ripley_paths)) {
  
  for (n in 1:11) {
    
  ripley_urls <- c(ripley_urls, paste0(page, ripley_paths[i], "?page=", n))

  }   
  
}
  

ripley_urls




 
