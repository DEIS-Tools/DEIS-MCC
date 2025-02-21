# Advanced Tips

## Local Storage

There is local storage on each node, mounted on `/scratch`.
As you home-directory is mounted via NFS there are issues with latency in getting frequently-used data. Some workflows which heavily use I/O from your home may crash your and others experiments, please report these issues to [falkeboc@cs.aau.dk](mailto:falkeboc@cs.aau.dk).
You may therefore copy such data to `/scratch` to reduce this latency.

However, please create a sub-folder with your username:
```
mkdir -p /scratch/$(whoami)
```
### Guarantees of /scratch
`scratch` is ~60GB large and shared among all users.
Data is not garuanteed to be retained between jobs and data can be deleted at any time when the cluster is idle or rebooted.

## Ulimit
Jobs on the cluster will be forcefully terminated if they exceed their memory-limit.
You can manually specify a memory-limit with `ulimit` (in your sbatch-script) that will have a more gracefull handling of this.

```
#Allowed memory in kB
MEM="15000000"
ulimit -v $MEM
```
Notice that `slurm` still picks up a signal that some memory-limit was violated (even the `ulimit` specified), which leads to a slurm `OUT_OF_MEMORY`-error, even when the process terminates successfully (i.e. with a gracefull handling of `malloc` return `NULL` or catching `std::bad_alloc` in c++).

## SLURM accounting
Since MCC3, we have SLURM accounting plugin enabled which gathers job information during and keeps this data for a retention period of 7 days.

Use `sacct --starttime=$(date -d "1 week ago" +'%F')` to get information on jobs executed in the past week.
```sh 
<user>@deis-mcc3-fe01:~/slurm$ sacct
JobID           JobName  Partition    Account  AllocCPUS      State ExitCode 
------------ ---------- ---------- ---------- ---------- ---------- -------- 
468525             bash     naples                    64 CANCELLED+      0:0 
468529             bash      dhabi                    64  COMPLETED      0:0 
468530             bash     naples                    64  COMPLETED      0:0 
468531             bash       rome                    96  COMPLETED      0:0 
468532             bash     turing                    64  COMPLETED      0:0
475953       cgaal-test      dhabi                    64  COMPLETED      0:0 
475953.batch      batch                               64  COMPLETED      0:0 
475954       cgaal-test      dhabi                    64    RUNNING      0:0 
475954.batch      batch                               64    RUNNING      0:0
```

To drill into available information Adding option `-j <job_id>` and `-l` for long will give you all available information; avg and max memory consumption, CPU frequency, and system/user wall time spent during job execution.

Users might be interested in figuring out CPU efficiency; how much CPU time does my workload use compared to available CPU time?
Calculate this based on the `TotalCPU` and `CPUTimeRAW` values you get, correcting for number of cores.

In future we should get community tooling `seff` which handles convertions and corrections.

### Pitfalls
SLURM accounting is sampling your job at intervals, which means:
- If your job was killed due to OOM yet `sacct` reports a lower, max memory consumption than limit, then your job **did** consume more memory than allocated just briefly before being killed
- Time reported to SLURM may be unreliable, use your own judgement when validating your CPU time results

## Message Passing Interface
To be completed
