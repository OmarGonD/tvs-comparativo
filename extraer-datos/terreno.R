library(RGA)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(tidyr)


## setwd

setwd("D:\\Starcom\\centenario\\terreno")

# get access token
authorize(cache = T, reauth = T)


# get a GA profiles

ga_profiles <- list_profiles()



# choose the profile ID by site URL
# ID: http://terreno.pe

id <- 90573592

# get date when GA tracking began

#first.date <- firstdate(id)

#La campaña inicia el 18 de octubre y finaliza el 17 nov

first.date <- "2015-01-01"

final.date <- "2016-06-12"



### Get GA report data
### Se extraen los eventos para ver la interacción
### por medio. Se deben extraer los labels de los eventos posteriormente
### para conocer qué acciones son las más importantes.



terreno <- get_ga(id, start.date = first.date,
                          end.date = final.date,
                          metrics = "ga:sessions,ga:totalEvents",
                          dimensions = "ga:date,ga:hour,ga:deviceCategory,
                          ga:userType, ga:sourceMedium",
                          fetch.by = "week")




write.csv(terreno, "2016-06-12-terreno.csv", row.names = F)


terreno <- read.csv("D:\\Starcom\\centenario\\terreno\\2016-06-12-terreno.csv")

### Cargar TidyR para utilizar la función "separate"


terreno <- terreno %>%
          separate(sourceMedium, into = c("source", "medium"), sep = "\\/")


terreno$date <- as.Date(terreno$date)


terreno$mes <- month(terreno$date, label = T)
terreno$año <- year(terreno$date)
terreno$day <- weekdays(terreno$date, abbreviate = T)

terreno$source <- tolower(terreno$source) 
terreno$medium <- tolower(terreno$medium)
terreno$deviceCategory <- tolower(terreno$deviceCategory)
terreno$userType <- tolower(terreno$userType)
terreno$mes <- tolower(terreno$mes)
terreno$año <- tolower(terreno$año)
terreno$day <- tolower(terreno$day)





#terreno <- apply(terreno, 2, tolower)

#### SOURCE Y MEDIUM AS CHARACTER COLUMNS
#### para poder hacer match con regex más adelante

terreno$medium <- as.character(terreno$medium)

terreno$source <- as.character(terreno$source)

terreno$sessions <- as.numeric(terreno$sessions)

terreno$totalEvents <- as.numeric(terreno$totalEvents)


### Remove white spaces adelante y detrás


terreno$medium <- trimws(terreno$medium, which = "both")

terreno$source <- trimws(terreno$source, which = "both")



#########################
#########################

unique(terreno$mes)

terreno$mes <- factor(terreno$mes, levels = c("nov", "dec"), ordered = T)



#########################




#### Replace google_display to google

### terreno$source <- gsub("google_display", "google", terreno$source)




terreno$fuente <- NA
#terreno$fuente.detalle <- NA




