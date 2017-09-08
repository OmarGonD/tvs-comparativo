library(RSelenium)
library(rvest)
library(dplyr)
library(tidyr)
library(stringr)
library(urltools)

#setwd("D:\\RCoursera\\Ripley")
setwd("D:\\rls\\tvs-comparativo\\extraer-datos") #LAPTOP
#setwd("D:\\RCoursera\\r-s-l\\extraer-datos") #PC



#start RSelenium


rD  <- rsDriver(port = 4543L, browser = "firefox", version = "latest", chromever = "latest",
                geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
                verbose = TRUE, check = TRUE)



remDr <- rD[["client"]]



#### URLS #####

mundobebe_url <- "http://simple.ripley.com.pe/infantil/paseo-y-viajes/porta-bebes-y-caminadores?page="


ripley_infantil_todo_mundobebe <- c()

for (i in 1:11) {
  
  ripley_infantil_todo_mundobebe <- c(ripley_infantil_todo_mundobebe,paste0(mundobebe_url, i))
}




cunascorrales <- "http://simple.ripley.com.pe/infantil/mundo-bebe/cunas-y-corrales?page="


ripley_infantil_cunascorrales <- c()


for (i in 1:4) {
  
  ripley_infantil_cunascorrales <- c(ripley_infantil_cunascorrales,paste0(cunascorrales, i))

}



sillasdecomer <- "http://simple.ripley.com.pe/infantil/mundo-bebe/sillas-de-comer?page="

ripley_infantil_sillasdecomer <- c()


for (i in 1:3) {
  
  ripley_infantil_sillasdecomer <- c(ripley_infantil_sillasdecomer, paste0(sillasdecomer, i))
  
}



biberones <- "http://simple.ripley.com.pe/infantil/maternidad/biberones-y-chupones?page="

ripley_infantil_biberones <- c()


for (i in 1:3) {
  
  ripley_infantil_biberones <- c(ripley_infantil_biberones, paste0(biberones, i))
  
}




dormitoriobebe <- "http://simple.ripley.com.pe/infantil/mundo-bebe/dormitorio-bebe?page="

ripley_infantil_dormitoriobebe <- c()


for (i in 1:3) {
  
  ripley_infantil_dormitoriobebe <- c(ripley_infantil_dormitoriobebe, paste0(dormitoriobebe, i))
  
}



juguetesbebe <- "http://simple.ripley.com.pe/infantil/mundo-bebe/juguetes-bebe?page="


ripley_infantil_juguetesbebe <- c()

for (i in 1:5) {
  
  ripley_infantil_juguetesbebe <- c(ripley_infantil_juguetesbebe, paste0(juguetesbebe, i))
  
}




maternidad <- "http://simple.ripley.com.pe/infantil/maternidad/todo-maternidad?page="

ripley_infantil_maternidad <- c()

for (i in 1:8) {
  
  ripley_infantil_maternidad <- c(ripley_infantil_maternidad, paste0(maternidad, i))
  
}



lactancia <- "http://simple.ripley.com.pe/infantil/maternidad/lactancia?page="

ripley_infantil_lactancia <- c()

for (i in 1:2) {
  
  ripley_infantil_lactancia <- c(ripley_infantil_lactancia, paste0(lactancia, i))
  
}



infantil_actividad <- "http://simple.ripley.com.pe/infantil/actividad/todo-actividad?page="


ripley_infantil_actividad_todoactividad <- c()


for (i in 1:5) {
  
  ripley_infantil_actividad_todoactividad <- c(ripley_infantil_actividad_todoactividad, paste0(infantil_actividad, i))
  
}

#

infantil_juegosdeexterior_todojuegosdeexterior <- "http://simple.ripley.com.pe/infantil/juegos-de-exterior/todo-juegos-de-exterior?page="

ripley_infantil_juegosdeexterior_todojuegosdeexterior <- c()


for (i in 1:4) {
  
  ripley_infantil_juegosdeexterior_todojuegosdeexterior <- c(ripley_infantil_juegosdeexterior_todojuegosdeexterior, paste0(infantil_juegosdeexterior_todojuegosdeexterior, i))
  
}



infantil_marcasbebes_littletikes <- "http://simple.ripley.com.pe/infantil/marcas-bebes/little-tikes?page="

ripley_infantil_marcasbebes_littletikes <- c()


