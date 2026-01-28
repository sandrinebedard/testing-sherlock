#!/bin/sh
# 
#
path_script=~/codes/testing-sherlock
path_data=${SCRATCH}/k23_data/derivatives
output_path=${SCRATCH}/k23_data/rpreprocessing_2026-01-28
subjects=(sub-CR012)
mkdir -p ${output_path}/sample_size_group_level/

for subject in "${subjects[@]}"; do
    echo "Preprocessing data for subject: $subject"
    export subject path_script path_data SCRATCH
    envsubst '${subject} ${path_script} ${path_data} ${SCRATCH}' < ${path_script}/preprocess.sbatch > preprocess_${subject}.sbatch
    sbatch preprocess_${subject}.sbatch
    rm preprocess_${subject}.sbatch
    sleep 10s
done