for (i in 1:nrow(terreno)) {
        
        
        ### PATH PARTS
        
        spam.path <- paste(c("site.*", ".*event.*", ".*free.*", ".*theguardlan.*",".*.\\org",
                             ".*guardlink.*", ".*torture.*", ".*forum.*", ".*buy.*",
                             ".*share.*", ".*buttons.*", ".*pyme\\.lavoztx\\.com\\.*",
                             ".*amezon.*", ".*porn.*", "quality", "trafficgenius\\.xyz",
                             "gametab\\.myplaycity\\.com", "login.*", "mega.*", "blog",
                             "[0-9]{3}\\.[0-9]{2}.*", ".*\\:.*", ".*\\.xyz", "online", "internet"),
                           collapse="|")
        
        
        
        adsense.path <- paste(c("tpc.googlesyndication.com",
                                "googleads[.]g[.]doubleclick[.]net"),
                              collapse="|")
        
        
        
        
        adwords.path <- paste(c("cpc", "search",
                                "ccp","google_display",
                                "cpm","cpv","youtube.*","video.*",
                                "google", "google_blast","(not set)"),
                              collapse="|")
        
        
        
        
        email.path <- paste(c(".*mail.*", "newsletter"
                                ),
                            collapse="|")
        
        
        
        
        referral.path <- paste(c(".*google\\.com\\.pe.*",
                                 ".*google\\.co\\.ve.*",
                                 ".*google\\.com\\.br.*",
                                 ".*google\\.com\\.bo.*",
                                 ".*google\\.com\\.ar.*",
                                 ".*google\\.com.*",
                                 "sodimac.com.pe",
                                 "falabella.com.pe",
                                 "beneficios.gruporomero.com.pe",
                                 "somosterreno.net","shop.lenovo.com",
                                 "canonexperience.pe", "lg.com", "deperu.com"
                                 ),
                               collapse="|")
        
        
        
        redes.sociales.path <- paste(c(".*fac?e.*",
                                       ".*twitt?.*","tw.*", "pp.*"),
                                     collapse="|")
        
        
        
        ritmo.romantica.path <- paste(c("ritmo.*"
                                       ),
                                     collapse="|")
        
        
        
        prensmart.path <- paste(c("prensmart.*"
                                        ),
                                      collapse="|")
        
        organic.path <- paste(c("start.iminent.com",".*search.*",
                                "websearch.com","crawler.com|allmyweb.com"),
                              collapse="|")
        
        
        
        otros.path <- paste(c("web", "popup", "contenido"),
                       collapse="|")
        
        
        #direct.path <- "//(direct//).*"
        
        ### GREPL PART
        adsense <- grepl(adsense.path, terreno$source[i], ignore.case = T)
        
        
        adwords.medium <- grepl(adwords.path,terreno$medium[i], ignore.case = T)
        
        adwords.source <- grepl(adwords.path,terreno$source[i], ignore.case = T)
        
        
        email.medium <- grepl(email.path,terreno$medium[i], ignore.case = T)
        
        email.source <- grepl(email.path,terreno$source[i], ignore.case = T)
        
        
        referral.medium <- grepl("referral", terreno$medium[i],
                          ignore.case = T)
        
        referral.source <- grepl(referral.path, terreno$source[i],
                                 ignore.case = T)
        
        
        spam <- grepl(spam.path, terreno$source[i],
                      ignore.case = T)
        
        
        
        redes.sociales <- grepl(redes.sociales.path, terreno$source[i],
                                ignore.case = T)
        
        
        ritmo.romantica <- grepl(ritmo.romantica.path, terreno$source[i],
                                ignore.case = T)
        
        
        
        prensmart <- grepl(prensmart.path, terreno$source[i],
                                 ignore.case = T)
        
        organic <- grepl(organic.path, terreno$source[i], ignore.case = T)
        
        
        
        otros <- grepl(otros.path, terreno$medium[i], ignore.case = T)
        
        #directo <- grepl(direct.path, terreno$source[i], ignore.case = T)
        
        
        
        ### Conditional part
        
        ### Directo tiene un espacio en blanco
        
        if (terreno$source[i] == "(direct)") {
                terreno$fuente[i] <- "directo"
        } 
        
        
        else if (referral.source | otros) {
          
          terreno$fuente[i] <- "referencias"
        
        }
        
        
        else if (terreno$medium[i] == "organic" |
                 organic) {
                terreno$fuente[i] <- "orgánico"
        }
        
        else if (adwords.source
                 & adwords.medium) {
                
                terreno$fuente[i] <- "adwords"
        }
        
 
        
        
        
        
        else if (adsense) {
                
                terreno$fuente[i] <- "adsense"
        }
        
        
        else if (email.medium | email.source) {
          
          terreno$fuente[i] <- "email"
        }
        
        
        
        else if (redes.sociales) {
                
                terreno$fuente[i] <- "redes sociales"
        }
        
        else if (ritmo.romantica) {
          
          terreno$fuente[i] <- "ritmo romántica"
        }
        
        
        else if (prensmart) {
          
          terreno$fuente[i] <- "prensmart"
          
        }
        
        
        else if (spam) {
                
                terreno$fuente[i] <- "spam"
        }
        
        else {
                terreno$fuente[i] <- "spam"
        }
}




################################################################
############### Google BLAST ###################################
################################################################

