#!/bin/bash
#SBATCH --mail-type=FAIL  # Type of email notification: BEGIN,END,FAIL,ALL,NONE
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --partition=naples,dhabi,rome  # Which partitions may your job be scheduled on
#SBATCH --time=1:00:00  # (Optional) time limit in dd:hh:mm:ss format. Make sure to keep an eye on your jobs (using 'squeue -u $(whoami)') anyways.
#SBATCH --mem=1G  # Memory limit that slurm allocates

# Memory limit for user program (allows graceful handling of out-of-memory errors in your program.)
let "m=1024*1024*1"
ulimit -v $m

#######################
# Your code goes here #
#######################
