# Script para manipular datos csv de los barcos camaroneros, le asigna el mes y asigna el nombre de los estados
library(pacman)
pacman::p_load(dplyr, xlsx, nortest, sf, leaflet,raster,viridis, lubridate)
setwd("D:/ReporteCamaronerosGolfoInapesca2005_2010/2010")
datos <- list.files(".", pattern = "*.csv")

#Librerías para unir todos los csv
library(plyr)
library(readr)
library(tidyverse)
#Union de los csv
datos <- ldply(datos, read_csv)
datos11_35 <- filter(datos, Velocidad >= 1.7 & Velocidad  < 3.5)
#datos11_35respaldo <- datos11_35
#datos11_352 <-mutate(datos11_35, lat = datos11_35$Latitud, lon = datos11_35$Longitud)

#Crear una nueva columna para el Mes
datos11_352 <- mutate(datos11_35, Mes= month(datos11_35$`Fecha y Hora`))

datos11_352fin<- mutate(datos11_352, Edo=case_when(datos11_352$`Puerto Base`=='CAMPECHE, CAM.' ~ "Campeche",
                                                datos11_352$`Puerto Base`=='CIUDAD DEL CARMEN, CAM.' ~ "Campeche",
                                                datos11_352$`Puerto Base`=='LERMA, CAM.' ~ "Campeche",
                                                datos11_352$`Puerto Base`=='TAMPICO, TAMPS.' ~ "Tamaulipas",
                                                datos11_352$`Puerto Base`=='ALVARADO, VER.' ~ "Veracruz",
                                                datos11_352$`Puerto Base`=='TUXPAN, VER.' ~ "Veracruz",
                                                datos11_352$`Puerto Base`=='VERACRUZ, VER.' ~ "Veracruz",
                                                datos11_352$`Puerto Base`=='COATZACOALCOS, VER' ~ "Veracruz",
                                                datos11_352$`Puerto Base`=='PUERTO JUAREZ, QROO' ~ "Quintana Roo"))


#Cargar el shp
#cortar <- st_read("D:/Reporte Camaroneros Golfo Inapesca 2016 - 2017/vec/para_cortar.shp")

#datos11_352fin_vec <- st_as_sf(datos11_352fin, coords = c("lon", "lat"), crs = 4326)

#datos11_352fin_vecinter <- st_intersection(datos11_352fin_vec,cortar)

#dir.create('./capas', recursive = TRUE)
#Exportar como shapefile
#st_write(datos11_352fin_vecinter, "./capas/ReporteCamaroneros2010.shp")


#datos11_35$`Fecha y Hora` <- as.Date(as.character(datos11_35$`Fecha y Hora`), format="%d-%m-%y  %H:%M"))
#datos11_35$`Fecha y Hora` <- gsub("/","-", datos11_35$`Fecha y Hora`)
#parse_date_time(datos11_35$`Fecha y Hora`, orders="dmy HM")
#m <- month(datos11_35$`Fecha y Hora`)

write.csv(datos11_352fin, file="ReporteCamaroneros2010.csv")#Guarda el CSV




