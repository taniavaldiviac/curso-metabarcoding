# Metabarcoding de comunidades de eucariontes

### Guía para el uso del repositorio metabarcoding-code

Este repositorio contiene los scripts, datos y recursos para el curso de metabarcoding. Sigue estos pasos para reproducir el análisis en el servidor.

---

## Pasos para comenzar

### 1. Conéctate al servidor vía VPN + SSH

Primero activa la VPN (Hillstone Secure Connect):
- Servidor: `200.23.161.197`, puerto `4666`
- Usuario: `BIO\tu_usuario`

Luego conéctate por SSH:

```sh
ssh usrXX@200.23.162.240
```

### 2. Clona el repositorio en tu home

```sh
git clone https://github.com/taniavaldiviac/metabarcoding-code.git ~/metabarcoding-code
cd ~/metabarcoding-code
```

### 3. Copia los archivos FASTQ

```sh
cp /home/tvaldivia/metabarcoding-code/raw_fastqs/* ~/metabarcoding-code/raw_fastqs/
```

### 4. Verifica que los paquetes de R están disponibles

Los paquetes necesarios ya están instalados en el servidor. Al abrir R, se cargan automáticamente gracias al archivo `~/.Rprofile`. Puedes verificar:

```r
library(dada2)
library(phyloseq)
library(tidyverse)
```

### 5. Ejecuta los scripts en orden

Los scripts están numerados en `scripts/`:

```
01-conexion-servidor.qmd   — Conexión al servidor
02-qaqc-fastqc.qmd         — Control de calidad con FastQC
02b-cutadapt.sh            — Remoción de adaptadores con Cutadapt
03-dada2-pipeline.R        — Pipeline DADA2 completo
04-base-datos-ncbi.qmd     — Búsqueda de referencias en NCBI
05-base-datos-pcr-virtual.qmd — PCR virtual
06-base-datos-paso3.R      — Construcción de base de datos local
07-reporte.qmd             — Reporte final
```

### 6. Renderiza el reporte Quarto

```sh
quarto render scripts/07-reporte.qmd
```

---

Usa la carpeta `metabarcoding-code` como tu directorio de proyecto.
