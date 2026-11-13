# 03_figuras.R -----------------------------------------------------------------
# Genera las figuras del trabajo.
#
# Entradas: outputs/tablas/prevalencia_por_sitio.csv   (generado por 02_analisis.R)
#           data/raw/sitios_muestreo.xlsx
# Salidas:  outputs/figuras/fig1_mapa_sitios.png
#           outputs/figuras/fig2_prevalencia.png


# 1. Paleta del proyecto -------------------------------------------------------

verde_oscuro <- "#2E6F40"
verde_medio  <- "#6AA84F"
verde_claro  <- "#CFE8C3"
colores_sitio <- c("Bajo Fantasma"    = verde_oscuro,
                   "Loma del Viento"  = verde_medio,
                   "Pampa Imaginaria" = verde_claro)

# Crear la carpeta de salida si no existe
dir.create(here::here("outputs", "figuras"), recursive = TRUE, showWarnings = FALSE)


# 2. Figura 1: sitios de muestreo ----------------------------------------------

sitios <- readxl::read_excel(here::here("data", "raw", "sitios_muestreo.xlsx")) |>
  dplyr::select(sitio, lat, long)

fig1 <- ggplot2::ggplot(sitios, ggplot2::aes(x = long, y = lat)) +
  ggplot2::geom_point(size = 4, colour = verde_oscuro) +
  ggplot2::geom_text(ggplot2::aes(label = sitio), nudge_y = 0.006, size = 3.5) +
  ggplot2::scale_x_continuous(expand = ggplot2::expansion(mult = 0.3)) +
  ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = 0.15)) +
  ggplot2::coord_quickmap() +
  ggplot2::labs(x = "Longitud", y = "Latitud") +
  ggplot2::theme_minimal()

ggplot2::ggsave(here::here("outputs", "figuras", "fig1_mapa_sitios.png"),
                fig1, width = 15, height = 13, units = "cm", dpi = 300, bg = "white")


# 3. Figura 2: prevalencia por especie y sitio ---------------------------------

entrada <- here::here("outputs", "tablas", "prevalencia_por_sitio.csv")
if (!file.exists(entrada)) {
  stop("No existe ", entrada, "\nPrimero hay que correr R/01_limpieza.R y R/02_analisis.R")
}

prev_sitio <- readr::read_csv(entrada, show_col_types = FALSE)

fig2 <- ggplot2::ggplot(prev_sitio,
                        ggplot2::aes(x = especie, y = prevalencia, fill = sitio)) +
  ggplot2::geom_col(position = ggplot2::position_dodge(width = 0.8), width = 0.75,
                    colour = verde_oscuro) +
  ggplot2::scale_fill_manual(values = colores_sitio) +
  ggplot2::scale_y_continuous(limits = c(0, 100),
                              expand = ggplot2::expansion(mult = c(0, 0.02))) +
  ggplot2::labs(x = NULL, y = "Prevalencia (%)", fill = "Sitio") +
  ggplot2::theme_minimal() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(face = "italic"),
                 legend.position = "top")

ggplot2::ggsave(here::here("outputs", "figuras", "fig2_prevalencia.png"),
                fig2, width = 18, height = 11, units = "cm", dpi = 300, bg = "white")

message("Listo: figuras guardadas en outputs/figuras/")
