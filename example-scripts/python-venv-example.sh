#!/bin/bash
#SBATCH --mail-type=NONE  # Type of email notification: BEGIN,END,FAIL,ALL
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --output=/nfs/home/cs.aau.dk/<YOUR-ACCOUNT-NAME>/slurm-output/python-venv-example-%j.out  # Redirect the output stream to this file (%j is the jobid)
#SBATCH --error=/nfs/home/cs.aau.dk/<YOUR-ACCOUNT-NAME>/slurm-output/python-venv-example-%j.err   # Redirect the error stream to this file (%j is the jobid)
#SBATCH --partition=naples,rome,genoa  # Which partitions may your job be scheduled on
#SBATCH --mem=1G  # Memory limit that slurm allocates
#SBATCH --time=1:00:00  # (Optional) time limit in dd:hh:mm:ss format. Make sure to keep an eye on your jobs (using 'squeue -u $(whoami)') anyway.

# Memory limit for user program
let "m=1024*${SLURM_MEM_PER_NODE}"
ulimit -v $m

U=$(whoami)
PD=$(pwd)
# Create a unique folder for this job execution in your scratch folder. (In case your program writes temporary files.)
SCRATCH_DIR="/scratch/${U}"
JOB_DIR="${SCRATCH_DIR}/${SLURM_JOB_ID}"
# Clean up after yourself, in case any temporary files were written, even if the job is killed prematurely.
cleanup () {
    rm -rf ${JOB_DIR} 2>/dev/null >/dev/null
}
trap cleanup EXIT KILL
mkdir -p ${JOB_DIR}
cd ${JOB_DIR}

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
