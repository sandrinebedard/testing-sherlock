#!/bin/bash 
#
#all commands that start with SBATCH contain commands that are just used by SLURM for scheduling  
#################
#set a job name  
#SBATCH --job-name=${subject}
#################  
#a file for job output, you can check job progress
#SBATCH --output=${subject}.out
#################
# a file for errors from the job
#SBATCH --error=${subject}.err
#################
#time you think you need; default is one hour
#in minutes in this case, hh:mm:ss
#SBATCH --time=${time_limit}
#################
#quality of service; think of it as job priority
#SBATCH --qos=normal
#################
#SBATCH --mem=${memory}
#################

module load biology
module load fsl/6.0.7.10
module load apptainer


apptainer exec $HOME/sct.sif
apptainer shell $HOME/sct_install/sct.sif
sct_run_batch -script ${path_script}/preprocess_data_spinalcord_anat.sh -path-data ${path_data} -output ${output_path} -include $subject -jobs 1


# ret=1
# c=0
# until [  ${ret} = 0 ] || [ ${c} = 5 ]; do
# 	#scp n${n}_iter_${iter}_amp4_randomise_2.3.tar.gz sbedard@anes-nil1000.stanford.edu:/home/sbedard/Projects/Dermatomal_Mapping_R01/data/BIDS/derivatives/sample_size/group_level/n${n}/n${n}_iter_${iter}_amp4_randomise_2.3.tar.gz
# 	scp -r sample_size_${n}_iter_${iter}.gfeat sbedard@anes-nil1000.stanford.edu:/home/sbedard/Projects/Dermatomal_Mapping_R01/data/BIDS/derivatives/sample_size/group_level/run-${run}/n${n}/sample_size_${n}_iter_${iter}.gfeat/
# 	ret=$?
# 	((c++))
# done