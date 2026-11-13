# 01_limpieza.R ----------------------------------------------------------------
# Lee los datos crudos de campo, los limpia y guarda una versión procesada.
#
# Entrada:  data/raw/2023-03_campo_plantas.xlsx   (NO se modifica nunca)
# Salida:   data/processed/plantas_limpio.csv
#
# Datos simulados con fines didácticos (taller "Del caos al orden").


# 1. Leer los datos crudos ------------------------------------------------------
# - skip = 2: la fila 1 es un título y la fila 2 es el encabezado original,
#   que reemplazamos por nombres sin espacios, tildes ni símbolos.
# - Todo se lee como texto para que R no "adivine" los tipos de columna:
#   los convertimos nosotros, de forma explícita, más abajo.
# - "-", "NA" y "s/d" son las formas en que se anotaron los datos faltantes.

nombres <- c("id_planta", "sitio", "fecha", "altura_cm", "cobertura_m2",
             "n_flores", "z_aurea", "p_rapida", "f_nocturna", "m_minima",
             "observaciones")

crudo <- readxl::read_excel(
  here::here("data", "raw", "2023-03_campo_plantas.xlsx"),
  sheet     = "Hoja1",
  skip      = 2,
  col_names = nombres,
  col_types = "text",
  na        = c("", "-", "NA", "s/d")
)


# 2. Quedarse solo con las filas de plantas ------------------------------------
# Debajo de los datos hay una nota escrita a mano ("amarillo = corregido...").
# Las plantas se identifican con P + número (P01, P02, ...).

plantas <- crudo |>
  dplyr::filter(stringr::str_detect(id_planta, "^P\\d+$"))


# 3. Unificar los nombres de los sitios ----------------------------------------
# El mismo sitio aparece escrito de varias formas
# ("Loma del Viento", "loma del viento", "L. del Viento", ...).

plantas <- plantas |>
  dplyr::mutate(
    sitio = stringr::str_squish(stringr::str_to_lower(sitio)),
    sitio = dplyr::case_when(
      stringr::str_detect(sitio, "^(loma|l\\.)")  ~ "Loma del Viento",
      stringr::str_detect(sitio, "^bajo")         ~ "Bajo Fantasma",
      stringr::str_detect(sitio, "^(pampa|p\\.)") ~ "Pampa Imaginaria",
      .default = NA_character_
    )
  )


# 4. Unificar las fechas -------------------------------------------------------
# Hay cuatro formatos: "12/03/2023", "2023-03-12", "12 marzo" y fechas
# guardadas como fecha de Excel (que al leerlas como texto aparecen como un
# número, por ejemplo "44997").

convertir_fecha <- function(x) {
  numero <- suppressWarnings(as.numeric(x))
  desde_excel <- as.Date(numero, origin = "1899-12-30")

  texto <- stringr::str_replace(x, "^(\\d{1,2}) marzo$", "\\1/03/2023")
  desde_texto <- as.Date(lubridate::parse_date_time(texto,
                                                    orders = c("dmy", "ymd"),
                                                    quiet = TRUE))

  dplyr::coalesce(desde_excel, desde_texto)
}

plantas <- plantas |>
  dplyr::mutate(fecha = convertir_fecha(fecha))


# 5. Convertir a número y tratar valores imposibles ----------------------------
# 999 en la altura es un código de dato faltante (ver docs/diccionario_datos.csv).
# Lo convertimos a NA con código, en lugar de borrar la fila a mano.

plantas <- plantas |>
  dplyr::mutate(
    dplyr::across(c(altura_cm, cobertura_m2, n_flores,
                    z_aurea, p_rapida, f_nocturna, m_minima),
                  as.numeric),
    altura_cm = dplyr::if_else(altura_cm == 999, NA_real_, altura_cm)
  )


# 6. Controles básicos ---------------------------------------------------------
# Si algo de esto falla, el script se detiene y avisa.

stopifnot(
  "Hay IDs de planta repetidos"        = !any(duplicated(plantas$id_planta)),
  "Hay sitios sin identificar"         = !any(is.na(plantas$sitio)),
  "Hay fechas que no se pudieron leer" = !any(is.na(plantas$fecha))
)


# 7. Guardar los datos procesados ----------------------------------------------

# Crear la carpeta de salida si no existe
dir.create(here::here("data", "processed"), recursive = TRUE, showWarnings = FALSE)

readr::write_csv(plantas, here::here("data", "processed", "plantas_limpio.csv"))

message("Listo: ", nrow(plantas), " plantas guardadas en data/processed/plantas_limpio.csv")
