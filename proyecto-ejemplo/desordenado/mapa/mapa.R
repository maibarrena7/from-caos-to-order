# mapa para la nota
# ultima version!!! usar esta

setwd("C:/Users/usuario/Desktop/nota plantas/mapa")
install.packages("ggplot2")
install.packages("readxl")
library(ggplot2)
library(readxl)

sitios <- read_excel("sitios_muestreo_2.xlsx")
sitios

ggplot(sitios, aes(x = long, y = lat)) +
  geom_point(size = 3, colour = "#2E6F40") +
  geom_text(aes(label = sitio), nudge_y = 0.01) +
  theme_bw()

# ggsave("mapa_final.png")
ggsave("mapa_nota.png", width = 5, height = 4.5)
