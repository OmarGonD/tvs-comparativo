ecommerce$sku <- NA
#ecommerce$sku.detalle <- NA




for (i in 1:nrow(ecommerce)) {
  
  
  ### PATH PARTS
  
  
  
  
  AA22A5000.path <- c(".*([a-zA-Z]{2}[0-9]{2}[a-zA-Z]{1}[0-9]{4}).*")
  
  
  OLED65E7P.path <- c(".*([a-zA-Z]{4}[0-9]{2}[a-zA-Z]{1}[0-9]{1}[a-zA-Z]{1}).*")
  
  
  OOAA1111.path <- c(".*([0-9]{2}[a-zA-Z]{2}[0-9]{4}).*")
  
  OOA1A.path <- c(".*([0-9]{2}[a-zA-Z]{1}[0-9]{1}[a-zA-Z]{1}).*")
  
  MT48AF.path <- c(".*([a-zA-Z]{2}[0-9]{2}[a-zA-Z]{2}")
  
  
  
  
  
  
  #direct.path <- "//(direct//).*"
  
  ### GREPL PART
  AA22A5000 <- grepl(AA22A5000.path, ecommerce$producto[i], ignore.case = T)
  
  OLED65E7P <- grepl(OLED65E7P.path, ecommerce$producto[i], ignore.case = T)
  
  OOAA1111 <- grepl(OOAA1111.path, ecommerce$producto[i], ignore.case = T)
  
  OOA1A <- grepl(OOA1A.path, ecommerce$producto[i], ignore.case = T)
  
  #directo <- grepl(direct.path, ecommerce$producto[i], ignore.case = T)
  
  
  
  ### Conditional part
  
  ### Directo tiene un espacio en blanco
  
  if (AA22A5000) {

    ecommerce$sku <- gsub(".*([a-zA-Z]{2}[0-9]{2}[a-zA-Z]{1}[0-9]{4}).*",
                          "\\1", ecommerce$producto)

  }

  
  
  
  
  else if (OOA1A) {


    ecommerce$sku <- gsub(".*([0-9]{2}[a-zA-Z]{1}[0-9]{1}[a-zA-Z]{1}).*",
                          "\\1", ecommerce$producto)


  }

  
  else if (OOAA1111) {
    
    
    ecommerce$sku <- gsub(".*([0-9]{2}[a-zA-Z]{2}[0-9]{4}).*",
                          "\\1", ecommerce$producto)
    
    
  }
  
  
  else if (OLED65E7P) {
    
    ecommerce$sku <- gsub(".*([a-zA-Z]{4}[0-9]{2}[a-zA-Z]{1}[0-9]{1}[a-zA-Z]{1}).*",
                          "\\1", ecommerce$producto)
    
    
  }
  
  
  else {
    
    ecommerce$sku[i] <- ecommerce$producto[i]
  
    }
}

