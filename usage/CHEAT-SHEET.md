# Common Simple Tasks on DEIS-MCC
Jobs are run through the `slurm` cluster-management software.
Generally jobs a run via either `srun` (for a binary) or `sbatch` (for executing a bash script).

See also [the sbatch documentation](https://slurm.schedmd.com/sbatch.html) or [the srun documentation](https://slurm.schedmd.com/srun.html)

### Interactive Shell
```
srun --partition naples -n1 --mem 1G --pty bash
``` 
will give you a single CPU and 1G of memory.
Use `--exclusive` to 


### Comon Options

 - `--mem` allocated memory, supports type-modifiers (e.g. `--mem 15G` for 15 gigabyte)
 - `--exclusive` allocate a entire node, allocates all the memory and cpus
 - `--partition` use a specific partition (should be set to `naples` unless you know what you are doing)
 - `--time` limits the execution-time, use dd:hh:mm:ss format.

See also [the sbatch documentation](https://slurm.schedmd.com/sbatch.html) or [the srun documentation](https://slurm.schedmd.com/srun.html)

### See running jobs
You can see running jobs with
```
squeue
```
To investigate more details about the job, use
```
scontrol show jobid=$JOBID
```
where `$JOBID` id one of the ID's given by squeue.

### Cancel Job(s)
You cancel a job by running
```
scancel $JOBID
```
Where `$JOBID` is the id given by, e.g. `squeue`

If you want to cancel a range of jobs (say from jobid 100 to 900), you can conviniently do so by this one-liner
```
for i in $(seq 100 900 ) ; do scancel $i ; done
```

You can also cancel all of your jobs by
```
scancel --user=$(whoami)
```


