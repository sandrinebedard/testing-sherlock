#!/bin/sh
# 
#
path_script=~/codes/testing-sherlock
PATH_DATA=${SCRATCH}/k23_data/derivatives
output_path=${SCRATCH}/k23_data/preprocessing_2026-01-28
subjects=(sub-CR012)
ses=ses-baselinespinalcord
time_limit=02:00:00
memory=16000

mkdir -p ${output_path}
PATH_DATA_PROCESSED="${output_path}/data_processed"
PATH_RESULTS="${output_path}/results"
PATH_LOG="${output_path}/log"
PATH_QC="${output_path}/qc"
mkdir -p ${PATH_DATA_PROCESSED}
mkdir -p ${PATH_RESULTS}
mkdir -p ${PATH_LOG}
mkdir -p ${PATH_QC}

for subject in "${subjects[@]}"; do
    echo "Preprocessing data for subject: $subject"
    export subject path_script PATH_DATA SCRATCH output_path time_limit memory PATH_DATA PATH_DATA_PROCESSED PATH_RESULTS PATH_LOG PATH_QC ses
    envsubst '${subject} ${path_script} ${PATH_DATA} ${SCRATCH} ${output_path} ${time_limit} ${memory} ${PATH_DATA} ${PATH_DATA_PROCESSED} ${PATH_RESULTS} ${PATH_LOG} ${PATH_QC} ${ses}' < ${path_script}/preprocess.sbatch > preprocess_${subject}.sbatch
    sbatch preprocess_${subject}.sbatch
    rm preprocess_${subject}.sbatch
    sleep 10s
done
