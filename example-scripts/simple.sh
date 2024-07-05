#!/bin/bash
#SBATCH --mail-type=FAIL  # Type of email notification: BEGIN,END,FAIL,ALL,NONE
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --partition=naples,dhabi,rome  # Which partitions may your job be scheduled on
#SBATCH --time=1:00:00  # (Optional) time limit in dd:hh:mm:ss format. Make sure to keep an eye on your jobs (using 'squeue -u $(whoami)') anyways.
#SBATCH --mem=1G  # Memory limit that slurm allocates

# Memory limit for user program (allows graceful handling of out-of-memory errors in your program.)
let "m=1024*1024*1"
ulimit -v $m


# Create a unique folder for this job execution in your scratch (check docs for more info) folder in case your program writes temporary files.
SCRATCH_DIRECTORY=/scratch/${U}/${SLURM_JOB_ID}  
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}

# setup cleanup to be triggered on killing of job
cleanup () {
        echo 'Cleaning up job'
        rm -rf ${job_dir} 2>/dev/null >/dev/null
        # Clean up after yourself, in case any temporary files were written.
        cd /scratch/${U}
        [ -d "${SLURM_JOB_ID}" ] && rm -r ${SLURM_JOB_ID}
        
        # exit with workload return code, instead of cleanup
        exit ${EXIT_CODE}


}
trap cleanup EXIT KILL


#######################
# Your work goes here #
#######################

# setup environment

# run workload

# copy any results you want to keep, to your home

#######################
# Your work ends here #
#######################