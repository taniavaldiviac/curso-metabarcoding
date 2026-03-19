# Metabarcoding de comunidades de eucariontes

Repositorio de scripts y recursos para el curso **Metabarcoding de comunidades de eucariontes**, impartido en el Centro de Investigaciones Biológicas del Noroeste (CIBNOR).

El curso cubre el flujo de trabajo completo: control de calidad de secuencias Illumina, remoción de adaptadores con Cutadapt, inferencia de ASVs con DADA2, asignación taxonómica y análisis de diversidad con phyloseq.

Toda la documentación, materiales y guías paso a paso están disponibles en:

**[taniavaldiviac.github.io/metabarcoding-webpage](https://taniavaldiviac.github.io/metabarcoding-webpage)**

---

## Estructura del repositorio

```
metabarcoding-code/
├── raw_fastqs/        # Datos crudos (no modificar)
├── for_dada2/         # FASTQs recortados con Cutadapt
│   └── filtered/      # FASTQs filtrados por DADA2
├── final_data/
│   ├── csv_output/    # Tablas de ASVs y taxonomía
│   ├── rdata_output/  # Checkpoints .RData
│   └── logs/          # sessionInfo, gráficas de calidad
├── metadata/          # primer_data.csv, metadata.csv, bases de datos taxonómicas
└── scripts/           # Scripts numerados en orden de ejecución
```

---

Dra. Tania Valdivia Carrillo — CIBNOR
