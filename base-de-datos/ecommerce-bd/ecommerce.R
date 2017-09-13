library(readr)
library(hrbrthemes)
library(plotly)

setwd("D:\\RCoursera\\r-s-l\\base-de-datos\\ecommerce-bd")




ripley_bd <- read.csv("D:\\RCoursera\\r-s-l\\base-de-datos\\ecommerce-bd\\2017-09-13-ripley-bd.csv")

falabella_bd <- read.csv("D:\\RCoursera\\r-s-l\\base-de-datos\\ecommerce-bd\\2017-09-13-falabella-bd.csv")


ecommerce <- rbind(falabella_bd, ripley_bd)



### Formatear Precios



ecommerce$precio.antes <- gsub("S/ |Internet: |\\,", "", ecommerce$precio.antes)




ecommerce$precio.actual <- gsub("S/ |Internet: |\\,", "", ecommerce$precio.actual)



### As.Numeric Precios



ecommerce$precio.antes <- as.numeric(ecommerce$precio.antes)


ecommerce$precio.actual <- as.numeric(ecommerce$precio.actual)




ecommerce <- ecommerce[rowSums(is.na(ecommerce)) != ncol(ecommerce),]


### Write Ecommerce CSV


file <- paste( as.character(Sys.Date()),"ecommerce-bd", sep = "-")


ecommerce_csv <- paste(file, "csv", sep = ".")


write.csv(ecommerce, ecommerce_csv, row.names = F)






