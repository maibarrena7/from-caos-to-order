# ANALISIS prevalencia visitantes florales
# M.  - marzo 2024

setwd("C:/Users/usuario/Desktop/nota plantas")
library(readxl)
library(dplyr)
library(ggplot2)

datos <- read_excel("Datos_campo_plantas_COMPLETO.xlsx", skip = 1)
names(datos)

# arreglo a mano los sitios
datos$Sitio[datos$Sitio == "loma del viento"] <- "Loma del Viento"
datos$Sitio[datos$Sitio == "L. del Viento"] <- "Loma del Viento"
datos$Sitio[datos$Sitio == "bajo fantasma"] <- "Bajo Fantasma"
datos$Sitio[datos$Sitio == "P. Imaginaria"] <- "Pampa Imaginaria"

# saco la planta con 999
datos <- datos[-10, ]

datos$`Z. aurea` <- as.numeric(datos$`Z. aurea`)

# prevalencia
prev <- datos %>%
  group_by(Sitio) %>%
  summarise(prev_Za = mean(`Z. aurea` > 0, na.rm = TRUE) * 100,
            abund_Za = mean(`Z. aurea`, na.rm = TRUE))
prev
# copiar a la tabla del word!!

ggplot(prev, aes(Sitio, prev_Za)) + geom_col(fill = "#6AA84F")
ggsave("grafico prevalencia nuevo.png")
