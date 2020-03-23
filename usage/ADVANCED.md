# Advanced Tips

## Local Storage

There is locale storage on each node, mounted on `/scratch`.
As you home-directory is mounted via NFS there are issues with latency in getting frequently-used data.
You may therefore copy such data to `/scratch` to reduce this latency.

However, please create a sub-folder with your username:
```
mkdir -p /scratch/$(whoami)
```
### Garuantees of /scratch
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

## Message Passing Interface
To be completed