for (i in 1:3) {
  
  ripley_infantil_marcasbebes_littletikes <- c(ripley_infantil_marcasbebes_littletikes, paste0(infantil_marcasbebes_littletikes, i))
  
}





infantil_marcasbebes_fisherprice <- "http://simple.ripley.com.pe/infantil/marcas-bebes/fisher-price?page="


ripley_infantil_marcasbebes_fisherprice <- c()




for (i in 1:5) {
  
  ripley_infantil_marcasbebes_fisherprice <- c(ripley_infantil_marcasbebes_fisherprice, paste0(infantil_marcasbebes_fisherprice, i))
  
}



#############################################


infantil_escolar_catucheras <- "http://simple.ripley.com.pe/infantil/escolar/cartucheras-y-utiles?page="

ripley_infantil_escolar_cartucheras <- c()

for (i in 1:5) {
  
  ripley_infantil_escolar_cartucheras <- c(ripley_infantil_escolar_cartucheras, paste0(infantil_escolar_catucheras, i))  
  
}


#

entretenimiento_marcas_iberolibrerias <- "http://simple.ripley.com.pe/entretenimiento/marcas/ibero-librerias?page="

ripley_entretenimiento_marcas_iberolibrerias <- c()

for (i in 1:5) {
  
  ripley_entretenimiento_marcas_iberolibrerias <- c(ripley_entretenimiento_marcas_iberolibrerias, paste0(entretenimiento_marcas_iberolibrerias, i))  
  
}


#


infantil_coleccionables_todos <- "http://simple.ripley.com.pe/infantil/coleccionables/todo-coleccionables?page="

ripley_infantil_coleccionables_todos <- c()

for (i in 1:4) {
  
  ripley_infantil_coleccionables_todos <- c(ripley_infantil_coleccionables_todos, paste0(infantil_coleccionables_todos, i)) 
}



##########################################################


