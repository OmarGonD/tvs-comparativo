library(dplyr)
library(ggplot2)
library(ggforce)
library(hrbrthemes)
library(scales)
library(tibble)
library(plotly)
library(repmis)



setwd("D:\\RCoursera\\r-s-l")



tvs <- source_data("https://www.dropbox.com/s/6arewitgenhwwba/2017-03-15-total-tvs.csv?raw=1")





############################################
### Total TVS 2017 vs 2016 por Ecommerce ###
############################################



### Remover de Linio lo que no son TVs #####



tvs <- tvs %>%
       filter(pulgadas < 90, !is.na(marca))





tvs.cantidad <- tvs  %>%
  group_by(periodo, ecommerce) %>%
  summarise(cantidad = length(marca))





tvs.cantidad$ecommerce <- factor(tvs.cantidad$ecommerce, levels = c("linio",
                                                                    "ripley",
                                                                    "falabella"),
                                 ordered = T)




tvs.cantidad$periodo <- factor(tvs.cantidad$periodo, levels = c(2017,2016),
                               ordered = T)




tt1 <- "Ecommerce con m�s TVs"
stt1 <- "Linio, Ripley y Falabella son los 3 principales ecommerce del Per�.\n"
cptn <- "\nogonzales.com | Data Analyst"




