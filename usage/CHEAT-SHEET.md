# Common Simple Tasks on DEIS-MCC
Jobs are run through the `slurm` cluster-management software.
Generally jobs a run via either `srun` (for a binary) or `sbatch` (for executing a bash script) with `sbatch` being the most common way to orchestrate your workloads.

See also [the sbatch documentation](https://slurm.schedmd.com/sbatch.html) or [the srun documentation](https://slurm.schedmd.com/srun.html)

### Interactive Shell
``` bash
srun --partition naples -n1 --mem 1G --pty bash
``` 
will give you a single CPU and 1G of memory in an interactive shell to test out your workload before submitting jobs.


### Common Options

 - `--mem` allocated memory, supports type-modifiers (e.g. `--mem 16G` for 16 gigabytes)
 - `--exclusive` allocate an entire node, allocates all the memory and cpus, be careful when using this option
 - `--partition` use a specific partition (should be set to `naples` unless you know what you are doing)
 - `--time` limits the execution-time, use dd:hh:mm:ss format.

See also [the sbatch documentation](https://slurm.schedmd.com/sbatch.html) or [the srun documentation](https://slurm.schedmd.com/srun.html)

### Sbatch
You can set constant values in the top of your scripts for `sbatch` by prepending them to your script as follows:

``` bash
#!/bin/bash
#SBATCH --time=1:05:00  # (Optional) time limit in dd:hh:mm:ss format. Make sure to keep an eye on your jobs (using 'squeue -u $(whoami)') anyways.
#SBATCH --mail-user=falkeboc@cs.aau.dk
#SBATCH --mail-type=FAIL  # Type of email notification: BEGIN,END,FAIL,ALL,NONE
#SBATCH --output=/nfs/home/cs.aau.dk/<aau-id>/experiments/<experiment>/job-results/%j.out  # %j is your job-id
#SBATCH --error=/nfs/home/cs.aau.dk/<aau-id/experiments/<experiment>/job-results/%j.err
#SBATCH --partition=naples  
#SBATCH --cpus-per-task=16  # number of (real, no HT) cores allocated to job
#SBATCH --mem=32G  # modifiers allowed
##

echo "hello world from ${SLURM_JOB_ID}"

```
Assume that the previous script is called `helloworld.sh`, executing `sbatch helloworld.sh` will allocate 32G memory on the naples-partition and send `falkeboc` an email on fail. The job will be forcefully terminated after 1 hour and 5 minutes. Use double `#` to comment out a Sbatch-comment, when experimenting with Sbatch options.


### See running jobs
You can see all running jobs with
``` bash
squeue
```
To see only your jobs
``` 
squeue -u $(whoami)
``` 

To investigate more details about the job, use
``` bash
scontrol show jobid=$JOBID
```
where `$JOBID` is one of the ID's given by squeue.

### Cancel Job(s)
You cancel a job (not just your own, but any) by running
``` bash
scancel $JOBID
```
Where `$JOBID` is the id given by, e.g. `squeue`.

If you want to cancel a range of jobs (say from jobid 100 to 900), you can conveniently do so by this one-liner
``` bash
scancel {100..900}
```

You can also cancel all of your jobs by
``` bash
scancel --user=$(whoami)
```

### Listing resource usage on a job after completion
Since MCC3, SLURM Accounting has been installed which allows for measuring, among other things, runtime and max memory usage(coming, not present in below example):
```bash
sacct -P -n -a --format JobID,JobName,User,State,Cluster,AllocCPUS,REQMEM,TotalCPU,Elapsed,MaxRSS,ExitCode,NNodes,NTasks -j $job_id
$job_id|cgaal-test|falkeboc@cs.aau.dk|COMPLETED|deismcc3|64|10G|08:11:31|00:08:13||0:0|1|
```

### Measuring time of a process
You can conveniently use `/usr/bin/time` to measure the performance of your binary.
Just prepend the following command to your call

``` bash
/usr/bin/time -f "@@@%e,%M@@@" echo "hello timing"
```
This will output the following:

``` bash
hello timing
@@@0.00,1960@@@
```
which is `@@@` followed by the timing in seconds and memory in kb.

We can dump this result into a file

``` bash
/usr/bin/time -f "@@@%e,%M@@@" echo "hello timing" &> filename
```

You can conveniently pick this up with grep as follows:

``` bash
grep -oP "(?<=@@@).*(?=@@@)" filename
```

which will give you `0.00,1960`

### Cancel all jobs on hold by failed dependency 
Cancel jobs in state DependencyNeverSatisfied 

```
squeue -u$(whoami) | grep DependencyNeverSatisfied |  squeue -u$(whoami) | grep Never | awk -F" " '{print $1}'  | xargs scancel
```
