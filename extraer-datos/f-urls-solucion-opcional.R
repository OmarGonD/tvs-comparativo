setwd("D:\\rls\\tvs-comparativo\\extraer-datos")



f_urls <- read.csv("falabella-urls-test.csv", sep = ";")






####################################
############## SOLUCION ############
####################################
### Usar una tercera variable ######


falabella_urls <- c()

parte_a = "?No="
parte_b = "&Nrpp=16"



#################




for (i in seq_along(f_urls$categoria)) {
  
  if (f_urls$paginas[i] == 37) { 
    
    g = 37
    
    for (h in 1:37) {
      
      num_page = h
      num_page = (h - 1) * 16
      
      falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==g], parte_a, num_page, parte_b))
      #falabella_urls <- c(falabella_urls, paste0(f_urls$url[37], parte_a, num_page, parte_b))
      
    }
    
  } else if (f_urls$paginas[i] == 156) {
      
    k = 156
    
    for (j in 1:156) {
      
      num_page = j
      num_page = (j - 1) * 16
      
      falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==k], parte_a, num_page, parte_b))
      
     } 
    
   } else if (f_urls$paginas[i] == 23) {
      
      
      l = 23
      
      for (m in 1:23) {
        
        num_page = m
        num_page = (m - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==l], parte_a, num_page, parte_b))
        

      }
      
    } else if (f_urls$paginas[i] == 16) {
      
        
        o = 16
        
        for (p in 1:23) {
          
          num_page = p
          num_page = (p - 1) * 16
          
          falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==o], parte_a, num_page, parte_b))
          
        }
    
    
    } else if (f_urls$paginas[i] == 9) {
     
      q = 9
      
      for (r in 1:9) {
        
        num_page = r
        num_page = (r - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==q], parte_a, num_page, parte_b))
        
      }
      
      
    } else if (f_urls$paginas[i] == 8) {
      
      s = 8
      
      for (t in 1:8) {
        
        num_page = t
        num_page = (t - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==t], parte_a, num_page, parte_b))
        
      } 
  
    } else if (f_urls$paginas[i] == 7) {
      
      u = 7
      
      for (w in 1:7) {
        
        num_page = w
        num_page = (w - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==u], parte_a, num_page, parte_b))
        
      }

    } else if (f_urls$paginas[i] == 6) {
      
      rs = 6
      
        for (tu in 1:6) {
          
          num_page = tu
          num_page = (tu - 1) * 16
          
          falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==rs], parte_a, num_page, parte_b))
          
        } 
      
    } else if (f_urls$paginas[i] == 4) {
      
      xy = 4
      
      for (wy in 1:4) {
        
        num_page = wy
        num_page = (wy - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==xy], parte_a, num_page, parte_b))
        
      } 
      
    } else if (f_urls$paginas[i] == 3) {
      
      ab = 3
      
      for (cd in 1:3) {
        
        num_page = cd
        num_page = (cd - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==ab], parte_a, num_page, parte_b))
        
      } 
      
    } else if (f_urls$paginas[i] == 2) {
      
      ef = 2
      
      for (gh in 1:2) {
        
        num_page = gh
        num_page = (gh - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==ef], parte_a, num_page, parte_b))
        
      } 
      
    } else if (f_urls$paginas[i] == 1) {
      
      ij = 1
      
      for (kl in 1:1) {
        
        num_page = kl
        num_page = (kl - 1) * 16
        
        falabella_urls <- c(falabella_urls, paste0(f_urls$url[f_urls$paginas==ij], parte_a, num_page, parte_b))
        
      } 
      
    }  
}


write.csv(falabella_urls, "f-urls-parte2.csv", row.names = F)

