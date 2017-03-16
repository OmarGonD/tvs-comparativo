library(dplyr)
library(ggplot2)
library(ggforce)
library(hrbrthemes)
library(scales)
library(tibble)
library(plotly)


setwd("D:\\RCoursera\\r-s-l")




tvs2017 <- read.csv("2017-03-03-tvs.csv")

tvs2016 <- read.csv("2016-05-16-total-tvs.csv")


##################################


tvs2016 <-  tvs2016 %>%
            add_column(periodo = 2016, .before = "ecommerce")


tvs2016 <- tvs2016 %>%
           mutate(descuento = precio.actual/precio.antes - 1)


##########################################


tvs <- bind_rows(tvs2016, tvs2017)


### Remover de Linio lo que no son TVs ###

tvs <- tvs %>%
           filter(marca != is.na(marca),
                  pulgadas < 100 | pulgadas != is.na(pulgadas))





tvs.cantidad <- tvs  %>%
  group_by(periodo, ecommerce) %>%
  summarise(cantidad = length(marca))





tvs.cantidad$ecommerce <- factor(tvs.cantidad$ecommerce, levels = c("linio",
                                                                    "ripley",
                                                                    "falabella"),
                                 ordered = T)




tvs.cantidad$periodo <- factor(tvs.cantidad$periodo, levels = c(2017,2016),
                                 ordered = T)




tt1 <- "Ecommerce con más TVs"
stt1 <- "Linio, Ripley y Saga Falabella (Falabella) son los 3 principales ecommerce del Perú.\n"
cptn <- "\nogonzales.com | Data Analyst"




ggplot(tvs.cantidad, aes(x=ecommerce, y= cantidad, fill = ecommerce)) + 
  geom_bar(stat = "identity", width = .7) +
  facet_grid(~ periodo) +
  scale_fill_manual("ecommerce",
                    values = c("linio" = "#FF5500","ripley" = "#802D69","falabella" = "#BED800")) +
  labs(title = "Ecommerce con más TVs\n",
       x = "", y = "") +
  theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey10",size=20,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey10",size=14,hjust=0,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey40",size=6,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey40",size=6,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(size = 24,vjust=2,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "none",
        strip.text = element_text(size = 22, hjust = 0.5, vjust = -0.5)) +
  geom_text(aes(label=cantidad), vjust=-0.25, size = 6) +
  ylim(0, 600) +
  labs(title = tt1, subtitle = stt1, caption = cptn,
       x = "", y = "") 
  
  