# 
# 
# for (i in 1:nrow(terreno)) {
# 
# 
#       ### Paths ################################
#   
#       adwords.blast.path <- "google_blast"
#       
#       youtube.path <- paste(c("youtube.*",
#                               "cpv.*", "video.*"),
#                             collapse="|")
#       
#       
#       facebook.path <- paste(c("face.*",
#                               "bit.*"),
#                             collapse="|")
#       
#       
#       twitter.path <- paste(c("face.*",
#                                "bit.*"),
#                              collapse="|")
#       
#       
#       
#       #########################################
#       
#       
#       adwords.blast <- grepl(adwords.blast.path,terreno$source[i], ignore.case = T)
#       
#       
#       youtube.source <- grepl(youtube.path,terreno$source[i], ignore.case = T)
#       
#       youtube.medium <- grepl(youtube.path,terreno$medium[i], ignore.case = T)
#       
#       
#       facebook.source <- grepl(facebook.path,terreno$source[i], ignore.case = T)
#       
#       facebook.medium <- grepl(facebook.path,terreno$medium[i], ignore.case = T)
#       
#       
#       #########################################
#       
#       
#       
#       
#       if (adwords.blast) {
#         
#         terreno$fuente.detalle[i] <- "adwords blast"
#         
#       }
#       
#       
#       else if (youtube.medium & youtube.source) {
#         
#         terreno$fuente.detalle[i] <- "youtube ads"
#         
#       }
#       
#       
#       else if (facebook.source & facebook.medium) {
#         
#         terreno$fuente.detalle[i] <- "facebook ads"
#         
#       }
#       
# 
#       
#       else {
#         
#         terreno$fuente.detalle[i] <- terreno$fuente[i]
#         
#       }
# 
# 
# }

#redes <- terreno[grep(".*fac.*", terreno$source, ignore.case=TRUE),]



#referencias <- terreno[grep(".*ref.*", terreno$fuente, ignore.case=TRUE),]


##################################################################
##################################################################

########## Remove espacios en blanco #############################


terreno$fuente <- trimws(terreno$fuente, which = "both")




########## 


terreno$userType <- gsub("new visitor", "visitante nuevo", terreno$userType)

terreno$userType <- gsub("returning visitor", "visitante recurrente", terreno$userType)



terreno$userType <- gsub("visitante nuevo", "visitante.nuevo", terreno$userType)

terreno$userType <- gsub("visitante recurrente", "visitante.recurrente", terreno$userType)



##################################################################
########################## Gráficos ##############################
##################################################################



######## Visitas totales por fuente de tráfico ###################

terreno.visitas.fuente.2015 <- terreno %>%
        filter(año == 2015)



terreno.visitas.fuente.2015 <- terreno.visitas.fuente.2015 %>%
                          group_by(mes, fuente) %>%
                          summarise(sesiones = sum(sessions))



### No spam desde las fuentes

terreno.visitas.fuente.2015 <- terreno.visitas.fuente.2015[!terreno.visitas.fuente.2015$fuente == "spam",]


#### Remove AdSense


terreno.visitas.fuente.2015 <- terreno.visitas.fuente.2015[!terreno.visitas.fuente.2015$fuente == "adsense",]



###

terreno.visitas.fuente.2015$mes <- factor(terreno.visitas.fuente.2015$mes, levels = c("nov", "dec"), ordered = T)



terreno.visitas.fuente.2015$fuente <- factor(terreno.visitas.fuente.2015$fuente , levels = rev(c("adwords","orgánico", 
                                                                                 "redes sociales", "directo",
                                                                                   "referencias", "email")),
                                        ordered = T)






ggplot(terreno.visitas.fuente.2015, aes(x=fuente, y = sesiones)) +
  geom_bar(stat = "identity", fill = "#FAA13C", colour = "white") +
  facet_wrap(~ mes) + 
  labs(title = "Terreno 2015 - Visitas por fuente \n",
       x = "", y = "") +
  theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=12,angle=90,hjust=.5,vjust=.5,face="plain"), 
        plot.title = element_text(face = "bold", vjust=2, size = 22), 
        legend.title = element_text(colour="grey40", size=8, face="bold"),
        legend.text = element_text(colour="grey10", size=12, face="bold"),
        strip.text.x = element_text(size = 22,
                                    hjust = 0.5, vjust = 0.5)) +
  scale_y_continuous(labels = comma) +
  coord_flip()



