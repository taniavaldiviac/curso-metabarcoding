#!/bin/bash
# 
# Miguel Martinez-Mercado | marmigues@gmail.com
# marzo 2026
#
# Script para formar OTUs con Vsearch

echo "Fecha inicio: `date`"
echo -e "\n============== PROGRAMAS USADOS ==============\n"
## Activar conda 
source activate metabar
echo -e "\n=== VSEARCH"
which vsearch
vsearch -v

# Parametros
NPROCS=4
F=G03_fish
IN=G03_fish_ASV.fasta

# Directorio de trabajo
WDIR=""
RNADIR=""
OUTDIR=""

# Crear directorio para resultados
mkdir -p $OUTDIR
cd $OUTDIR

# Registro del fasta usado
echo -e "\nMD5SUM de fasta:"
md5sum $RNADIR/$IN

# OTU % cutoff
p=0.97

echo -e "\n============================\n=== Formar $p OTUs"
# --cluster_fast    cluster sequences after sorting by length
# --cluster_smallmem	cluster already sorted sequences (see -usersort)
# --fasta_width		width of FASTA seq lines, 0 for no wrap (80)
# --id				reject if identity lower, accepted values: 0-1.0
# --strand both		cluster using plus or both strands (plus)
# --clusterout_id	add cluster id info to consout and profile files
# --relabel			relabel nonchimeras with this prefix string
# --relabel_keep	keep the old label after the new when relabelling
# --centroids		output representantes en fasta 
# --consout 		output consensos en fasta
# --uc				output format as uclust
# --log				write messages, timing and memory info to file
vsearch --cluster_fast $RNADIR/$IN \
			--fasta_width 0 \
			--id $p \
			--strand both \
			--clusterout_id \
			--centroids ${F}_${p}_oturep.fasta \
			--consout ${F}_${p}_cons.fasta \
			--uc ${F}_${p}.uc \
			--log ${F}_${p}.log \
			--threads $NPROCS
			
echo -e "\n===========================\nTrabajo terminado" && date
exit