ggplot(tvs.cantidad, aes(x=ecommerce, y= cantidad, fill = ecommerce)) + 
  geom_bar(stat = "identity", width = .7) +
  facet_grid(~ periodo) +
  theme_bw() +
  scale_fill_manual("ecommerce",
                    values = c("linio" = "#FF5500","ripley" = "#802D69","falabella" = "#BED800")) +
  labs(title = "Ecommerce con m�s TVs\n",
       x = "", y = "") +
  #theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey10",size=12,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey10",size=8,hjust=0,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey40",size=6,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey40",size=6,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(size = 24,vjust=2,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 8),
        panel.border = element_rect(colour = "white"),
        legend.position = "none",
        strip.text = element_text(size = 18, hjust = 0.08, vjust = -0.5),
        strip.background = element_rect(colour = "white", fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  geom_text(aes(label=cantidad), vjust=-0.6, size = 4) +
  ylim(0, 600) +
  labs(title = tt1, subtitle = stt1, caption = cptn,
       x = "", y = "") 






############################################
### TVS 2017 vs 2016 por Rango de Precio ###
############################################




tvs.rango <- tvs %>%
  group_by(periodo, ecommerce, rango) %>%
  summarise(cantidad = length(rango))




tvs.rango$periodo <- factor(tvs.rango$periodo, levels = c(2017,2016),
                            ordered = T)



tvs.rango$ecommerce <- factor(tvs.rango$ecommerce, levels = c("linio",
                                                              "ripley",
                                                              "falabella"),
                              ordered = T)





tvs.rango$rango <- factor(tvs.rango$rango, levels = c("< S/.500",
                                                      "S/.500 -\r\n S/.1500",
                                                      "S/.1500 -\r\n S/.2500",
                                                      "S/.2500 -\r\n S/.3500",
                                                      "S/.3500 -\r\n S/.4500",
                                                      "> S/.4,500"),
                          ordered = T)



# To use for fills, add

###

### No usar t�tulo porque no entra en los l�mites del
### formato de la p�gina web. 


#tt2 <- "Cantidad de TVs seg�n rango de precio"
tt2 <- ""
stt2 <- "\n"



ggplotly(ggplot(tvs.rango, aes(x = rango, y = cantidad, fill = ecommerce)) +
           geom_bar(stat = "identity") + 
           scale_fill_manual("ecommerce",
                             values = c("linio" = "#FF5500","ripley" = "#802D69","falabella" = "#BED800")) +
           facet_grid(~ periodo) +
           theme_bw() +
           coord_flip() +
           #theme_ipsum_rc(grid = "X") +
           theme(axis.text.x = element_text(colour="grey10",size=10,hjust=.5,vjust=.5,face="plain"),
                 axis.text.y = element_text(colour="grey10",size=10,hjust=1,vjust=0,face="plain"),  
                 axis.title.x = element_text(colour="grey40",size=16,angle=0,hjust=.5,vjust=0,face="plain"),
                 axis.title.y = element_text(colour="grey40",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
                 plot.title = element_text(size = 24,vjust=4, face="bold"),
                 plot.subtitle = element_text(vjust=2, size = 16),
                 plot.caption = element_text(vjust=2, size = 16),
                 panel.border = element_rect(colour = "white"),
                 legend.position = "none",
                 strip.text = element_text(size = 18, hjust = 0.01, vjust = -0.5),
                 strip.background = element_rect(colour = "white", fill = "white"),
                 panel.grid.major.y = element_blank(),
                 panel.grid.minor.y = element_blank()) +
           #geom_text(aes(label=cantidad), hjust=-0.25, size = 4) +
           ylim(0, 300) +
           labs(title = tt2, subtitle = stt2, caption = cptn,
                x = "", y = ""))







###################################################
# BOXPLOTS TVS 2017 vs 2016 todos los Ecommerce ###
###################################################






tvs.precios <- tvs  






tvs.precios$periodo <- factor(tvs.precios$periodo, levels = c(2017,2016),
                              ordered = T)



tvs.precios$ecommerce <- factor(tvs.precios$ecommerce, levels = c("linio",
                                                                  "ripley",
                                                                  "falabella"),
                                ordered = T)







### Distribuci�n de los precios de TVs por Ecommerce


p <- plot_ly(tvs.precios, x = ~periodo, y = ~precio.actual, color = ~ecommerce, type = "box") %>%
  layout(boxmode = "group")

p









#############################################
### Gr�ficos individuales por ecommerce ###
#############################################



### ripley ###


tvs.ripley <- tvs[tvs$ecommerce == "ripley",]


### falabella ###

tvs.falabella <- tvs[tvs$ecommerce == "falabella",]


### linio ###

tvs.linio <- tvs[tvs$ecommerce == "linio",]



tvs.linio.parte1 <- tvs.linio %>%
                    filter(marca %in% c("lg", "aoc","imaco",
                                        "royal","panasonic",
                                        "samsung", "sony", "olitec",
                                        "haier", "nex"))




tvs.linio.parte2 <- tvs.linio %>%
                    filter(marca %in% c("daywoo","altron","blackline",
                                        "miray","hisense", "king master",
                                        "xenon", "hyundai", "jvc"))
                  
                  







#########################################################
### MARCAS DE TV POR RANGO DE PRECIO - EN PORCENTAJES ###
#########################################################




### Ripley



tvs.ripley.tvs.por.rango <- tvs.ripley  %>%
                            group_by(periodo, rango, marca) %>%
                            summarise(cantidad.marca = length(marca)) %>% 
                            #mutate(porcentaje = paste0(round(cantidad.marca/sum(cantidad.marca)*100,2),'%'))
                            mutate(porcentaje_tvs = round(cantidad.marca/sum(cantidad.marca),4))






tvs.ripley.tvs.por.rango$periodo <- factor(tvs.ripley.tvs.por.rango$periodo, levels = c(2017,2016),
                                         ordered = T)







tvs.ripley.tvs.por.rango$rango <- factor(tvs.ripley.tvs.por.rango$rango, levels = c("< S/.500",
                                                      "S/.500 -\r\n S/.1500",
                                                      "S/.1500 -\r\n S/.2500",
                                                      "S/.2500 -\r\n S/.3500",
                                                      "S/.3500 -\r\n S/.4500",
                                                      "> S/.4,500"),
                          ordered = T)






tt3 <- "Ripley.com.pe \nmarcas de tvs por rango de precio en porcentajes %"
stt3 <- "\n"






ggplot(tvs.ripley.tvs.por.rango, aes(x=rango, y= porcentaje_tvs ,fill=marca)) + 
  geom_bar(stat = "identity", width = .7) +
  facet_grid(~ periodo) +
  theme_bw() +
  theme(axis.text.x = element_text(colour="grey20",size=8,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=8,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=18,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(vjust=2, size = 24,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "bottom",
        panel.border = element_rect(colour = "white"),
        strip.text = element_text(size = 18, hjust = 0.05, vjust = -0.5),
        strip.background = element_rect(colour = "white", fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  scale_y_continuous(labels=percent) +
  # scale_fill_manual(
  #   values = c("hisense" = "#F39EF7","sony" = "#003366","panasonic" = "#FCB462",
  #              "samsung" = "#7ec0ee", "lg" = "#A21420",
  #              "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "hyundai" = "#FCB442")) +
  # labs(title = tt5, subtitle = stt5, caption = cptn,
  #      x = "", y = "") +
  labs(title = tt3, subtitle = stt3, caption = "",
       x = "", y = "")




### Falabella



tvs.falabella.tvs.por.rango <- tvs.falabella  %>%
  group_by(periodo, rango, marca) %>%
  summarise(cantidad.marca = length(marca)) %>% 
  #mutate(porcentaje = paste0(round(cantidad.marca/sum(cantidad.marca)*100,2),'%'))
  mutate(porcentaje_tvs = round(cantidad.marca/sum(cantidad.marca),4))





tvs.falabella.tvs.por.rango$periodo <- factor(tvs.falabella.tvs.por.rango$periodo, levels = c(2017,2016),
                                              ordered = T)



tvs.falabella.tvs.por.rango$rango <- factor(tvs.falabella.tvs.por.rango$rango, levels = c("< S/.500",
                                                                                    "S/.500 -\r\n S/.1500",
                                                                                    "S/.1500 -\r\n S/.2500",
                                                                                    "S/.2500 -\r\n S/.3500",
                                                                                    "S/.3500 -\r\n S/.4500",
                                                                                    "> S/.4,500"),
                                         ordered = T)



tt5 <- "Sagafalabella \n % marcas de tvs por rango de precios"
stt5 <- "\n"



ggplot(tvs.falabella.tvs.por.rango, aes(x=rango, y= porcentaje_tvs ,fill=marca)) + 
  geom_bar(stat = "identity", width = .7) +
  facet_grid(~ periodo) +
  theme_bw() +
  #theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey20",size=8,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=8,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=18,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(vjust=2, size = 24,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "top",
        panel.border = element_rect(colour = "white"),
        strip.text = element_text(size = 18, hjust = 0.05, vjust = -0.5),
        strip.background = element_rect(colour = "white", fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  scale_y_continuous(labels=percent) +
  # scale_fill_manual(
  #   values = c("hisense" = "#F39EF7","sony" = "#003366","panasonic" = "#FCB462",
  #              "samsung" = "#7ec0ee", "lg" = "#A21420",
  #              "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "hyundai" = "#FCB442")) +
  # labs(title = tt5, subtitle = stt5, caption = cptn,
  #      x = "", y = "") +
  labs(title = tt5, subtitle = stt5, caption = "",
       x = "", y = "") 



### Linio



tvs.linio.tvs.por.rango <- tvs.linio  %>%
  group_by(periodo, rango, marca) %>%
  summarise(cantidad.marca = length(marca)) %>% 
  #mutate(porcentaje = paste0(round(cantidad.marca/sum(cantidad.marca)*100,2),'%'))
  mutate(porcentaje_tvs = round(cantidad.marca/sum(cantidad.marca),4))








tvs.linio.tvs.por.rango$periodo <- factor(tvs.linio.tvs.por.rango$periodo, levels = c(2017,2016),
                                              ordered = T)




tvs.linio.tvs.por.rango$rango <- factor(tvs.linio.tvs.por.rango$rango, levels = c("< S/.500",
                                                                                          "S/.500 -\r\n S/.1500",
                                                                                          "S/.1500 -\r\n S/.2500",
                                                                                          "S/.2500 -\r\n S/.3500",
                                                                                          "S/.3500 -\r\n S/.4500",
                                                                                          "> S/.4,500"),
                                            ordered = T)




tt5 <- "Linio \n % marcas de tvs por rango de precios"
stt5 <- "\n"



ggplot(tvs.linio.tvs.por.rango, aes(x=rango, y= porcentaje_tvs ,fill=marca)) + 
  geom_bar(stat = "identity", width = .7) +
  facet_grid(~ periodo) +
  theme_bw() +
  #theme_ipsum_rc(grid = "Y") +
  theme(axis.text.x = element_text(colour="grey20",size=8,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=8,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=18,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain"),
        plot.title = element_text(vjust=2, size = 24,face="bold"),
        plot.subtitle = element_text(vjust=2, size = 16),
        plot.caption = element_text(vjust=2, size = 16),
        legend.position = "top",
        panel.border = element_rect(colour = "white"),
        strip.text = element_text(size = 18, hjust = 0.05, vjust = -0.5),
        strip.background = element_rect(colour = "white", fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  scale_y_continuous(labels=percent) +
  # scale_fill_manual(
  #   values = c("hisense" = "#F39EF7","sony" = "#003366","panasonic" = "#FCB462",
  #              "samsung" = "#7ec0ee", "lg" = "#A21420",
  #              "aoc" = "#9DCC27", "sharp" = "#BEBBDA", "hyundai" = "#FCB442")) +
  # labs(title = tt5, subtitle = stt5, caption = cptn,
  #      x = "", y = "") +
  labs(title = tt5, subtitle = stt5, caption = "",
       x = "", y = "") 





# 
# solo.linio <- plot_ly(tvs.linio.porcentajes, x = ~marca, y = ~dif.porcentual, color = ~marca, type = "box") %>%
#   layout(boxmode = "group")
# 
# solo.linio



############################################################################
# Diferencia porcentual por marca en LINIO.  No se puede hacer interactiva.#
########################### Usar GGPLOT2 ###################################
############################################################################




###############################################
######### Precio Actual por Marca #############
###############################################

tvs.ripley$periodo <- factor(tvs.ripley$periodo, levels = c(2017,2016),
                            ordered = T)


tvs.falabella$periodo <- factor(tvs.falabella$periodo, levels = c(2017,2016),
                            ordered = T)


tvs.linio$periodo <- factor(tvs.linio$periodo, levels = c(2017,2016),
                                          ordered = T)




tvs.linio.parte1$periodo <- factor(tvs.linio.parte1$periodo, levels = c(2017,2016),
                            ordered = T)



tvs.linio.parte2$periodo <- factor(tvs.linio.parte2$periodo, levels = c(2017,2016),
                                   ordered = T)







### Ripley: distribuci�n de los precios de TVs por marca


precio.actual.ripley <- plot_ly(tvs.ripley, x = ~periodo, y = ~precio.actual, color = ~marca, type = "box") %>%
  layout(boxmode = "group")

precio.actual.ripley




### Falabella: distribuci�n de los precios de TVs por marca


precio.actual.falabella <- plot_ly(tvs.falabella, x = ~periodo, y = ~precio.actual, color = ~marca, type = "box") %>%
  layout(boxmode = "group")

precio.actual.falabella




### Linio - Precio Actual - Parte 1 y 2




precio.actual.linio.parte1 <- plot_ly(tvs.linio.parte1, x = ~periodo, y = ~precio.actual, color = ~marca, type = "box") %>%
  layout(boxmode = "group")

precio.actual.linio.parte1


precio.actual.linio.parte2 <- plot_ly(tvs.linio.parte2, x = ~periodo, y = ~precio.actual, color = ~marca, type = "box") %>%
  layout(boxmode = "group")

precio.actual.linio.parte2






##################################################
######## BoxPlot - Dif Porcentual precios ########
##################################################




### Ripley 





tvs.ripley.dif.porcentual <- tvs.ripley %>%
                              group_by(periodo,marca, precio.antes, precio.actual) %>%
                              mutate(dif.precios = precio.antes - precio.actual,
                                     dif.porcentual = round(100*dif.precios/precio.antes,2))






tt4 <- "Ripley - variaci�n % descuentos seg�n rango de precios"
stt4 <- "\n"










dif.porcentual.ripley <- plot_ly(tvs.ripley.dif.porcentual, x = ~periodo, y = ~dif.porcentual, color = ~marca, type = "box") %>%
                         layout(boxmode = "group")



dif.porcentual.ripley









################################################
####### Scaterplot Pulgadas vs Precios #########
################################################





tv.pulgadas.vs.pulgadas <- tvs %>% 
     group_by(periodo, ecommerce, marca, pulgadas) %>%
     filter(pulgadas <= 90, marca != "xenon") 




tv.pulgadas.vs.pulgadas$periodo <- factor(tv.pulgadas.vs.pulgadas$periodo, levels = c(2017,2016), ordered = T)

tv.pulgadas.vs.pulgadas$marca <- as.factor(tv.pulgadas.vs.pulgadas$marca)


pulgadas_precio <- ggplot(tv.pulgadas.vs.pulgadas, aes(x = pulgadas, y = precio.actual)) + 
  geom_point(aes(color=marca),size = 2,alpha = 0.4) +
  facet_grid(ecommerce ~ periodo, switch = "y") +
  theme_bw() +
  theme(axis.text.x = element_text(colour="grey10",size=10,hjust=.5,vjust=.5,face="plain"),
        axis.text.y=element_blank(),axis.ticks=element_blank(),  
        axis.title.x = element_text(colour="grey40",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey40",size=12,angle=90,hjust=.5,vjust=.5,face="plain"),
        legend.position = "none",
        plot.title = element_text(size = 24,vjust=4, face="bold"),
        plot.subtitle = element_text(vjust=2, size = 8),
        plot.caption = element_text(vjust=2, size = 8),
        legend.title = element_text(colour="grey40",size=14,hjust=.5,vjust=.5,face="bold"),
        legend.text = element_text(colour="grey10", size=18, face="plain"),
        panel.border = element_rect(colour = "white"),
        strip.text = element_text(size = 12, hjust = 0.05, vjust = -0.5),
        strip.background = element_rect(colour = "white", fill = "white"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  scale_y_continuous(label=comma, limits = c(0,36000)) +
  #scale_x_continuous(label=comma, limits = c(0,100)) +
  labs(title = "", subtitle = "", caption = "",
       x = "pulgadas \n", y = "Precio en S/.")


ggplotly(pulgadas_precio)