ripley_urls <- c("http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=1&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=2&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=3&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=4&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=5&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=6&orderBy=",
                 "http://simple.ripley.com.pe/tv-y-video/televisores/ver-todo-tv?page=7&orderBy=",
                 "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=1",
                 "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=2",
                 "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=3",
                 "http://simple.ripley.com.pe/computo/laptops/todas-las-laptops?page=4",
                 "http://simple.ripley.com.pe/computo/2-en-1-convertibles/laptops-2-en-1",
                 "http://simple.ripley.com.pe/computo/computadoras/pc-all-in-one",
                 "http://simple.ripley.com.pe/computo/zona-gamer/laptops-gamer",
                 "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/tablets-y-phablets?page=1",
                 "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/tablets-y-phablets?page=2",
                 "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/tablets-y-phablets?page=3",
                 "http://simple.ripley.com.pe/computo/tablets-phablets-y-accesorios/estuches-y-fundas",
                 "http://simple.ripley.com.pe/computo/impresoras-y-tintas/todo-impresoras?page=1",
                 "http://simple.ripley.com.pe/computo/impresoras-y-tintas/todo-impresoras?page=2",
                 "http://simple.ripley.com.pe/computo/impresoras-y-tintas/multifuncionales",
                 "http://simple.ripley.com.pe/computo/impresoras-y-tintas/toners-y-tintas?page=1",
                 "http://simple.ripley.com.pe/computo/impresoras-y-tintas/toners-y-tintas?page=2",
                 "http://simple.ripley.com.pe/computo/accesorios-y-software/mouse-teclados-y-parlantes?page=1",
                 "http://simple.ripley.com.pe/computo/accesorios-y-software/mouse-teclados-y-parlantes?page=2",
                 "http://simple.ripley.com.pe/computo/accesorios-y-software/estuches-y-maletines?page=1",
                 "http://simple.ripley.com.pe/computo/accesorios-y-software/estuches-y-maletines?page=2",
                 "http://simple.ripley.com.pe/computo/accesorios-y-software/cargadores-cables-y-otros",
                 "http://simple.ripley.com.pe/computo/accesorios-y-software/software-y-antivirus",
                 "http://simple.ripley.com.pe/computo/almacenamiento/memorias-usb",
                 "http://simple.ripley.com.pe/computo/almacenamiento/discos-duros?page=1",
                 "http://simple.ripley.com.pe/computo/almacenamiento/discos-duros?page=2",
                 "http://simple.ripley.com.pe/computo/almacenamiento/pendrives",
                 "http://simple.ripley.com.pe/computo/proyectores-y-monitores/proyectores",
                 "http://simple.ripley.com.pe/computo/proyectores-y-monitores/monitores?page=1",
                 "http://simple.ripley.com.pe/computo/proyectores-y-monitores/monitores?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/videojuegos/todo-videojuegos",
                 "http://simple.ripley.com.pe/entretenimiento/videojuegos/todo-videojuegos?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/videojuegos/todo-videojuegos?page=3",
                 "http://simple.ripley.com.pe/entretenimiento/videojuegos/todo-videojuegos?page=4",
                 "http://simple.ripley.com.pe/entretenimiento/videojuegos/todo-videojuegos?page=5",
                 "http://simple.ripley.com.pe/entretenimiento/videojuegos/todo-videojuegos?page=6",
                 "http://simple.ripley.com.pe/entretenimiento/videojuegos/todo-videojuegos?page=7",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/todo-fotografia?page=1",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/todo-fotografia?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/todo-fotografia?page=3",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/todo-fotografia?page=4",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/todo-fotografia?page=5",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/todo-fotografia?page=6",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/camaras-compactas?page=1",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/camaras-compactas?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/camaras-bridge",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/camaras-mirrorless",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/camaras-reflex-y-pro",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/camaras-outdoor-y-accion",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/camaras-instantaneas",
                 "http://simple.ripley.com.pe/entretenimiento/fotografia/videocamaras",
                            "http://simple.ripley.com.pe/entretenimiento/fotografia/accesorios?page=1",
                            "http://simple.ripley.com.pe/entretenimiento/fotografia/accesorios?page=2",
                            "http://simple.ripley.com.pe/entretenimiento/fotografia/accesorios?page=3",
                            "http://simple.ripley.com.pe/entretenimiento/fotografia/binoculares",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/instrumentos-de-cuerda",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/instrumentos-de-percusion",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/teclados",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/amplificadores?page=1",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/amplificadores?page=2",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/amplificadores?page=3",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/accesorios-musicales",
                            "http://simple.ripley.com.pe/entretenimiento/instrumentos-musicales/auriculares-profesionales",
                            "http://simple.ripley.com.pe/deporte/camping-y-tiempo-libre/carpas",
                            "http://simple.ripley.com.pe/deporte/camping-y-tiempo-libre/accesorios-de-camping?page=1",
                            "http://simple.ripley.com.pe/deporte/camping-y-tiempo-libre/accesorios-de-camping?page=2",
                            "http://simple.ripley.com.pe/deporte/camping-y-tiempo-libre/mochilas-y-bolsos?page=1",
                            "http://simple.ripley.com.pe/deporte/camping-y-tiempo-libre/mochilas-y-bolsos?page=2",
                            "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/camas-elasticas",
                            "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/autos-a-bateria",
                            "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/casas-de-juegos",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=2",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=3",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=4",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=5",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=6",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=7",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=8",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=9",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=10",
                            "http://simple.ripley.com.pe/infantil/jugueteria/todo-juguetes?page=11",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=2",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=3",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=4",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=5",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=6",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=7",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=8",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=9",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=10",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninas?page=11",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=2",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=3",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=4",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=5",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=6",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=7",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=8",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=9",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=10",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-para-ninos?page=11",
                            "http://simple.ripley.com.pe/infantil/jugueteria/pre-escolar-y-bebes?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/pre-escolar-y-bebes?page=2",
                            "http://simple.ripley.com.pe/infantil/jugueteria/pre-escolar-y-bebes?page=3",
                            "http://simple.ripley.com.pe/infantil/jugueteria/pre-escolar-y-bebes?page=4",
                            "http://simple.ripley.com.pe/infantil/jugueteria/pre-escolar-y-bebes?page=5",
                            "http://simple.ripley.com.pe/infantil/jugueteria/pre-escolar-y-bebes?page=6",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juegos-de-mesa?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juegos-de-mesa?page=2",
                            "http://simple.ripley.com.pe/infantil/jugueteria/armables-y-didacticos?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/armables-y-didacticos?page=2",
                            "http://simple.ripley.com.pe/infantil/jugueteria/juguetes-interactivos",
                            "http://simple.ripley.com.pe/infantil/jugueteria/peluches",
                            "http://simple.ripley.com.pe/infantil/jugueteria/vehiculos?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/vehiculos?page=2",
                            "http://simple.ripley.com.pe/infantil/jugueteria/arte-y-pintura?page=1",
                            "http://simple.ripley.com.pe/infantil/jugueteria/arte-y-pintura?page=2",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=1",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=2",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=3",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=4",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=5",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=6",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=7",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=8",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=9",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=10",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/todo-paseo-y-viajes?page=11",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=1",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=2",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=3",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=4",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=5",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=6",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=7",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=8",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=9",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/coches?page=10",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/sillas-de-auto?page=1",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/sillas-de-auto?page=2",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/sillas-de-auto?page=3",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/cunas-pack-and-play",
                            "http://simple.ripley.com.pe/infantil/maternidad/bolsos-y-cambiadores?page=1",
                            "http://simple.ripley.com.pe/infantil/maternidad/bolsos-y-cambiadores?page=2",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/porta-bebes-y-caminadores?page=1",
                            "http://simple.ripley.com.pe/infantil/paseo-y-viajes/porta-bebes-y-caminadores?page=2",
                 ripley_infantil_todo_mundobebe,
                 ripley_infantil_cunascorrales,
                 ripley_infantil_sillasdecomer,
                 "http://simple.ripley.com.pe/infantil/actividad/centros-de-actividad-y-gimnasios?page=1",
                 "http://simple.ripley.com.pe/infantil/actividad/centros-de-actividad-y-gimnasios?page=2",
                 "http://simple.ripley.com.pe/infantil/mundo-bebe/bouncer",
                 "http://simple.ripley.com.pe/infantil/mundo-bebe/bano?page=1",
                 "http://simple.ripley.com.pe/infantil/mundo-bebe/bano?page=2",
                 ripley_infantil_biberones,
                 ripley_infantil_dormitoriobebe,
                 ripley_infantil_juguetesbebe,
                 "http://simple.ripley.com.pe/infantil/mundo-bebe/alimentacion?page=1",
                 "http://simple.ripley.com.pe/infantil/mundo-bebe/alimentacion?page=2",
                 "http://simple.ripley.com.pe/infantil/mundo-bebe/monitores-de-bebe",
                 "http://simple.ripley.com.pe/infantil/mundo-bebe/accesorios",
                 ripley_infantil_maternidad,
                 ripley_infantil_lactancia,
                 "http://simple.ripley.com.pe/infantil/maternidad/extractores",
                 "http://simple.ripley.com.pe/infantil/maternidad/brasiers-para-lactancia",
                 "http://simple.ripley.com.pe/infantil/maternidad/esterilizadores-y-calentadores",
                 "http://simple.ripley.com.pe/infantil/maternidad/pre-natal-y-post-natal",
                 "http://simple.ripley.com.pe/infantil/maternidad/bolsos-y-cambiadores?page=1",
                 "http://simple.ripley.com.pe/infantil/maternidad/bolsos-y-cambiadores?page=2",
                 ripley_infantil_actividad_todoactividad,
                 "http://simple.ripley.com.pe/infantil/actividad/centros-de-actividad-y-gimnasios?page=1",
                 "http://simple.ripley.com.pe/infantil/actividad/centros-de-actividad-y-gimnasios?page=2",
                 "http://simple.ripley.com.pe/infantil/actividad/andadores?page=1",
                 "http://simple.ripley.com.pe/infantil/actividad/andadores?page=2",
                 "http://simple.ripley.com.pe/infantil/actividad/estimulacion",
                 ripley_infantil_juegosdeexterior_todojuegosdeexterior,
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/autos-a-bateria",
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/correpasillos",
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/casas-de-juegos",
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/cocinas-y-mesa",
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/columpios-y-resbaladeras",
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/triciclos-y-scooters?page=1",
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/triciclos-y-scooters?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/outdoor-y-juegos-de-exterior/camas-elasticas",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/playstation?page=1",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/playstation?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/playstation?page=3",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/nintendo?page=1",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/nintendo?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/sony",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/nikon?page=1",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/nikon?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/canon?page=1",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/canon?page=2",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/fujifilm",
                 "http://simple.ripley.com.pe/entretenimiento/marcas/polaroid",
                 "http://simple.ripley.com.pe/infantil/juegos-de-exterior/piscinas-e-inflables",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/play-doh?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/play-doh?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/yogurtinis",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/barbie?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/barbie?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/soy-luna",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/little-mommy",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/disney-princesas?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/disney-princesas?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/peppa-pig",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/my-little-pony?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/my-little-pony?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/frozen",
                 "http://simple.ripley.com.pe/infantil/marcas-ninas/furreal-friends",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/avengers",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/hot-wheels",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/lego",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/star-wars?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/star-wars?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/star-wars?page=3",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/spiderman?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/spiderman?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/minions",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/cars?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/cars?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/transformers?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/transformers?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-ninos/nerf",
                 ripley_infantil_marcasbebes_littletikes,
                 ripley_infantil_marcasbebes_fisherprice,
                 "http://simple.ripley.com.pe/infantil/marcas-bebes/mega-bloks?page=1",
                 "http://simple.ripley.com.pe/infantil/marcas-bebes/mega-bloks?page=2",
                 "http://simple.ripley.com.pe/infantil/marcas-bebes/play-skool",
                 "http://simple.ripley.com.pe/infantil/marcas-bebes/vtech",
                 "http://simple.ripley.com.pe/infantil/marcas-bebes/thomas-y-friends",
                 "http://simple.ripley.com.pe/infantil/marcas-bebes/imaginext",
                 "http://simple.ripley.com.pe/infantil/marcas-bebes/paw-patrol",
                 "http://simple.ripley.com.pe/infantil/moda-infantil/todo-moda-infantil",
                 ripley_infantil_escolar_cartucheras,
                 "http://simple.ripley.com.pe/infantil/escolar/mochilas-y-loncheras?page=1",
                 "http://simple.ripley.com.pe/infantil/escolar/mochilas-y-loncheras?page=2",
                 "http://simple.ripley.com.pe/infantil/escolar/tomatodo-y-accesorios",
                 ripley_infantil_coleccionables_todos,
                 ripley_entretenimiento_marcas_iberolibrerias
                 
                 )










