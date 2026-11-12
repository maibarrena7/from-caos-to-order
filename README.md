# Del caos al orden: organización de proyectos de investigación en R

*From Messy Folders to Reproducible Research: Organising Research Projects in R*

Materiales del taller **Del caos al orden**, dictado en la Facultad de Ciencias Marinas de la Universidad Nacional del Comahue (San Antonio Oeste, Argentina) en diciembre de 2026.

> **English summary.** Teaching materials (in Spanish) for a six-session, in-person workshop on organising, documenting and version-controlling research projects in R. Developed as part of the instructor certification of the [LMU Open Science Center](https://www.osc.uni-muenchen.de) Open Science Summer School 2026. Licensed under CC BY-SA 4.0.

🌐 **Sitio del taller:** <https://maibarrena7.github.io/from-caos-to-order/>

## Contenido

| Carpeta | Qué hay |
|:--|:--|
| `index.qmd`, `instalacion/`, `checklist/` | Páginas del sitio web |
| `encuentros/` | Las seis sesiones: guía (`index.qmd`), diapositivas (`slides.qmd`) y materiales para descargar |
| `proyecto-ejemplo/desordenado/` | Proyecto de investigación ficticio, desordenado a propósito (punto de partida) |
| `proyecto-ejemplo/ordenado/` | El mismo proyecto organizado, documentado y reproducible (referencia) |
| `assets/`, `custom.scss` | Estilos del sitio y de las diapositivas |

⚠️ Todos los datos, especies, sitios y personas del proyecto de ejemplo son **ficticios** (datos simulados con fines didácticos).

## Programa

| Semana | Encuentro | Tema |
|:--:|:--:|:--|
| 1 | 1 | Del desorden a una estructura de proyecto |
| 1 | 2 | Datos, scripts y resultados en R |
| 2 | 3 | Documentar para comprender y reutilizar |
| 2 | 4 | De los datos originales a los resultados |
| 3 | 5 | Introducción a Git y GitHub |
| 3 | 6 | Integración y revisión del proyecto |

## Cómo construir el sitio

Requiere [R](https://cran.r-project.org), [RStudio](https://posit.co/download/rstudio-desktop/) y [Quarto](https://quarto.org).

1. Abrir `from-caos-to-order.Rproj`.
2. **Build → Render Website** (o `quarto render` en la terminal). El sitio se genera en `_site/`.

## Cómo citar

Barrena, M. A. (2026). *Del caos al orden: organización de proyectos de investigación en R* [Material didáctico]. https://github.com/maibarrena7/from-caos-to-order

## Agradecimientos

Diseñado en el marco del *Open Science Summer School 2026* del LMU Open Science Center (Ludwig-Maximilians-Universität München). Parte de los materiales se basan en recursos del LMU Open Science Center (CC BY-SA 4.0), citados en cada diapositiva y página donde se usan.

## Licencia

Los materiales se distribuyen bajo licencia [Creative Commons Atribución-CompartirIgual 4.0 Internacional (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/deed.es). Ver `LICENSE.md`.
