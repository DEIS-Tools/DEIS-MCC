# Singularity
Singularity (v4.1.4-jammy) is a container platform specifically designed for High-Performance Computing (HPC) environments. It enables users to run containers rootlessly.
With a few caveats, you can use Singularity as you would Docker.

## Basic usage
Say we have Rust workload that we would like to run and we do not have the required installed 



## Docker?
Singularity can be used with Docker images.

```sh
singularity shell docker://ubuntu:latest # runs container and drops into interactive shell

singularity run docker://ubuntu:latest # executes default run command

singularity exec docker://ubuntu:latest echo "Hello MCC!" # runs container and executes command 'echo "hello MCC!"'

singularity pull docker://ubuntu:latest # pulls latest version of container and converts into .sif image for local use

singularity build ubuntu.img docker://ubuntu:latest # creates Singularity image from latest docker container version
```

### Limitations
- Docker networking options like `--network` and `--link`are not supported, due to disallowing priviledged access to host's network stack. 
- No root in containers, just as in native Slurm.

[Official Sylabs Docker docs](https://docs.sylabs.io/guides/2.6/user-guide/singularity_and_docker.html)

## GPU resources


## Troubleshooting
### Building an image: No space left on device 
Can also happen when pulling:
```
FATAL:   While making image from oci registry: error fetching image: while building SIF from layers: while creating squashfs: create command failed: exit status 1: Write failed because No space left on device
```

Default building dir is /tmp which may be too small. Use env-var to use another dir, e.g. /scratch on a compute node:
```
SINGULARITY_TMPDIR=/scratch singularity build ...
```