#### Data Lists #####



ripley_data_list <- list()

#### Extracción de datos ####




for (i in ripley_urls) {
  
  remDr$navigate(i)
  
  Sys.sleep(10)
  
  #1 == Categoria: Cómputo
  #2 == Subcategoria: Proyectores y monitores
  #3 == Producto: Monitores
    
  categoria_url <- (str_split(path(i), "\\/")[[1]][1])
  subcategoria_url <- (str_split(path(i), "\\/")[[1]][2])
  producto_url <- (str_split(path(i), "\\/")[[1]][3])
  
  
  
  page_source<-remDr$getPageSource()
  
  
  
  product_info <- function(node){
    # r.categoria <- categoria
    # r.subcategoria <- subcategoria
    # r.producto <- producto
    r.precio.antes <- html_nodes(node, 'span.catalog-product-list-price') %>% html_text
    r.precio.actual <- html_nodes(node, 'span.catalog-product-offer-price') %>% html_text 
    r.producto <- html_nodes(node,"span.catalog-product-name") %>% html_text
    
    
    
    
    
    data.frame(
      fecha = as.character(Sys.Date()),
      ecommerce = "Ripley",
      categoria_url = categoria_url,
      subcategoria_url = subcategoria_url,
      producto_url = producto_url,
      producto = r.producto,
      precio.antes = ifelse(length(r.precio.antes)==0, NA, r.precio.antes),
      precio.actual = ifelse(length(r.precio.actual)==0, NA, r.precio.actual), 
      #tarjeta.ripley = ifelse(length(r.tarjeta)==0, NA, r.tarjeta),
      stringsAsFactors=F
    )
    
    
  }
  
  
  
  doc <- read_html(iconv(page_source[[1]]), to="UTF-8") %>% 
    html_nodes("div.product-description")
  
  
  
  
  
  
  
  tvs <- lapply(doc, product_info) %>%
    bind_rows()
  
  
  ripley_data_list[[i]] <- tvs # add it to your list
  
  
}



ripley = do.call(rbind, ripley_data_list)


#ripley_tvs <- cbind(fecha = as.character(Sys.Date()), ripley_tvs)


rownames(ripley) <- NULL



#####################################################################
#####################################################################




file <- paste( as.character(Sys.Date()),"ripley", sep = "-")

ripley_csv <- paste(file, "csv", sep = ".")


write.csv(ripley, ripley_csv, row.names = F)
