# Simple, first job
Jobs are managed using `slurm`, a cluster management system. Generally, jobs are executed via either `srun` (for directly running e.g. a binary) or `sbatch` (for running a job script).

See also [the sbatch documentation](https://slurm.schedmd.com/sbatch.html) or [the srun documentation](https://slurm.schedmd.com/srun.html).

## Submitting a Hello World Script with sbatch

To submit a simple job script, you can use the [simple.sh](/example-scripts/simple.sh) as a template, reproduced below.

Put the following into a bash (denoted by .sh extension) somewhere in your home (~), e.g. `~/experiments/hello-world.sh`:
```bash
#!/bin/bash
#SBATCH --job-name=hello_world  # Give your experiment a name
#SBATCH --mail-type=FAIL  # Type of email notification: BEGIN,END,FAIL,ALL,NONE
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --partition=naples,dhabi,rome  # Which partitions may your job be scheduled on
#SBATCH --time=1:00:00  # (Optional) time limit in dd:hh:mm:ss format. Make sure to keep an eye on your jobs (using 'squeue -u $(whoami)') anyways.
#SBATCH --mem=1G  # Memory limit that slurm allocates

# Memory limit for user program. Equals the SBATCH-directive allocation.
#  (allows graceful handling of out-of-memory errors in your program.)
let "m=1024*$SLURM_MEM_PER_NODE"
ulimit -v $m

# Print info to stdout on job details
echo "Job-name: $SLURM_JOB_NAME; jobid: $SLURM_JOB_ID; Partition: $SLURM_JOB_PARTITION; No. Nodes: $SLURM_JOB_NUM_NODES; Node: $SLURM_JOB_NODELIST; Memory per Node: ${SLURM_MEM_PER_NODE}MB; Start-time: $(date); Hostname: $(hostname)"

#######################
# Your code goes below #
#######################
```

To schedule one instance of this job to the cluster; `sbatch ~/experiments/hello-world.sh`. Investigate the resulting output named `slurm-$jobid.out`.

Now you are ready to begin implementing your own experiments by calling the required programs at the bottom of the hello-world example.

During implementation of your first experiment, refer to the remaining documentation [Advanced use](/usage/ADVANCED.md), [Cheatsheet](/usage/CHEAT-SHEET.md).
