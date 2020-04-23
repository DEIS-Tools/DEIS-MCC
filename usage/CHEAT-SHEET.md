# Common Simple Tasks on DEIS-MCC
Jobs are run through the `slurm` cluster-management software.
Generally jobs a run via either `srun` (for a binary) or `sbatch` (for executing a bash script).

See also [the sbatch documentation](https://slurm.schedmd.com/sbatch.html) or [the srun documentation](https://slurm.schedmd.com/srun.html)

### Interactive Shell
``` bash
srun --partition naples -n1 --mem 1G --pty bash
``` 
will give you a single CPU and 1G of memory.
Use `--exclusive` to 


### Common Options

 - `--mem` allocated memory, supports type-modifiers (e.g. `--mem 15G` for 15 gigabyte)
 - `--exclusive` allocate a entire node, allocates all the memory and cpus
 - `--partition` use a specific partition (should be set to `naples` unless you know what you are doing)
 - `--time` limits the execution-time, use dd:hh:mm:ss format.

See also [the sbatch documentation](https://slurm.schedmd.com/sbatch.html) or [the srun documentation](https://slurm.schedmd.com/srun.html)

### Sbatch
You can set constant values in the top of your scripts for `sbatch` by prepending them to your script as follows:

``` bash
#!/bin/bash
#SBATCH --time=1:05:00
#SBATCH --mail-user=pgj@cs.aau.dk
#SBATCH --mail-type=FAIL
#SBATCH --partition=naples
#SBATCH --mem=15000

echo "hello world"

```
Assume that the previous script is called `helloworld.sh`, executing `sbatch helloworld.sh` will allocate 15G memory on the naples-partition and send `pgj` and email on fail. The job will be forcefully terminated after 1 hour and 5 minutes.


### See running jobs
You can see running jobs with
``` bash
squeue
```
To investigate more details about the job, use
``` bash
scontrol show jobid=$JOBID
```
where `$JOBID` id one of the ID's given by squeue.

### Cancel Job(s)
You cancel a job by running
``` bash
scancel $JOBID
```
Where `$JOBID` is the id given by, e.g. `squeue`

If you want to cancel a range of jobs (say from jobid 100 to 900), you can conviniently do so by this one-liner
``` bash
for i in $(seq 100 900 ) ; do scancel $i ; done
```

You can also cancel all of your jobs by
``` bash
scancel --user=$(whoami)
```

### Measuring time of a process
You can conviniently use `/usr/bin/time` to measure the performance of you binary.
Just prepend the following command to your call

``` bash
/usr/bin/time -f "@@@%e,%M@@@" echo "hello timing"
```
This will output the following.

``` bash
hello timing
@@@0.00,1960@@@
```
which is `@@@` followed by the timing in seconds and memory in kb.

We can dump this result into a file

``` bash
/usr/bin/time -f "@@@%e,%M@@@" echo "hello timing" &> filename
```

You can conviniently pick this up with grep as follows:

``` bash
grep -oP "(?<=@@@).*(?=@@@)" filename
```

which will give you `0.00,1960`