ggsave(file="tvs-cantidad.jpg", width = 12, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")


### 


tvs.rango <- tvs %>%
  group_by(periodo, ecommerce, rango) %>%
  summarise(cantidad = length(rango))


# 
# tvs.rango$ecommerce <- factor(tvs.rango$ecommerce, levels = c("c",
#                                                                 "a",
#                                                                 "b"),
#                                ordered = T)

unique(tvs.rango$ecommerce)




tvs.rango$periodo <- factor(tvs.rango$periodo, levels = c(2017,2016),
                               ordered = T)



tvs.rango$ecommerce <- factor(tvs.rango$ecommerce, levels = c("linio",
                                                                "ripley",
                                                                "falabella"),
                               ordered = T)





tvs.rango$rango <- factor(tvs.rango$rango, levels = c("< S/.500",
                                                          "S/.500 - S/.1500",
                                                          "S/.1500 - S/.2500",
                                                          "S/.2500 - S/.3500",
                                                          "S/.3500 - S/.4500",
                                                          "> S/.4,500"),
                            ordered = T)



# To use for fills, add

###


tt2 <- "Cantidad de TVs según rango de precio"
stt2 <- "\n"



ggplotly(ggplot(tvs.rango, aes(x = rango, y = cantidad, fill = ecommerce)) +
           geom_bar(stat = "identity") + 
           scale_fill_manual("ecommerce",
                             values = c("linio" = "#FF5500","ripley" = "#802D69","falabella" = "#BED800")) +
           facet_grid(~ periodo) +
           coord_flip() +
           theme_ipsum_rc(grid = "X") +
           theme(axis.text.x = element_text(colour="grey10",size=12,hjust=.5,vjust=.5,face="plain"),
                 axis.text.y = element_text(colour="grey10",size=14,,hjust=1,vjust=0,face="plain"),  
                 axis.title.x = element_text(colour="grey40",size=16,angle=0,hjust=.5,vjust=0,face="plain"),
                 axis.title.y = element_text(colour="grey40",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
                 plot.title = element_text(size = 24,vjust=4, face="bold"),
                 plot.subtitle = element_text(vjust=2, size = 16),
                 plot.caption = element_text(vjust=2, size = 16),
                 legend.title = element_text(colour="grey40", size=16, face="bold"),
                 legend.text = element_text(colour="grey10", size=16, face="bold"),
                 #strip.text.x = element_text(size = 14, angle = 0),
                 legend.position = "bottom",
                 strip.text = element_text(size = 22, hjust = .9, vjust = -.5)) +
           #geom_text(aes(label=cantidad), hjust=-0.25, size = 4) +
           ylim(0, 300) +
           labs(title = tt2, subtitle = stt2, caption = cptn,
                x = "", y = ""))










ggsave(file="tvs-rango-precios.jpg", width = 12, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")




####



tvs.precios <- tvs %>%
               group_by(periodo,ecommerce, marca) %>%
               summarise(precio.actual = mean(precio.actual, na.rm = T))






tvs.precios$periodo <- factor(tvs.precios$periodo, levels = c(2017,2016),
                            ordered = T)



tvs.precios$ecommerce <- factor(tvs.precios$ecommerce, levels = c("linio",
                                                              "ripley",
                                                              "falabella"),
                              ordered = T)










p <- plot_ly(tvs.precios, x = ~periodo, y = ~precio.actual, color = ~ecommerce, type = "box") %>%
     layout(boxmode = "group")

p




### Ggplot2 Versión


# ggplot(tvs.precios, aes(factor(ecommerce), precio.actual)) +
#   geom_boxplot(aes(colour = ecommerce), outlier.colour = "red", outlier.shape = 1, outlier.size = 4) + 
#   facet_grid(~ periodo) +
#   theme_ipsum_rc(grid = "X") +
#   scale_y_comma() +
#   theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
#         axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
#         axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
#         axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
#         plot.title = element_text(size = 24,vjust=4,face="bold"),
#         plot.subtitle = element_text(vjust=2, size = 16),
#         plot.caption = element_text(vjust=2, size = 16),
#         legend.position = "none") +
#   labs(title = "tt4", subtitle = "stt4", caption = "cptn",
#        x = "", y = "")






###






### Gráficos individuales por ecommerce ###

### ripley ###


tvs.ripley <- tvs[tvs$ecommerce == "ripley",]

tvs.ripley.porcentajes <- tvs.ripley  %>%
  group_by(periodo, rango, marca) %>%
  summarise(cantidad.marca = length(marca)) %>% 
  mutate(porcentaje = cantidad.marca/sum(cantidad.marca))




tvs.ripley.porcentajes$periodo <- factor(tvs.ripley.porcentajes$periodo, levels = c(2017,2016),
                              ordered = T)




tt3 <- "Ripley.com.pe \n % marcas de tvs por rango de precio"
stt3 <- "\n"






ggplot(tvs.ripley.porcentajes, aes(x=rango, y= porcentaje ,fill=marca)) + 
  geom_bar(stat = "identity", width = .7) +
  facet_grid(~ periodo) +
  theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey20",size=12,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=10,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=18,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(vjust=2, size = 24,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "top",
        legend.box = "horizontal",
        legend.title=element_blank(),
        legend.text=element_text(size=18),
        strip.text = element_text(size = 22, hjust = 0, vjust = 2, face = "bold")) +
  scale_y_continuous(labels=percent) +
  # scale_fill_manual(
  #   values = c("hisense" = "#F39EF7","sony" = "#003366","panasonic" = "#FCB462",
  #              "samsung" = "#7ec0ee", "lg" = "#A21420",
  #              "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "hyundai" = "#FCB442")) +
  # labs(title = tt5, subtitle = stt5, caption = cptn,
  #      x = "", y = "") +
  labs(title = tt3, subtitle = stt3, caption = cptn,
       x = "", y = "") +
  scale_color_ipsum() 

  





ggsave(file="r-tvs-rango-precios.jpg", width = 16, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")





### Ripley - BoxPlot





tvs.ripley.porcentajes <- tvs.ripley %>%
  group_by(periodo,marca, precio.antes, precio.actual) %>%
  mutate(dif.precios = precio.antes - precio.actual,
         dif.porcentual = round(100*dif.precios/precio.antes,2))


# 
# means.linio <- aggregate(dif.porcentual ~ rango , tvs.linio.porcentajes, mean)
# means.linio$dif.porcentual <- round(medians$dif.porcentual,0)
# 
# max.percentage <- aggregate(dif.porcentual ~ rango , ripley.tv.precios, max)
# max.percentage$dif.porcentual <- round(max.percentage$dif.porcentual,0)




tt4 <- "Ripley - variación % descuentos según rango de precios"
stt4 <- "\n"







solo.ripley <- plot_ly(tvs.ripley.porcentajes, x = ~periodo, y = ~dif.porcentual, color = ~marca, type = "box") %>%
  layout(boxmode = "group")

solo.ripley


# 
# a <- ggplot(tvs.ripley.porcentajes, aes(factor(rango), dif.porcentual))
# 
# 
# #p + geom_boxplot(fill = "white", colour = "#3366FF")
# a + geom_boxplot(aes(colour = rango), outlier.colour = "red", outlier.shape = 1, outlier.size = 4) + 
#   facet_grid(~ periodo) +
#   theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
#         axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
#         axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
#         axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
#         plot.title = element_text(size = 24,vjust=4,face="bold"),
#         plot.subtitle = element_text(vjust=2, size = 16),
#         plot.caption = element_text(vjust=2, size = 16),
#         legend.position = "top") +
#   labs(title = tt4, subtitle = stt4, caption = cptn,
#        x = "", y = "")



# 
# 
# ggsave(file="r-tvs-porcentajes.jpg", width = 14, height = 8,
#        path = "D:\\RCoursera\\r-s-l\\graficos")









### falabella ###



tvs.falabella <- tvs[tvs$ecommerce == "falabella",]

tvs.falabella.porcentajes <- tvs.falabella  %>%
  group_by(periodo, rango, marca) %>%
  summarise(cantidad.marca = length(marca)) %>% 
  mutate(porcentaje = cantidad.marca/sum(cantidad.marca))




tvs.falabella.porcentajes$periodo <- factor(tvs.falabella.porcentajes$periodo, levels = c(2017,2016),
                                         ordered = T)



tt5 <- "Sagafalabella \n % marcas de tvs por rango de precios"
stt5 <- "\n"



ggplot(tvs.falabella.porcentajes, aes(x=rango, y= porcentaje ,fill=marca)) + 
  geom_bar(stat = "identity", width = .7) +
  facet_grid(~ periodo) +
  theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey20",size=12,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=10,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=18,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(vjust=2, size = 24,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "top",
        legend.box = "horizontal",
        legend.title=element_blank(),
        legend.text=element_text(size=18),
        strip.text = element_text(size = 22, hjust = 0, vjust = -.5, face = "bold")) +
  scale_y_continuous(labels=percent) +
  # scale_fill_manual(
  #   values = c("hisense" = "#F39EF7","sony" = "#003366","panasonic" = "#FCB462",
  #              "samsung" = "#7ec0ee", "lg" = "#A21420",
  #              "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "hyundai" = "#FCB442")) +
  # labs(title = tt5, subtitle = stt5, caption = cptn,
  #      x = "", y = "") +
  labs(title = tt5, subtitle = stt5, caption = cptn,
       x = "", y = "") +
  scale_color_ipsum() 
  





ggsave(file="s-tvs-rango-precios.jpg", width = 16, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")



### Falabella BoxPlot




tvs.falabella.porcentajes <- tvs.falabella %>%
  group_by(periodo, marca, precio.antes, precio.actual) %>%
  mutate(dif.precios = precio.antes - precio.actual,
         dif.porcentual = round(100*dif.precios/precio.antes,2))







tvs.falabella.porcentajes$periodo <- factor(tvs.falabella.porcentajes$periodo, levels = c(2017,2016),
                                            ordered = T)


solo.saga <- plot_ly(tvs.falabella.porcentajes, x = ~periodo, y = ~dif.porcentual, color = ~marca, type = "box") %>%
  layout(boxmode = "group")

solo.saga






### linio ###



### Linio BoxPlot



### Linio




tvs.linio <- tvs[tvs$ecommerce == "linio",]




tvs.linio.porcentajes <- tvs.linio %>%
                        group_by(periodo, marca, precio.antes, precio.actual) %>%
                        mutate(dif.precios = precio.antes - precio.actual,
                               dif.porcentual = round(100*dif.precios/precio.antes,2))





tvs.linio.porcentajes$periodo <- factor(tvs.linio.porcentajes$periodo, levels = c(2017,2016),
                                            ordered = T)









# scale_fill_manual(
#   values = c("hisense" = "#EE6CF5","sony" = "#003366","panasonic" = "#FCB462",
#              "samsung" = "#7ec0ee", "lg" = "#A21420", "altron" = "#E6981C",
#              "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "olitec" = "#3A76D6",
#              "imaco" = "#00C18C", "nex" = "#DE8D00", "haier" = "#01BA38",
#              "continental" = "#BD9C00", "daewoo" = "#968363", "king master" = "#EDED6F",
#              "blackline" = "#5BD4BA", "hyundai" = "#01B3EF", "miray" = "#ED6F87",
#              "royal" = "#5A9AED")) +












tvs.linio.porcentajes$periodo <- factor(tvs.linio.porcentajes$periodo, levels = c(2017,2016),
                                            ordered = T)

# 
# solo.linio <- plot_ly(tvs.linio.porcentajes, x = ~marca, y = ~dif.porcentual, color = ~marca, type = "box") %>%
#   layout(boxmode = "group")
# 
# solo.linio




tt8 <- "Linio - variación % descuentos según rango de precios"
stt8 <- "\n"
# 
# 
# 
l <- ggplot(tvs.linio.porcentajes, aes(factor(marca), dif.porcentual))



l + geom_boxplot(aes(colour = rango), outlier.colour = "red", outlier.shape = 1,
                 outlier.size = 4) +
  facet_grid_paginate(periodo ~ rango, page = 1) +
  theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey20",size=12,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=10,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=18,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(vjust=2, size = 24,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "none",
        legend.box = "horizontal",
        legend.title=element_blank(),
        legend.text=element_text(size=18),
        strip.text = element_text(size = 22, hjust = 0, vjust = -.5, face = "bold")) +
  scale_y_continuous(labels=comma) +
  # scale_fill_manual(
  #   values = c("hisense" = "#F39EF7","sony" = "#003366","panasonic" = "#FCB462",
  #              "samsung" = "#7ec0ee", "lg" = "#A21420",
  #              "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "hyundai" = "#FCB442")) +
  # labs(title = tt5, subtitle = stt5, caption = cptn,
  #      x = "", y = "") +
  labs(title = tt8, subtitle = stt8, caption = cptn,
       x = "", y = "") +
  scale_color_ipsum() 






ggsave(file="l-tvs-porcentajes.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")




# 
# ### Todos
# 
# 
# ##### Porcentajes BoxPlot
# 
# tvs.aaa <- tvs %>% 
#         group_by(marca) %>%
#         summarise(p = sum(precio.actual))
# 
# 



# max.percentage <- aggregate(dif.porcentual ~ rango , ripley.tv.precios, max)
# max.percentage$dif.porcentual <- round(max.percentage$dif.porcentual,0)



tt9 <- "Total Ecommerce - variación % descuentos según rango de precios"
stt9 <- "\n"





p <- ggplot(tvs.porcentajes, aes(factor(rango), dif.porcentual))




#p + geom_boxplot(fill = "white", colour = "#3366FF")
p + geom_boxplot(fill = "white", colour = "#3366FF", outlier.colour = "blue", outlier.shape = 1,
                 outlier.size = 4) +
  theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),
        axis.title.x = element_text(colour="grey20",size=14,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(size = 24,vjust=4,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "none") +
  # geom_text(data = medians, aes(label = dif.porcentual, y = dif.porcentual + 1.5),
  #           colour = "grey20", size = 6, vjust = -0.01) +
  scale_y_continuous(label=percent) +
  labs(title = tt9, subtitle = stt9, caption = cptn,
       x = "", y = "")



ggsave(file="todos-tvs-porcentajes.jpg", width = 14, height = 8,
       path = "D:\\RCoursera\\r-s-l\\graficos")



### Scaterplot Pulgadas vs Precios


tt10 <- "Precio de televisores según su tamaño (pulgadas)"
stt10 <- "\n"



str(tvs)

a <- tvs %>%
     group_by(periodo, ecommerce,marca, pulgadas) %>%
     select(periodo, ecommerce,marca, pulgadas, precio.actual) %>%
     filter(pulgadas < 100) %>%
     filter(marca != "xenon")


a$periodo <- factor(a$periodo, levels = c(2017,2016), ordered = T)

a$marca <- as.factor(a$marca)


pulgadas_precio <- ggplot(a, aes(x = pulgadas, y = comma(precio.actual))) + 
  geom_point(aes(color=marca),size = 4,alpha = 0.6) +
  facet_grid(ecommerce ~ periodo) +
  theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey10",size=10,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey10",size=10,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey40",size=16,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey40",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(size = 24,vjust=4, face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.title = element_text(colour="grey40",size=14,hjust=.5,vjust=.5,face="bold"),
        legend.text = element_text(colour="grey10", size=18, face="plain"),
        strip.text.x = element_text(size = 18, angle = 0),
        strip.text.y = element_text(size=14, face="bold"),
        legend.position = "none") +
  scale_y_continuous(label=comma, limits = c(0,30000)) +
  scale_x_continuous(label=comma, limits = c(0,100)) +
  labs(title = tt10, subtitle = stt10, caption = cptn,
       x = "pulgadas \n", y = "precio en S/. \n") +
  scale_color_discrete(name="marcas de tvs") +
  geom_smooth()


ggplotly(pulgadas_precio)








### Write CSV con datos totales TVS


file <- paste(as.character(Sys.Date()),"total-tvs", sep = "-")

total.tvs.csv <- paste(file, "csv", sep = ".")


## 1er arg es l.tv // 2do arg es nombres del archivo

write.csv(tvs, total.tvs.csv, row.names = F)


