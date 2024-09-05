# Singularity
Singularity (v4.1.4-jammy) is a container platform specifically designed for High-Performance Computing (HPC) environments. It enables users to run containers rootlessly.
With a few caveats, you can use Singularity as you would Docker.

Note that the fakeroot functionality is missing currently (05/09/24). Find workarounds below under Troubleshooting.

## Basic usage




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

### Fakeroot functionality missing
Some Singularity operations might require root-access, which MCC3 users will not be granted. Current workarounds:

- Build the image on your own machine in a local Singularity environment and transfer it to the cluster using Sylabs library or SCP/Rsync
- Use remote building service such as Sylabs. This service is free, quota is 500 minutes per month.

#### Sylabs remote build-server
1. Create an account at https://cloud.sylabs.io/ 
1. Navigate to 'Access Tokens' and create one
1. On the frontend node: `srun singularity remote login`
1. When prompted, paste newly created token
1. Add `--remote` flag to your build commands, e.g. `singularity build --remote demo.sif demo.def`
