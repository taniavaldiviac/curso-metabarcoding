#!/bin/bash
#
# Miguel Martinez-Mercado | marmigues@gmail.com
# marzo 2026
#
# Script para formar OTUs con Vsearch

echo "Fecha inicio: $(date)"
echo -e "\n============== PROGRAMAS USADOS ==============\n"
echo -e "\n=== VSEARCH"
which vsearch
vsearch -v

# Parametros
NPROCS=2
# OTU % cutoff. Escala 0.00 a 1.00
p=$1

# Directorio de trabajo
WDIR="$HOME/metabarcoding-code/final_data/otus_vsearch"
cd $WDIR || { echo "Error: no existe $WDIR"; exit 1; }

# Input fasta
IN=fish_ASV.fasta
if [ ! -f "$IN" ]; then
  echo "Error: no se encuentra $IN en $WDIR"
  exit 1
fi

# Prefijo de salida
F=otus

echo -e "\nMD5SUM de fasta:"
md5sum $IN

echo -e "\n============================\n=== Formar $p OTUs"
vsearch --cluster_fast $IN \
    --fasta_width 0 \
    --id $p \
    --strand both \
    --clusterout_id \
    --centroids ${F}_${p}_oturep.fasta \
    --uc ${F}_${p}.uc \
    --log ${F}_${p}.log \
    --threads $NPROCS

echo -e "\n===========================\nTrabajo terminado" && date
