Archivos de configuración que el pipeline lee al inicio de cada análisis. El contenido y estructura de estos archivos es fundamental para correr el código del repositorio.

## `primer_data.csv` — Configuración del locus

Define los parámetros del marcador genético. Contiene una fila por cada locus; si el estudio usa más de un marcador (por ejemplo 12S y COI), cada uno tiene su propia fila y se selecciona con el índice `i` al inicio del script.

| Columna | Qué contiene |
|:--------|:-------------|
| `locus_shorthand` | Identificador corto del marcador (ej. `12S`) — se usa para filtrar los archivos FASTQ y nombrar los outputs |
| `seq_f` / `seq_r` | Secuencia completa de los primers forward y reverse |
| `F_qual` / `R_qual` | Longitud del primer usada por Cutadapt para el recorte |
| `amplicon_length` | Longitud esperada del amplicón (bp) |
| `max_trim` | Longitud máxima de truncamiento — evita cortar tanto que se pierda el solapamiento F/R |
| `overlap` | Solapamiento mínimo requerido entre lecturas F y R para el merge |
| `db_name` | Nombre del archivo FASTA de la base de datos taxonómica en `metadata/` |

> **En el script**, el locus a analizar se selecciona con `i <- 1` (primera fila). Si tienes múltiples marcadores, cambia el valor de `i` para procesar el locus correspondiente.

## `metadata.csv` — Información de las muestras

Conecta cada archivo FASTQ con su información ecológica y geográfica. El pipeline lo usa para asignar metadatos al objeto *phyloseq* en la etapa de análisis.

| Columna | Qué contiene |
|:--------|:-------------|
| `sample_id` | Identificador de la muestra — debe coincidir con el nombre del archivo FASTQ |
| `site_id` | Código del sitio de muestreo (ej. `POR`, `BSS`) |
| `name` | Nombre completo del sitio |
| `date` | Fecha de colecta |
| `lat` / `lon` | Coordenadas geográficas |
| `region` | Región geográfica del estudio |
| `locus_shorthand` | Marcador al que corresponde la muestra |
| `sequencing_lane` | Carril de secuenciación (para estudios multi-lane) |
| `replicate` | Número de réplica técnica (1, 2, 3…) |
| `filename_base` | Nombre del archivo tal como lo entrega el secuenciador — se llena manualmente |
| `rename_to` | Nombre generado automáticamente al que se renombrará el archivo para entrar al pipeline (ej. `12S-GC-001-d1_1_S1_L001`) |

## `Fish_speciesGC.csv` — Listado de especies

Listado de especies de peces del Golfo de California con nombre científico y nombre común. Se usa como referencia para validar las asignaciones taxonómicas.
