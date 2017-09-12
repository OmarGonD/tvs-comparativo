library(tidyverse)
library(hrbrthemes)
library(plotly)

setwd("D:\\RCoursera\\r-s-l\\base-de-datos\\ecommerce-bd")





ecommerce <- dir(getwd(), full.names = TRUE) %>%
            map(read_csv, col_names = TRUE) %>% bind_rows()





### Formatear Precios



ecommerce$precio.antes <- gsub("S/ |Internet: |\\,", "", ecommerce$precio.antes)




ecommerce$precio.actual <- gsub("S/ |Internet: |\\,", "", ecommerce$precio.actual)



### As.Numeric Precios



ecommerce$precio.antes <- as.numeric(ecommerce$precio.antes)


ecommerce$precio.actual <- as.numeric(ecommerce$precio.actual)






### Write Ecommerce CSV


file <- paste( as.character(Sys.Date()),"ecommerce-bd", sep = "-")


ecommerce_csv <- paste(file, "csv", sep = ".")


write.csv(ecommerce, ecommerce_csv, row.names = F)








######## BOX PLOT ##########




p <- plot_ly(b, y = ~precio.actual, color = ~ecommerce, type = "box")


p



ecommecer_boxplot <- ecommerce %>%
                     group_by(ecommerce, categoria) %>%
                     summarise(precio.actual = sum(precio.actual, na.rm = T))





############################






# 
# 
# 
# 
# 
# ecommerce_totales <- ecommerce %>%
#                      group_by(ecommerce) %>%
#                      summarise(precio.antes = sum(precio.antes, na.rm = T),
#                                precio.actual = sum(precio.actual, na.rm = T))
#   
#   
# 
# 
# 
# 
# ggplot(ecommerce_totales, aes(ecommerce, precio.actual)) +
#   geom_col()
# 
# 
# 
# 
# 
# ecommerce_totales_g <- ggplot(ecommerce_totales,
#                               aes(ecommerce, precio.actual, fill = ecommerce)) 
# 
# 
# 
# 
# 
# ecommerce_totales_g +
#   geom_col() +
#   labs(x="", y="Precio actual S/.",
#        title="Ecommerce - Totales en Nuevos Soles S/.",
#        subtitle="",
#        caption="Brought to you by the letter 'g'") +
#   # #scale_color_ipsum() +
#   theme_ipsum_rc(grid="Y") +
#   scale_fill_ipsum() +
#   geom_text(aes(label=scales::comma(precio.actual)), vjust=-0.5) +
#   scale_y_comma(limits = c(0,100000000)) 
# 
# 
# 
# 
# ####
# 
# 
#       a <- ecommerce %>%
#            group_by(ecommerce) %>%
#            mutate(precio.actual = precio.actual)
#       
#       
# 
# ecommerce_totales_g + 
#   geom_boxplot() + geom_jitter(width = 0.2)
# 
# 
# 
# 






