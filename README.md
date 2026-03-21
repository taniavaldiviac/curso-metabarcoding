# Metabarcoding de comunidades de eucariontes

Repositorio de scripts y recursos para el curso **Metabarcoding de comunidades de eucariontes**, impartido en el Centro de Investigaciones Biológicas del Noroeste (CIBNOR).

El curso cubre el flujo de trabajo completo: control de calidad de secuencias Illumina, remoción de adaptadores con Cutadapt, inferencia de ASVs con DADA2, asignación taxonómica y análisis de diversidad con phyloseq.

Toda la documentación, materiales y guías paso a paso están disponibles en:

**[taniavaldiviac.github.io/metabarcoding-webpage](https://taniavaldiviac.github.io/metabarcoding-webpage)**

---

## Estructura del repositorio

```
metabarcoding-code/
├── scripts/           # Scripts numerados en orden de ejecución
├── metadata/          # Archivos de configuración (primers, metadatos, listado de especies)
├── raw_fastqs/        # Datos crudos — se copian durante el curso desde el servidor
├── for_dada2/         # FASTQs recortados con Cutadapt (se genera al correr el pipeline)
├── cutadapt_reports/  # Reportes de Cutadapt (se genera al correr el pipeline)
├── final_data/        # Resultados del análisis (se genera al correr el pipeline)
└── environment.yml    # Definición del ambiente conda para reproducibilidad
```

---

## Primeros pasos

1. Clona el repositorio en el servidor:
   ```sh
   git clone https://github.com/taniavaldiviac/metabarcoding-code.git
   cd ~/metabarcoding-code
   ```

2. Copia los datos crudos desde el directorio del instructor:
   ```sh
   cp /home/tvaldivia/metabarcoding-code-cibnor/raw_fastqs/* ~/metabarcoding-code/raw_fastqs/
   ```

3. Activa el ambiente conda:
   ```sh
   conda activate metabarcoding
   ```

---

Dra. Tania Valdivia Carrillo — CIBNOR
