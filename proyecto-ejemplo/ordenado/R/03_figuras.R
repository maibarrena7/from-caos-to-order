# =============================================================================
# 03_figuras.R
# Genera las figuras del trabajo.
#
# Entradas: outputs/tablas/prevalencia_por_sitio.csv   (generado por 02_analisis.R)
#           data/raw/sitios_muestreo.xlsx
# Salidas:  outputs/figuras/fig1_mapa_sitios.png
#           outputs/figuras/fig2_prevalencia.png
# =============================================================================

library(here)
library(readr)
library(readxl)
library(dplyr)
library(ggplot2)

# Paleta del proyecto
verde_oscuro <- "#2E6F40"
verde_medio  <- "#6AA84F"
verde_claro  <- "#CFE8C3"
colores_sitio <- c("Bajo Fantasma"    = verde_oscuro,
                   "Loma del Viento"  = verde_medio,
                   "Pampa Imaginaria" = verde_claro)

# --- Figura 1: sitios de muestreo -------------------------------------------

sitios <- read_excel(here("data", "raw", "sitios_muestreo.xlsx")) |>
  select(sitio, lat, long)

fig1 <- ggplot(sitios, aes(x = long, y = lat)) +
  geom_point(size = 4, colour = verde_oscuro) +
  geom_text(aes(label = sitio), nudge_y = 0.006, size = 3.5) +
  scale_x_continuous(expand = expansion(mult = 0.3)) +
  scale_y_continuous(expand = expansion(mult = 0.15)) +
  coord_quickmap() +
  labs(x = "Longitud", y = "Latitud") +
  theme_minimal()

# Crear la carpeta de salida si no existe
dir.create(here("outputs", "figuras"), recursive = TRUE, showWarnings = FALSE)

ggsave(here("outputs", "figuras", "fig1_mapa_sitios.png"),
       fig1, width = 15, height = 13, units = "cm", dpi = 300, bg = "white")

# --- Figura 2: prevalencia por especie y sitio ------------------------------

entrada <- here("outputs", "tablas", "prevalencia_por_sitio.csv")
if (!file.exists(entrada)) {
  stop("No existe ", entrada, "\nPrimero hay que correr R/01_limpieza.R y R/02_analisis.R")
}

prev_sitio <- read_csv(entrada,
                       show_col_types = FALSE)

fig2 <- ggplot(prev_sitio, aes(x = especie, y = prevalencia, fill = sitio)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.75,
           colour = verde_oscuro) +
  scale_fill_manual(values = colores_sitio) +
  scale_y_continuous(limits = c(0, 100), expand = expansion(mult = c(0, 0.02))) +
  labs(x = NULL, y = "Prevalencia (%)", fill = "Sitio") +
  theme_minimal() +
  theme(axis.text.x = element_text(face = "italic"),
        legend.position = "top")

ggsave(here("outputs", "figuras", "fig2_prevalencia.png"),
       fig2, width = 18, height = 11, units = "cm", dpi = 300, bg = "white")

message("Listo: figuras guardadas en outputs/figuras/")
