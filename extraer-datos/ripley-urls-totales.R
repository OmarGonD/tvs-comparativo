library(rvest)
library(dplyr)
library(stringr)
library(urltools)



setwd("D:\\rls\\tvs-comparativo\\extraer-datos")


r_urls <- read.csv2("ripley-urls.csv")


r_urls$url <- gsub("\\?.*", "", r_urls$url)




###



ripley_urls <- c()


#####


page = "?page="

num_page = 0

###

#num_page = 0

###



for (i in seq_along(r_urls$categoria)) {
  
  
  for (j in seq_along(1:r_urls$paginas[i])) {
    
    num_page = j
    #num_page = num_page + 1
    
    ripley_urls <- c(ripley_urls, paste0(r_urls$url[i], page, num_page))
    
  }
}


ripley_urls[1:10]


write.csv(ripley_urls, "ripley-urls-totales.csv", row.names = F)

