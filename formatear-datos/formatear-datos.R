library(dplyr)
library(tidyr)


setwd("D:\\rls\\tvs-comparativo\\extraer-datos")
#setwd("D:\\RCoursera\\r-s-l\\extraer-datos")

falabella <- read.csv("2017-08-24-falabella.csv")
ripley <- read.csv("2017-08-24-ripley.csv")
linio <- read.csv("2017-08-24-linio.csv")




ecommerce <- rbind(ripley, linio)

#### 








##### Marca

ecommerce$marca <- ifelse(grepl("Samsung", ecommerce$producto, ignore.case = T), "Samsung",ecommerce$producto) 

ecommerce$producto <- gsub("Samsung ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("LG", ecommerce$producto, ignore.case = T), "LG",ecommerce$marca) 

ecommerce$producto <- gsub("LG ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("Haier", ecommerce$producto, ignore.case = T), "Haier",ecommerce$marca)

ecommerce$producto <- gsub("Haier ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("Panasonic", ecommerce$producto, ignore.case = T), "Panasonic",ecommerce$marca)


ecommerce$producto <- gsub("Panasonic ", "", ecommerce$producto, ignore.case = T)



ecommerce$marca <- ifelse(grepl("Sony", ecommerce$producto, ignore.case = T), "Sony",ecommerce$marca)

ecommerce$producto <- gsub("Sony ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("Sharp", ecommerce$producto, ignore.case = T), "Sharp",ecommerce$marca)

ecommerce$producto <- gsub("Sharp ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("AOC", ecommerce$producto, ignore.case = T), "AOC",ecommerce$marca)

ecommerce$producto <- gsub("AOC ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("Lenovo", ecommerce$producto, ignore.case = T), "Lenovo",ecommerce$marca)

ecommerce$producto <- gsub("Lenovo ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("Advance", ecommerce$producto, ignore.case = T), "Advance", ecommerce$marca)

ecommerce$producto <- gsub("Advance ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("Acer", ecommerce$producto, ignore.case = T), "Acer",ecommerce$marca)

ecommerce$producto <- gsub("Acer ", "", ecommerce$producto, ignore.case = T)







ecommerce$marca <- ifelse(grepl("ASUS", ecommerce$producto, ignore.case = T), "ASUS",ecommerce$marca)

ecommerce$producto <- gsub("ASUS ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("IDEAPAD", ecommerce$producto, ignore.case = T), "Lenovo",ecommerce$marca)

ecommerce$producto <- gsub("IDEAPAD ", "", ecommerce$producto, ignore.case = T)









ecommerce$marca <- ifelse(grepl("MSI", ecommerce$producto, ignore.case = T), "MSI",ecommerce$marca)

ecommerce$producto <- gsub("MSI ", "", ecommerce$producto, ignore.case = T)







ecommerce$marca <- ifelse(grepl("HUAWEI", ecommerce$producto, ignore.case = T), "HUAWEI",ecommerce$marca)

ecommerce$producto <- gsub("HUAWEI ", "", ecommerce$producto, ignore.case = T)







ecommerce$marca <- ifelse(grepl("DELL", ecommerce$producto, ignore.case = T), "DELL",ecommerce$marca)

ecommerce$producto <- gsub("DELL ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("HP", ecommerce$producto, ignore.case = T), "HP",ecommerce$marca)

ecommerce$producto <- gsub("HP ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("OMEN", ecommerce$producto, ignore.case = T), "HP",ecommerce$marca)

ecommerce$producto <- gsub("OMEN ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("Wacom", ecommerce$producto, ignore.case = T), "Wacom",ecommerce$marca)

ecommerce$producto <- gsub("Wacom ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("ALCATEL", ecommerce$producto, ignore.case = T), "Alcatel",ecommerce$marca)

ecommerce$producto <- gsub("ALCATEL ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("LEOTEC", ecommerce$producto, ignore.case = T), "LEOTEC",ecommerce$marca)

ecommerce$producto <- gsub("LEOTEC ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("TARGUS", ecommerce$producto, ignore.case = T), "TARGUS",ecommerce$marca)

ecommerce$producto <- gsub("TARGUS ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("SAKAR", ecommerce$producto, ignore.case = T), "SAKAR",ecommerce$marca)

ecommerce$producto <- gsub("SAKAR ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("EPSON", ecommerce$producto, ignore.case = T), "EPSON",ecommerce$marca)

ecommerce$producto <- gsub("EPSON ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("662XL COLOR", ecommerce$producto, ignore.case = T), "HP",ecommerce$marca)







ecommerce$marca <- ifelse(grepl("ECOTANK", ecommerce$producto, ignore.case = T), "EPSON",ecommerce$marca)


ecommerce$producto <- gsub("ECOTANK ", "", ecommerce$producto, ignore.case = T)







ecommerce$marca <- ifelse(grepl("TINTA NEGRO L200/L350/L210/L355 -T664120", ecommerce$producto, ignore.case = T), "EPSON",ecommerce$marca)



ecommerce$marca <- ifelse(grepl("CARTUCHO DE TINTA 122 XL - NEGRO", ecommerce$producto, ignore.case = T), "EPSON",ecommerce$marca)



ecommerce$marca <- ifelse(grepl("CANON", ecommerce$producto, ignore.case = T), "CANON",ecommerce$marca)

ecommerce$producto <- gsub("CANON ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("FIDDLER", ecommerce$producto, ignore.case = T), "FIDDLER",ecommerce$marca)

ecommerce$producto <- gsub("FIDDLER ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("MICROSOFT", ecommerce$producto, ignore.case = T), "MICROSOFT",ecommerce$marca)

ecommerce$producto <- gsub("MICROSOFT ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("PROLINK", ecommerce$producto, ignore.case = T), "PROLINK",ecommerce$marca)

ecommerce$producto <- gsub("PROLINK ", "", ecommerce$producto, ignore.case = T)







ecommerce$marca <- ifelse(grepl("HI-TECH", ecommerce$producto, ignore.case = T), "HI-TECH",ecommerce$marca)

ecommerce$producto <- gsub("HI-TECH ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("SKILL", ecommerce$producto, ignore.case = T), "SKILL",ecommerce$marca)

ecommerce$producto <- gsub("SKILL ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("WESTERN", ecommerce$producto, ignore.case = T), "WESTERN",ecommerce$marca)

ecommerce$producto <- gsub("WESTERN ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("IBLUE", ecommerce$producto, ignore.case = T), "IBLUE",ecommerce$marca)

ecommerce$producto <- gsub("IBLUE ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("BITDEFENDER", ecommerce$producto, ignore.case = T), "BITDEFENDER",ecommerce$marca)

ecommerce$producto <- gsub("BITDEFENDER ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("ESET", ecommerce$producto, ignore.case = T), "ESET",ecommerce$marca)

ecommerce$producto <- gsub("ESET ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("KASPERSKY", ecommerce$producto, ignore.case = T), "KASPERSKY",ecommerce$marca)

ecommerce$producto <- gsub("KAPERSKY ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("KINGSTON", ecommerce$producto, ignore.case = T), "KINGSTON",ecommerce$marca)

ecommerce$producto <- gsub("KINGSTON ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("TOSHIBA", ecommerce$producto, ignore.case = T), "TOSHIBA",ecommerce$marca)

ecommerce$producto <- gsub("TOSHIBA ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("SEAGATE", ecommerce$producto, ignore.case = T), "SEAGATE",ecommerce$marca)

ecommerce$producto <- gsub("SEAGATE ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("SANDISK", ecommerce$producto, ignore.case = T), "SANDISK",ecommerce$marca)

ecommerce$producto <- gsub("SANDISK ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("VIEWSONIC", ecommerce$producto, ignore.case = T), "VIEWSONIC",ecommerce$marca)

ecommerce$producto <- gsub("VIEWSONIC ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("TEROS", ecommerce$producto, ignore.case = T), "TEROS",ecommerce$marca)

ecommerce$producto <- gsub("TEROS ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("BENQ", ecommerce$producto, ignore.case = T), "BENQ",ecommerce$marca)

ecommerce$producto <- gsub("BENQ ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("IMACO", ecommerce$producto, ignore.case = T), "IMACO",ecommerce$marca)

ecommerce$producto <- gsub("IMACO ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("NADAL", ecommerce$producto, ignore.case = T), "NADAL",ecommerce$marca)

ecommerce$producto <- gsub("NADAL ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("Miray", ecommerce$producto, ignore.case = T), "Miray",ecommerce$marca)

ecommerce$producto <- gsub("Miray ", "", ecommerce$producto, ignore.case = T)



ecommerce$marca <- ifelse(grepl("Daewoo", ecommerce$producto, ignore.case = T), "Daewoo",ecommerce$marca)

ecommerce$producto <- gsub("Daewoo ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("Nex", ecommerce$producto, ignore.case = T), "Nex",ecommerce$marca)

ecommerce$producto <- gsub("Nex ", "", ecommerce$producto, ignore.case = T)





ecommerce$marca <- ifelse(grepl("Xenon", ecommerce$producto, ignore.case = T), "Xenon",ecommerce$marca)

ecommerce$producto <- gsub("Xenon ", "", ecommerce$producto, ignore.case = T)




ecommerce$marca <- ifelse(grepl("Micronics", ecommerce$producto, ignore.case = T), "Micronics",ecommerce$marca)

ecommerce$producto <- gsub("Micronics ", "", ecommerce$producto, ignore.case = T)






ecommerce$marca <- ifelse(grepl("[0-9]", ecommerce$marca, ignore.case = T), "Otras",ecommerce$marca)




##########################################
##########################################
##########################################


ecommerce$producto <- gsub('"', '', ecommerce$producto, ignore.case = T)



##########################################
##########################################












##########################################
##########################################
##########################################



ecommerce <- rbind(ecommerce, falabella)


ecommerce <- ecommerce[,c(1,2,3,7,4,5,6)]



##########################################
##########################################
##########################################



ecommerce$producto <- trimws(ecommerce$producto, which = "both")


ecommerce$precio.antes <- trimws(ecommerce$precio.antes, which = "both")

ecommerce$precio.actual <- trimws(ecommerce$precio.actual, which = "both")





ecommerce$precio.antes <- gsub(".*S/ ", "", ecommerce$precio.antes)
ecommerce$precio.actual <- gsub(".*S/ ", "", ecommerce$precio.actual)



ecommerce$precio.antes <- gsub(",", "", ecommerce$precio.antes)
ecommerce$precio.actual <- gsub(",", "", ecommerce$precio.actual)


ecommerce$precio.antes <- as.numeric(ecommerce$precio.antes)
ecommerce$precio.actual <- as.numeric(ecommerce$precio.actual)




ecommerce$producto <- gsub("â�???�", '"',ecommerce$producto)







### Split columns to get SKU ### 


# a <- separate(data = ecommerce, col = producto, into = c("a", "b", "c", "d", "e", "f", "h","i", "j", "k", 
#                                                          "l", "m"), sep = "\\s", remove = FALSE)
# 
# 
# 
# 
# 
# 
# 
# 
# 
# ecommerce_matches <- ecommerce %>%
#                      distinct(producto, marca, .keep_all = TRUE)
# 
# 
# 
# 


#############
#############
#############


# ecommerce$sku <- gsub("(.*)([0-9]{2}[a-zA-Z]{1,2}[0-9]{2,4})(.*)", "\\2", ecommerce$producto)
# 
ecommerce$sku <- gsub("(.*)([a-zA-Z]?{2}[0-9]{2}[a-zA-Z]{1,2}[0-9]{2,4})(.*)", "\\2", ecommerce$producto)


ecommerce$sku <- gsub("(.*)([0-9]{2}[a-zA-Z]{1,2}[0-9]{2,4})(.*)", "\\2", ecommerce$sku)


ecommerce$sku <- gsub("(.*)([0-9]{2}[a-zA-Z]{1,2}[0-9]{1}[a-zA-Z]{1})(.*)", "\\2", ecommerce$sku)

ecommerce$sku <- gsub("(.*)([a-zA-Z]{2}[0-9]{2}[a-zA-Z]{2})(.*)", "\\2", ecommerce$sku)


ecommerce$sku <- gsub("(.*)([a-zA-Z]{2}[0-9]{3,4})(.*)", "\\2", ecommerce$sku)


ecommerce$producto <- gsub("�<U\\+0080>�", "", ecommerce$producto)

ecommerce$producto <- gsub("<U\\+0096>", "", ecommerce$producto)

ecommerce$producto <- gsub("�|�.*>", "", ecommerce$producto)

ecommerce$producto <- gsub("�<U\\+009A>", "�", ecommerce$producto)

ecommerce$producto <- gsub("�<U\\+0097>", "", ecommerce$producto)

ecommerce$producto <- gsub("^- ", "", ecommerce$producto)


dput(ecommerce, "ecommerceSS.txt")
