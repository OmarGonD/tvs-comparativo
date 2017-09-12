library(plotly)
library(dplyr)



ecommerce <- read.csv("D:\\rls\\tvs-comparativo\\base-de-datos\\ecommerce-bd\\2017-09-11-ecommerce-bd.csv",
                      as.is = TRUE) #LAPTOP


ecommerce <- ecommerce[,1:8]


ecommerce <- ecommerce[rowSums(is.na(ecommerce)) != ncol(ecommerce),]

#dplyr::filter(ecommerce,  !is.na(columnname))


#ecommerce <- ecommerce[complete.cases(ecommerce),]


ecommerce_boxplot <- ecommerce %>%
                     group_by(ecommerce, categoria) %>%
                     summarise(precio.actual = sum(precio.actual, na.rm = TRUE))



p <- plot_ly(ecommerce_boxplot, y = ~precio.actual, color = ~ecommerce, type = "box")

p



p <- plot_ly(ecommerce, x = ~categoria, y = ~precio.actual, color = ~ecommerce, type = "box") %>%
  layout(boxmode = "group")



p