ggsave("terreno-visitas-fuente-2015.png", height = 9, width = 18)



### Terreno Visitas por fuente 2016 

terreno.visitas.fuente.2016 <- terreno %>%
        filter(año == 2016)



terreno.visitas.fuente.2016 <- terreno.visitas.fuente.2016 %>%
        group_by(mes, fuente) %>%
        summarise(sesiones = sum(sessions))



### No spam desde las fuentes

terreno.visitas.fuente.2016 <- terreno.visitas.fuente.2016[!terreno.visitas.fuente.2016$fuente == "spam",]


#### Remove AdSense


terreno.visitas.fuente.2016 <- terreno.visitas.fuente.2016[!terreno.visitas.fuente.2016$fuente == "adsense",]



###

terreno.visitas.fuente.2016$mes <- factor(terreno.visitas.fuente.2016$mes, levels = c("nov", "dec"), ordered = T)



terreno.visitas.fuente.2016$fuente <- factor(terreno.visitas.fuente.2016$fuente , levels = rev(c("adwords","orgánico", 
                                                                                                 "redes sociales", "directo",
                                                                                                 "referencias", "email")),
                                             ordered = T)






ggplot(terreno.visitas.fuente.2016, aes(x=fuente, y = sesiones)) +
        geom_bar(stat = "identity", fill = "#F22439", colour = "white") +
        facet_wrap(~ mes) + 
        labs(title = "terreno 2016 - visitas por fuente \n",
             x = "", y = "") +
        theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
              axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
              axis.title.x = element_text(colour="grey20",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
              axis.title.y = element_text(colour="grey20",size=12,angle=90,hjust=.5,vjust=.5,face="plain"), 
              plot.title = element_text(face = "bold", vjust=2, size = 22), 
              legend.title = element_text(colour="grey40", size=8, face="bold"),
              legend.text = element_text(colour="grey10", size=12, face="bold"),
              strip.text.x = element_text(size = 22,
                                          hjust = 0.5, vjust = 0.5)) +
        scale_y_continuous(labels = comma) +
        coord_flip()



ggsave("terreno-visitas-fuente-2016.png", height = 9, width = 18)








#############################################################
################## ggplot2 - line graph #####################
#############################################################


terreno.visitas.fuente2 <- terreno %>%
  group_by(date, fuente) %>%
  summarise(sesiones = sum(sessions))



### No spam desde las fuentes

terreno.visitas.fuente2 <- terreno.visitas.fuente2[!terreno.visitas.fuente$fuente == "spam",]


###

#terreno.visitas.fuente2$mes <- factor(terreno.visitas.fuente2$mes, levels = c("nov", "dec"), ordered = T)



terreno.visitas.fuente2$fuente <- factor(terreno.visitas.fuente2$fuente , levels = c("orgánico", "adwords",
                                                                                     "redes sociales", "directo",
                                                                                     "organico",
                                                                                     "referencias", "email", "ritmo romántica",
                                                                                     "prensmart"),
                                       ordered = T)











ggplot(terreno.visitas.fuente2, aes(x=date, y = sesiones, group = fuente, colour = fuente)) +
  geom_line(size = 2) +
  geom_point() +
  #facet_wrap(~ mes) + 
  labs(title = "Terreno - Visitas por fuente \n",
       x = "", y = "") +
  theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=12,angle=90,hjust=.5,vjust=.5,face="plain"), 
        plot.title = element_text(face = "bold", vjust=2, size = 22), 
        legend.title = element_text(colour="grey40", size=8, face="bold"),
        legend.text = element_text(colour="grey10", size=12, face="bold"),
        strip.text.x = element_text(size = 22,
                                    hjust = 0.5, vjust = 0.5)) +
  scale_y_continuous(labels = comma) +
  scale_color_brewer(palette = "Set2") +
        geom_vline(aes(xintercept=as.numeric(date[2472])),
                   linetype=4, colour="black", size = 1.4)






ggsave("terreno-visitas-fuente-dia.png", height = 9, width = 18)

