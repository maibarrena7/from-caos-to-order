# =============================================================================
# 02_analisis.R
# Calcula la prevalencia y la abundancia media de cada especie de visitante
# floral, para el total y por sitio, y resume las características de las plantas.
#
# Entrada:  data/processed/plantas_limpio.csv   (generado por 01_limpieza.R)
# Salidas:  outputs/tablas/tabla1_plantas_por_sitio.csv
#           outputs/tablas/tabla2_prevalencia_total.csv
#           outputs/tablas/prevalencia_por_sitio.csv
#
# Definiciones (ver README):
#   prevalencia (%)   = plantas con al menos un visitante de la especie / plantas muestreadas x 100
#   abundancia media  = n.º total de visitantes de la especie / plantas muestreadas
# =============================================================================

library(here)
library(readr)
library(dplyr)
library(tidyr)

entrada <- here("data", "processed", "plantas_limpio.csv")
if (!file.exists(entrada)) {
  stop("No existe ", entrada, "\nPrimero hay que correr R/01_limpieza.R")
}

plantas <- read_csv(entrada,
                    show_col_types = FALSE)

# Nombres científicos completos para las tablas
especies <- c(
  z_aurea    = "Zumbatrix aurea",
  p_rapida   = "Polinia rapida",
  f_nocturna = "Florivora nocturna",
  m_minima   = "Mieliphila minima"
)

# --- Tabla 1: características de las plantas por sitio ----------------------

tabla1 <- plantas |>
  group_by(sitio) |>
  summarise(
    n_plantas       = n(),
    altura_media_cm = round(mean(altura_cm, na.rm = TRUE), 1),
    flores_media    = round(mean(n_flores, na.rm = TRUE), 1),
    .groups = "drop"
  )

# --- Pasar los conteos a formato largo --------------------------------------
# Una fila por planta y especie: más fácil para resumir y graficar.

visitas <- plantas |>
  select(id_planta, sitio, all_of(names(especies))) |>
  pivot_longer(all_of(names(especies)),
               names_to = "codigo", values_to = "n_visitantes") |>
  mutate(especie = especies[codigo])

# Función que resume prevalencia y abundancia (se usa dos veces)
resumir <- function(datos) {
  datos |>
    summarise(
      n_plantas        = sum(!is.na(n_visitantes)),
      prevalencia      = round(100 * mean(n_visitantes > 0, na.rm = TRUE), 1),
      abundancia_media = round(mean(n_visitantes, na.rm = TRUE), 2),
      .groups = "drop"
    )
}

# --- Tabla 2: prevalencia y abundancia total por especie --------------------

tabla2 <- visitas |>
  group_by(especie) |>
  resumir() |>
  arrange(desc(prevalencia))

# --- Prevalencia por especie y sitio (insumo de la figura) ------------------

prev_sitio <- visitas |>
  group_by(especie, sitio) |>
  resumir()

# --- Guardar ----------------------------------------------------------------

# Crear la carpeta de salida si no existe
dir.create(here("outputs", "tablas"), recursive = TRUE, showWarnings = FALSE)

write_csv(tabla1,     here("outputs", "tablas", "tabla1_plantas_por_sitio.csv"))
write_csv(tabla2,     here("outputs", "tablas", "tabla2_prevalencia_total.csv"))
write_csv(prev_sitio, here("outputs", "tablas", "prevalencia_por_sitio.csv"))

message("Listo: tablas guardadas en outputs/tablas/")
