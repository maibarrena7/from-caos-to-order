# =============================================================================
# 00_correr_todo.R
# Corre todo el análisis en orden: datos crudos -> datos limpios -> tablas -> figuras.
# Para reproducir los resultados desde cero alcanza con correr este archivo.
# =============================================================================

source(here::here("R", "01_limpieza.R"))
source(here::here("R", "02_analisis.R"))
source(here::here("R", "03_figuras.R"))

message("\nTodo listo. Resultados en outputs/tablas/ y outputs/figuras/")