##################################################################
############## Tipo de visitante por dispositivo #################
##################################################################


terreno.device <- terreno %>%
  group_by(año, mes, userType, deviceCategory) %>%
  summarise(sessions = sum(sessions))



terreno.device$mes <- factor(terreno.device$mes, levels = c("nov", "dec"), ordered = T)



cols <- c(visitante.nuevo = "#333BFF",visitante.recurrente = "#9633FF")



ggplot(terreno.device, aes(x=userType, y = sessions, fill = userType)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ año + deviceCategory) + 
  labs(title = "Terreno -Visitas por dispositivo (2015/2016) \n",
       x = "", y = "") +
  theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=12,angle=90,hjust=.5,vjust=.5,face="plain"), 
        plot.title = element_text(face = "bold", vjust=2, size = 22), 
        legend.title = element_text(colour="grey40", size=8, face="bold"),
        legend.text = element_text(colour="grey10", size=18, face="bold"),
        legend.position = "none",
        strip.text.x = element_text(size = 22,
                                    hjust = 0.5, vjust = 0.5)) +
  scale_y_continuous(labels = comma) +
        scale_fill_manual(values=cols)
  

ggsave("terreno-device.png", height = 16, width = 22)






#############################################################################
#############################################################################
################# PC y Móviles - SOLO VISITAS DESDE MOVIL ########################
#############################################################################
#############################################################################



###########################################
#### Visitas desde móviles x fuente #######
### Tipo de visitante por dispositivo #####
###########################################



terreno.pc.moviles <- terreno[terreno$device.category == "mobile"|terreno$device.category == "desktop",]


terreno.pc.moviles <- terreno.pc.moviles[!terreno.pc.moviles$fuente == "spam",]


terreno.pc.moviles$fuente <- factor(terreno.pc.moviles$fuente, levels = rev(c("orgánico", "adwords",
                                                                  "redes sociales", "directo",
                                                                  "organico",
                                                                  "referencias", "email", "ritmo romántica",
                                                                  "prensmart")),
                                 ordered = T)




ggplot(terreno.pc.moviles, aes(x=fuente, y = sessions)) +
  geom_bar(stat = "identity",  fill = "lightblue") +
  facet_wrap(~ mes + device.category) + 
  labs(title = "terreno- visitas por fuente (pc y móviles)",
       x = "", y = "") +
  theme(axis.text.x = element_text(colour="grey20",size=18,hjust=.5,vjust=.5,face="plain"),
        axis.text.y = element_text(colour="grey20",size=18,hjust=1,vjust=0,face="plain"),  
        axis.title.x = element_text(colour="grey20",size=12,angle=0,hjust=.5,vjust=0,face="plain"),
        axis.title.y = element_text(colour="grey20",size=12,angle=90,hjust=.5,vjust=.5,face="plain"), 
        plot.title = element_text(face = "bold", vjust=2, size = 22), 
        legend.title = element_text(colour="grey40", size=8, face="bold"),
        legend.text = element_text(colour="grey10", size=12, face="bold"),
        strip.text.x = element_text(size = 22,
                                    hjust = 0.5, vjust = 0.5)) +
  scale_y_continuous(labels = comma) +
        coord_flip()




ggsave("terreno-pc-moviles-fuente.png", height = 9, width = 18)





# 
# terreno.device.moviles <- terreno.device %>%
#                           subset(device.category == "mobile") %>%
#                           group_by(mes, device.category) %>%
#                           summarise(sessions = sum(sessions))
# 
# 
# 
# terreno.device.desktops <- terreno.device %>%
#   subset(device.category == "desktop") %>%
#   group_by(mes, device.category) %>%
#   summarise(sessions = sum(sessions))




# terreno.device.tablet <- terreno.device %>%
#   subset(device.category == "tablet") %>%
#   group_by(mes, device.category) %>%
#   summarise(sessions = sum(sessions))


### Adwords - móviles 


# terreno.adwords.moviles <- terreno %>%
#   subset(device.category == "mobile" & fuente == "adwords") %>%
#   group_by(mes, fuente, device.category) %>%
#   summarise(sessions = sum(sessions))




















