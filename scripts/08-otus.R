# 08-otus.R
# marzo 2026
# Miguel Martinez | marmigues@gmail.com
#
# Script para 
#
# Input: archivo 'uc' de otus obtenidos con vsearch

## \
# En 07-reporte.qmd
# Seccion: Agrupación de ASVs por especie y cálculo de abundancias relativas
# Exportar secuencias como FASTA

# Usando Biostrings
#writeXStringSet(refseq(ps_cal.2), file=file.path(outdir, "ASV.fasta"))

## /

## Paquetes ----

library(dplyr)
library(tidyr)
library(tibble)
library(phyloseq)


## Cargar el objeto ps (rds) ----

rdata_in <- "/Users/migos/Documents/Proyectos/cigom_zoop/G34_ICTLH/analisis_G3/v6/G03_processed_ps_20231205.RData"
load(rdata_in)

# Definir objeto phyloseq inicial
ps.sp <- ps_G03.1
ps.sp

## Cargar resultados de vsearch ----

# https://www.drive5.com/usearch/manual/opt_uc.html
# Field	 	Description
# 1	 	Record type S, H, C or N (see table below).
# 2	 	Cluster number (0-based).
# 3	 	Sequence length (S, N and H) or cluster size (C).
# 4	 	For H records, percent identity with target.
# 5	 	For H records, the strand: + or - for nucleotides, . for proteins.
# 6	 	Not used, parsers should ignore this field. Included for backwards compatibility.
# 7	 	Not used, parsers should ignore this field. Included for backwards compatibility.
# 8	 	Compressed alignment or the symbol '=' (equals sign). The = indicates that the query is 100% identical to the target sequence (field 10).
# 9	 	Label of query sequence (always present). Sequence associated to line
# 10 	Label of target sequence (H records only). oturep of 'query'. '*' means oturep

# Record type:
# H     Hit. For clustering, indicates the cluster assignment for the query.
# S     Centroid or oturep (clustering only).
# C     Cluster record (clustering only).

# Column names
uc_names <- c("Type", "clus_n", "len", "id_pct", "strand", "NA1", "NA2", "aln", "accnum", "centroid")

# Archivo UC
uc_file <- "/Users/migos/Documents/mm_chamba/Cursos_impartidos/CIB_2026_metabarcoding_euks/otus_vsearch/G03_fish_0.97.uc"

# Load
uc.df <- readr::read_tsv(uc_file, id="filename", col_names = uc_names, show_col_types = FALSE) |>
  select(-filename, -NA1, -NA2) |>
  filter(!Type %in% "C") |>
  dplyr::rename(ASV_ID=accnum) |>
  dplyr::relocate(ASV_ID)
head(uc.df); dim(uc.df)
# 1577      8

# Revisar otureps (type = S)
table(uc.df$Type)

# data.frame para identificar otureps
oturep.df <- uc.df |> filter(Type %in% "S") |> select(clus_n, ASV_ID)
# NOTA: la numeracion de los clusters comienza en cero.

# Obtener ID de otureps
oturepID <- oturep.df |> pull(ASV_ID)
length(oturepID)
# 419



## Re-armar objeto ps ----

# Subset del objeto ps
ps.sub <- subset_taxa(ps.sp, taxa_names(ps.sp) %in% oturepID)
ps.sub

# Obtener secuencias
oturep.seq <- refseq(ps.sub)
length(oturep.seq)

# Obtener taxonomia
oturep.tax <- tax_table(ps.sub)
head(oturep.tax)

# Tabla completa de conteos
conteos.ini <- data.frame(otu_table(ps_G03.1), stringsAsFactors = FALSE)
dim(conteos.ini)
conteos.ini[1:3,1:5]

# Formato largo
conteos.ini.long <- conteos.ini |>
  rownames_to_column(var = "SampleID") |>
  pivot_longer(-SampleID, names_to = "ASV_ID", values_to = "conteo")
# Agregar datos de clusters
conteos.ini.long <- left_join(conteos.ini.long, uc.df, by = "ASV_ID")
head(conteos.ini.long)

# Agrupar conteos por muestra y cluster
conteos.sum.long <- conteos.ini.long |> group_by(SampleID, clus_n) |>
  summarise(conteo_cluster = sum(conteo))
head(conteos.sum.long)

# Identificar outrep
conteos.sum.long <- left_join(conteos.sum.long, oturep.df, by="clus_n")
head(conteos.sum.long)

# Formato columnas=ASVs, renglones=muestras
conteos.sum <- conteos.sum.long |>
  select(-clus_n) |>
  pivot_wider(names_from = ASV_ID, values_from = conteo_cluster, values_fill = 0) |>
  column_to_rownames(var = "SampleID")
conteos.sum <- as.matrix(conteos.sum)

# Construir objeto ps
ASV  <- phyloseq::otu_table(conteos.sum, taxa_are_rows = FALSE)
TAXA <- phyloseq::tax_table(oturep.tax)
MD   <- phyloseq::sample_data(ps.sub)
ps.otu <- phyloseq::phyloseq(ASV, TAXA, MD)
ps.otu