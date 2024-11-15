#!/bin/bash
#SBATCH --job-name=hello_world  # Give your experiment a name
#SBATCH --mail-type=FAIL  # Type of email notification: BEGIN,END,FAIL,ALL,NONE
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --partition=naples,dhabi,rome  # Which partitions may your job be scheduled on
#SBATCH --time=1:00:00  # (Optional) time limit in dd:hh:mm:ss format. Make sure to keep an eye on your jobs (using 'squeue -u $(whoami)') anyways.
#SBATCH --mem=1G  # Memory limit that slurm allocates

# Memory limit for user program. Must be equal to SBATCH-directive allocation.
#  (allows graceful handling of out-of-memory errors in your program.)
let "m=1024*1024*1"
ulimit -v $m

# Print info to stdout on job details
echo "Job-name: $SLURM_JOB_NAME; jobid: $SLURM_JOB_ID; Partition: $SLURM_JOB_PARTITION; No. Nodes: $SLURM_JOB_NUM_NODES; Node: $SLURM_JOB_NODELIST; Memory per Node: ${SLURM_MEM_PER_NODE}MB; Start-time: $(date); Hostname: $(hostname)"

#######################
# Your code goes below #
#######################