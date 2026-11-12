# =============================================================================
# prueba-instalacion.R
# Taller "Del caos al orden" — chequeo de la instalación
#
# Cómo usarlo: abrí este archivo en RStudio y tocá el botón "Source"
# (arriba a la derecha del script), o apretá Ctrl + Shift + S (Cmd + Shift + S en Mac).
# =============================================================================

cat("\n========== Chequeo de instalación: Del caos al orden ==========\n\n")

todo_ok <- TRUE

# --- 1. Versión de R ---------------------------------------------------------
version_r <- getRversion()
if (version_r >= "4.1.0") {
  cat("✔ R", as.character(version_r), "instalado.\n")
} else {
  cat("✘ Tenés R", as.character(version_r), ". Necesitás la versión 4.1.0 o más nueva.\n",
      "  Descargá la última desde https://cran.r-project.org\n")
  todo_ok <- FALSE
}

# --- 2. RStudio --------------------------------------------------------------
if (Sys.getenv("RSTUDIO") == "1") {
  cat("✔ Estás usando RStudio.\n")
} else {
  cat("! No parece que estés en RStudio. Abrí este script desde RStudio.\n")
}

# --- 3. Paquetes -------------------------------------------------------------
paquetes <- c("here", "readxl", "readr", "dplyr", "tidyr",
              "stringr", "lubridate", "ggplot2")

faltan <- paquetes[!vapply(paquetes, requireNamespace, logical(1), quietly = TRUE)]

if (length(faltan) == 0) {
  cat("✔ Los", length(paquetes), "paquetes del taller están instalados.\n")
} else {
  cat("✘ Faltan estos paquetes: ", paste(faltan, collapse = ", "), "\n",
      "  Copiá y pegá esto en la CONSOLA y apretá Enter:\n\n",
      '  install.packages(c("', paste(faltan, collapse = '", "'), '"))\n\n', sep = "")
  todo_ok <- FALSE
}

# --- 4. ¿Funciona todo junto? -----------------------------------------------
if (length(faltan) == 0) {
  resultado <- tryCatch({
    suppressPackageStartupMessages({
      library(dplyr)
      library(ggplot2)
    })
    datos <- data.frame(sitio = c("A", "B", "C"), n = c(3, 5, 2)) |>
      mutate(prop = n / sum(n))
    figura <- ggplot(datos, aes(sitio, n)) + geom_col(fill = "#8FCB9B")
    archivo <- tempfile(fileext = ".png")
    ggsave(archivo, figura, width = 4, height = 3, dpi = 72)
    file.exists(archivo)
  }, error = function(e) {
    cat("✘ Hubo un error al probar los paquetes:\n  ", conditionMessage(e), "\n")
    FALSE
  })
  if (isTRUE(resultado)) {
    cat("✔ R puede leer datos, transformarlos y guardar una figura.\n")
  } else {
    todo_ok <- FALSE
  }
}

# --- 5. Resultado -------------------------------------------------------------
cat("\n================================================================\n")
if (todo_ok) {
  cat("🎉 ¡Todo listo para el taller!\n")
  cat("   Falta solo chequear GitHub Desktop (ver la guía, paso 5).\n")
} else {
  cat("Hay algo para resolver (mirá los ✘ de arriba).\n")
  cat("Si no te sale, escribime y lo vemos antes del primer encuentro.\n")
}
cat("================================================================\n\n")
