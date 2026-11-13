# Visitantes florales de *Inventia patagonica*

> ⚠️ **Datos simulados con fines didácticos** (taller *Del caos al orden*). Las especies, los sitios y las personas son ficticios.

## Qué es este proyecto

En marzo de 2023 se muestrearon 38 plantas de *Inventia patagonica* en tres sitios (Loma del Viento, Bajo Fantasma y Pampa Imaginaria). En cada planta se midieron la altura, la cobertura y el número de flores, y se contaron los insectos visitantes de cuatro especies.

El proyecto calcula, para cada especie de visitante:

- **Prevalencia (%)**: plantas con al menos un visitante de la especie / plantas muestreadas × 100.
- **Abundancia media**: número total de visitantes de la especie / plantas muestreadas.

## Estructura

```
visitantes-florales/
├── README.md                    ← este archivo
├── visitantes-florales.Rproj    ← abrir el proyecto desde acá
├── data/
│   ├── raw/                     ← datos originales: NO se modifican nunca
│   │   ├── 2023-03_campo_plantas.xlsx
│   │   └── sitios_muestreo.xlsx
│   └── processed/               ← datos limpios (los genera R/01_limpieza.R)
├── R/
│   ├── 00_correr_todo.R         ← corre los tres scripts en orden
│   ├── 01_limpieza.R            ← raw → processed
│   ├── 02_analisis.R            ← processed → tablas
│   └── 03_figuras.R             ← tablas → figuras
├── docs/
│   ├── diccionario_datos.csv    ← qué significa cada variable
│   └── informe.qmd              ← informe con tablas y figuras
└── outputs/
    ├── tablas/                  ← generadas por los scripts
    └── figuras/                 ← generadas por los scripts
```

Todo lo que está en `data/processed/` y `outputs/` se puede borrar: se vuelve a generar corriendo los scripts.

## Cómo reproducir los resultados

1. Abrir `visitantes-florales.Rproj` en RStudio.
2. Instalar los paquetes (una sola vez):

   ```r
   install.packages(c("tidyverse", "here"))
   ```

3. Correr todo el análisis con un solo archivo:

   ```r
   source("R/00_correr_todo.R")
   ```

   que corre, **en este orden**, `01_limpieza.R` → `02_analisis.R` → `03_figuras.R`. Cada script usa lo que generó el anterior, así que si se corren por separado tiene que ser en ese orden.

4. (Opcional) Renderizar `docs/informe.qmd` para ver el informe completo.

## Datos

- `data/raw/2023-03_campo_plantas.xlsx`: planilla de campo original, tal como se cargó. Tiene sitios escritos de distintas formas, fechas en varios formatos y distintos códigos de dato faltante; todo eso se corrige **con código** en `R/01_limpieza.R`. Las celdas en amarillo indican valores corregidos tras revisar fotografías (ver diccionario).
- `data/raw/sitios_muestreo.xlsx`: coordenadas de los sitios (grados decimales, WGS84).
- El significado de cada variable, sus unidades y códigos está en `docs/diccionario_datos.csv`.

## Autoría y licencia

Material didáctico de Maité A. Barrena (2026), bajo licencia [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/deed.es).
