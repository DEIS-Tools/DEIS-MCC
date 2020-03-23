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

## Message Passing Interface
To be completed
