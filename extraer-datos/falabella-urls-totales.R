setwd("D:\\rls\\tvs-comparativo\\extraer-datos")



f_urls <- read.csv("falabella-urls.csv", sep = ";")


f_urls$url <- paste0("http://", f_urls$url)






falabella_urls <- c()


#####

parte_a = "?No="
parte_b = "&Nrpp=1000"

###

#num_page = 0

###


for (i in seq_along(f_urls$categoria)) {
  
  
  for (j in seq_along(1:f_urls$paginas2[i])) {
    
    num_page = j
    num_page = (num_page - 1) * 1000
    
    falabella_urls <- c(falabella_urls, paste0(f_urls$url[i], parte_a, num_page, parte_b))
    
  }
}






write.csv(falabella_urls, "falabella-urls-totales.csv", row.names = F)



