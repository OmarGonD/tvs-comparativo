library(tidyverse)

setwd("D:\\RCoursera\\r-s-l\\extraer-datos\\ripley")







ripley <- dir(getwd(), full.names = TRUE) %>%
          map(read_csv, col_names = TRUE) %>% bind_rows()



#####



ripley$producto <- gsub("Ã", "Í", ripley$producto)
ripley$producto <- gsub("Í\\<U+0093\\>", "Ó", ripley$producto)

##### Marca

ripley$marca <- ifelse(grepl("Samsung", ripley$producto, ignore.case = T), "Samsung",ripley$producto) 

ripley$producto <- gsub("Samsung ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("LG", ripley$producto, ignore.case = T), "LG",ripley$marca) 

ripley$producto <- gsub("LG ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("Haier", ripley$producto, ignore.case = T), "Haier",ripley$marca)

ripley$producto <- gsub("Haier ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("Panasonic", ripley$producto, ignore.case = T), "Panasonic",ripley$marca)


ripley$producto <- gsub("Panasonic ", "", ripley$producto, ignore.case = T)



ripley$marca <- ifelse(grepl("Sony", ripley$producto, ignore.case = T), "Sony",ripley$marca)

ripley$producto <- gsub("Sony ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("Sharp", ripley$producto, ignore.case = T), "Sharp",ripley$marca)

ripley$producto <- gsub("Sharp ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("AOC", ripley$producto, ignore.case = T), "AOC",ripley$marca)

ripley$producto <- gsub("AOC ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("Lenovo", ripley$producto, ignore.case = T), "Lenovo",ripley$marca)

ripley$producto <- gsub("Lenovo ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("Advance", ripley$producto, ignore.case = T), "Advance", ripley$marca)

ripley$producto <- gsub("Advance ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("Acer", ripley$producto, ignore.case = T), "Acer",ripley$marca)

ripley$producto <- gsub("Acer ", "", ripley$producto, ignore.case = T)







ripley$marca <- ifelse(grepl("ASUS", ripley$producto, ignore.case = T), "ASUS",ripley$marca)

ripley$producto <- gsub("ASUS ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("IDEAPAD", ripley$producto, ignore.case = T), "Lenovo",ripley$marca)

ripley$producto <- gsub("IDEAPAD ", "", ripley$producto, ignore.case = T)









ripley$marca <- ifelse(grepl("MSI", ripley$producto, ignore.case = T), "MSI",ripley$marca)

ripley$producto <- gsub("MSI ", "", ripley$producto, ignore.case = T)







ripley$marca <- ifelse(grepl("HUAWEI", ripley$producto, ignore.case = T), "HUAWEI",ripley$marca)

ripley$producto <- gsub("HUAWEI ", "", ripley$producto, ignore.case = T)







ripley$marca <- ifelse(grepl("DELL", ripley$producto, ignore.case = T), "DELL",ripley$marca)

ripley$producto <- gsub("DELL ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("HP", ripley$producto, ignore.case = T), "HP",ripley$marca)

ripley$producto <- gsub("HP ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("OMEN", ripley$producto, ignore.case = T), "HP",ripley$marca)

ripley$producto <- gsub("OMEN ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("Wacom", ripley$producto, ignore.case = T), "Wacom",ripley$marca)

ripley$producto <- gsub("Wacom ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("ALCATEL", ripley$producto, ignore.case = T), "Alcatel",ripley$marca)

ripley$producto <- gsub("ALCATEL ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("LEOTEC", ripley$producto, ignore.case = T), "LEOTEC",ripley$marca)

ripley$producto <- gsub("LEOTEC ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("TARGUS", ripley$producto, ignore.case = T), "TARGUS",ripley$marca)

ripley$producto <- gsub("TARGUS ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("SAKAR", ripley$producto, ignore.case = T), "SAKAR",ripley$marca)

ripley$producto <- gsub("SAKAR ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("EPSON", ripley$producto, ignore.case = T), "EPSON",ripley$marca)

ripley$producto <- gsub("EPSON ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("662XL COLOR", ripley$producto, ignore.case = T), "HP",ripley$marca)







ripley$marca <- ifelse(grepl("ECOTANK", ripley$producto, ignore.case = T), "EPSON",ripley$marca)


ripley$producto <- gsub("ECOTANK ", "", ripley$producto, ignore.case = T)







ripley$marca <- ifelse(grepl("TINTA NEGRO L200/L350/L210/L355 -T664120", ripley$producto, ignore.case = T), "EPSON",ripley$marca)



ripley$marca <- ifelse(grepl("CARTUCHO DE TINTA 122 XL - NEGRO", ripley$producto, ignore.case = T), "EPSON",ripley$marca)



ripley$marca <- ifelse(grepl("CANON", ripley$producto, ignore.case = T), "CANON",ripley$marca)

ripley$producto <- gsub("CANON ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("FIDDLER", ripley$producto, ignore.case = T), "FIDDLER",ripley$marca)

ripley$producto <- gsub("FIDDLER ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("MICROSOFT", ripley$producto, ignore.case = T), "MICROSOFT",ripley$marca)

ripley$producto <- gsub("MICROSOFT ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("PROLINK", ripley$producto, ignore.case = T), "PROLINK",ripley$marca)

ripley$producto <- gsub("PROLINK ", "", ripley$producto, ignore.case = T)







ripley$marca <- ifelse(grepl("HI-TECH", ripley$producto, ignore.case = T), "HI-TECH",ripley$marca)

ripley$producto <- gsub("HI-TECH ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("SKILL", ripley$producto, ignore.case = T), "SKILL",ripley$marca)

ripley$producto <- gsub("SKILL ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("WESTERN", ripley$producto, ignore.case = T), "WESTERN",ripley$marca)

ripley$producto <- gsub("WESTERN ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("IBLUE", ripley$producto, ignore.case = T), "IBLUE",ripley$marca)

ripley$producto <- gsub("IBLUE ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("BITDEFENDER", ripley$producto, ignore.case = T), "BITDEFENDER",ripley$marca)

ripley$producto <- gsub("BITDEFENDER ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("ESET", ripley$producto, ignore.case = T), "ESET",ripley$marca)

ripley$producto <- gsub("ESET ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("KASPERSKY", ripley$producto, ignore.case = T), "KASPERSKY",ripley$marca)

ripley$producto <- gsub("KAPERSKY ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("KINGSTON", ripley$producto, ignore.case = T), "KINGSTON",ripley$marca)

ripley$producto <- gsub("KINGSTON ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("TOSHIBA", ripley$producto, ignore.case = T), "TOSHIBA",ripley$marca)

ripley$producto <- gsub("TOSHIBA ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("SEAGATE", ripley$producto, ignore.case = T), "SEAGATE",ripley$marca)

ripley$producto <- gsub("SEAGATE ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("SANDISK", ripley$producto, ignore.case = T), "SANDISK",ripley$marca)

ripley$producto <- gsub("SANDISK ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("VIEWSONIC", ripley$producto, ignore.case = T), "VIEWSONIC",ripley$marca)

ripley$producto <- gsub("VIEWSONIC ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("TEROS", ripley$producto, ignore.case = T), "TEROS",ripley$marca)

ripley$producto <- gsub("TEROS ", "", ripley$producto, ignore.case = T)






ripley$marca <- ifelse(grepl("BENQ", ripley$producto, ignore.case = T), "BENQ",ripley$marca)

ripley$producto <- gsub("BENQ ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("IMACO", ripley$producto, ignore.case = T), "IMACO",ripley$marca)

ripley$producto <- gsub("IMACO ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("NADAL", ripley$producto, ignore.case = T), "NADAL",ripley$marca)

ripley$producto <- gsub("NADAL ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("Miray", ripley$producto, ignore.case = T), "Miray",ripley$marca)

ripley$producto <- gsub("Miray ", "", ripley$producto, ignore.case = T)



ripley$marca <- ifelse(grepl("Daewoo", ripley$producto, ignore.case = T), "Daewoo",ripley$marca)

ripley$producto <- gsub("Daewoo ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("Nex", ripley$producto, ignore.case = T), "Nex",ripley$marca)

ripley$producto <- gsub("Nex ", "", ripley$producto, ignore.case = T)





ripley$marca <- ifelse(grepl("Xenon", ripley$producto, ignore.case = T), "Xenon",ripley$marca)

ripley$producto <- gsub("Xenon ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("Micronics", ripley$producto, ignore.case = T), "Micronics",ripley$marca)

ripley$producto <- gsub("Micronics ", "", ripley$producto, ignore.case = T)




ripley$marca <- ifelse(grepl("BIANCA", ripley$producto, ignore.case = T), "Ripley Home",ripley$marca)

#ripley$producto <- gsub("Micronics ", "", ripley$producto, ignore.case = T)



ripley$marca <- ifelse(grepl("BIANCA", ripley$producto, ignore.case = T), "Bianca",ripley$marca)

ripley$marca <- ifelse(grepl("PRAGA", ripley$producto, ignore.case = T), "Praga",ripley$marca)

ripley$marca <- ifelse(grepl("KARL", ripley$producto, ignore.case = T), "Karl",ripley$marca)

ripley$marca <- ifelse(grepl("BACH", ripley$producto, ignore.case = T), "Bach",ripley$marca)


ripley$marca <- ifelse(grepl("CANAVARO", ripley$producto, ignore.case = T), "Canavaro",ripley$marca)


ripley$marca <- ifelse(grepl("ARANXA", ripley$producto, ignore.case = T), "Aranxa",ripley$marca)


ripley$marca <- ifelse(grepl("BRUNELLA", ripley$producto, ignore.case = T), "Brunella",ripley$marca)


ripley$marca <- ifelse(grepl("MADRAS", ripley$producto, ignore.case = T), "Madras",ripley$marca)


ripley$marca <- ifelse(grepl("MALIBU", ripley$producto, ignore.case = T), "Malibú",ripley$marca)


ripley$marca <- ifelse(grepl("NEW ROSBERG", ripley$producto, ignore.case = T), "New Rosberg",ripley$marca)


ripley$marca <- ifelse(grepl("AZUCENA", ripley$producto, ignore.case = T), "Azucena",ripley$marca)


ripley$marca <- ifelse(grepl("EAMS", ripley$producto, ignore.case = T), "Eams",ripley$marca)



ripley$marca <- ifelse(grepl("RONY", ripley$producto, ignore.case = T), "Rony",ripley$marca)


ripley$marca <- ifelse(grepl("TONY", ripley$producto, ignore.case = T), "Tony",ripley$marca)


ripley$marca <- ifelse(grepl("KISS", ripley$producto, ignore.case = T), "Kiss",ripley$marca)


ripley$marca <- ifelse(grepl("TONY", ripley$producto, ignore.case = T), "Tony",ripley$marca)


ripley$marca <- ifelse(grepl("SLOAN", ripley$producto, ignore.case = T), "Sloan",ripley$marca)


ripley$marca <- ifelse(grepl("VIOLETA", ripley$producto, ignore.case = T), "Violeta",ripley$marca)


ripley$marca <- ifelse(grepl("JAZZMIN", ripley$producto, ignore.case = T), "Jazzmín",ripley$marca)



ripley$marca <- ifelse(grepl("LILYROSE", ripley$producto, ignore.case = T), "Lilyrose",ripley$marca)


ripley$marca <- ifelse(grepl("MATILDA", ripley$producto, ignore.case = T), "Matilda",ripley$marca)



ripley$marca <- ifelse(grepl("STRAUSS", ripley$producto, ignore.case = T), "Strauss",ripley$marca)


### Marcas Electrohogar



ripley$marca <- ifelse(grepl("BOSCH", ripley$producto, ignore.case = T), "Bosch",ripley$marca)



ripley$marca <- ifelse(grepl("SOLE", ripley$producto, ignore.case = T), "Sole",ripley$marca)


ripley$marca <- ifelse(grepl("GENERAL ELECTRIC", ripley$producto, ignore.case = T), "General Electric",ripley$marca)


ripley$marca <- ifelse(grepl("INDURAMA", ripley$producto, ignore.case = T), "Indurama",ripley$marca)


ripley$marca <- ifelse(grepl("ELECTROLUX", ripley$producto, ignore.case = T), "Electrolux",ripley$marca)


ripley$marca <- ifelse(grepl("COLDEX", ripley$producto, ignore.case = T), "Coldex",ripley$marca)


ripley$marca <- ifelse(grepl("KLIMATIC", ripley$producto, ignore.case = T), "Klimatic",ripley$marca)


ripley$marca <- ifelse(grepl("MABE", ripley$producto, ignore.case = T), "Mabe",ripley$marca)


ripley$marca <- ifelse(grepl("MABE", ripley$producto, ignore.case = T), "Mabe",ripley$marca)


### Muebles



ripley$marca <- ifelse(grepl("BOREAL", ripley$producto, ignore.case = T), "Boreal",ripley$marca)

ripley$marca <- ifelse(grepl("ASHLEY", ripley$producto, ignore.case = T), "Ashley",ripley$marca)

ripley$marca <- ifelse(grepl("ASHLEY", ripley$producto, ignore.case = T), "Ashley",ripley$marca)





####



#ripley$marca <- ifelse(grepl("[0-9]", ripley$marca, ignore.case = T), "Otras",ripley$marca)




##########################################


ripley <- ripley[, c(1,2,3,4,8,5,6,7)]



###
setwd("D:\\RCoursera\\r-s-l\\base-de-datos\\ripley-bd")

 
file <- paste( as.character(Sys.Date()),"ripley-bd", sep = "-")

ripley_csv <- paste(file, "csv", sep = ".")


write.csv(ripley, ripley_csv, row.names = F)



