#!/bin/bash
#SBATCH --mail-type=NONE  # Type of email notification: BEGIN,END,FAIL,ALL
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --output=/nfs/home/cs.aau.dk/<YOUR-ACCOUNT-NAME>/slurm-output/python-venv-example-%j.out  # Redirect the output stream to this file (%j is the jobid)
#SBATCH --error=/nfs/home/cs.aau.dk/<YOUR-ACCOUNT-NAME>/slurm-output/python-venv-example-%j.err   # Redirect the error stream to this file (%j is the jobid)
#SBATCH --partition=naples,dhabi,rome  # Which partitions may your job be scheduled on
#SBATCH --mem=1G  # Memory limit that slurm allocates
#SBATCH --time=1:00:00  # (Optional) time limit in dd:hh:mm:ss format. Make sure to keep an eye on your jobs (using 'squeue -u $(whoami)') anyways.

# Memory limit for user program
let "m=1024*1024*1"  
ulimit -v $m

U=$(whoami)
PD=$(pwd)
# Create a unique folder for this job execution in your scratch folder.
SCRATCH_DIRECTORY=/scratch/${U}/${SLURM_JOBID}  
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}

# Activate python virtual environment
python3 -m venv venv
source venv/bin/activate

# Copy your project, and install dependencies (must be listed in requirements.txt)
cp -r ${PD}/<YOUR-PYTHON-PROJECT>/* .
python -m pip install -r requirements.txt
###
## NOTE: Installing dependencies for each job invocation may be too expensive in some cases!
## So consider using the same installation folder. And please share an example, if you make it work :)
###

##########################
# Run your python script # 
##########################

# Maybe you need to copy a result file back to ${PD}


# Clean up after yourself
cd /scratch/${U}
[ -d '${SLURM_JOBID}' ] && rm -r '${SLURM_JOBID}'
