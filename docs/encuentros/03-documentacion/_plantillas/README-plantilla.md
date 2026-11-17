# [Título del proyecto]

> Una o dos oraciones: qué estudia este proyecto y qué contiene esta carpeta.

## Autoría y contacto

- [Nombre Apellido] ([correo]) · ORCID: [0000-0000-0000-0000]
- Proyecto / beca / tesis en el marco del cual se generó: [...]

## Descripción

- **Pregunta o objetivo:** [...]
- **Dónde y cuándo se tomaron los datos:** [sitio(s), fechas]
- **Qué se midió:** [variables principales y cómo se midieron]

## Estructura de la carpeta

```
[nombre-del-proyecto]/
├── README.md
├── [nombre].Rproj
├── data/
│   ├── raw/           ← [qué hay acá]
│   └── processed/     ← [qué hay acá, cómo se genera]
├── R/                 ← [scripts y orden en que se corren]
├── outputs/           ← [figuras y tablas, generadas por el código]
└── docs/              ← [diccionario de datos, notas, manuscrito]
```

## Cómo reproducir los resultados

1. Abrir `[nombre].Rproj` en RStudio.
2. Instalar los paquetes (una sola vez): `install.packages(c("...", "..."))`
3. Correr los scripts en este orden: [...]

## Datos

- **Origen:** [quién los tomó, con qué protocolo, permisos de colecta]
- **Diccionario de datos:** `docs/diccionario_datos.csv`
- **Decisiones y correcciones:** [qué se corrigió y por qué; qué dudas quedan]

## Licencia

[Por ejemplo: datos CC BY 4.0, código MIT]
