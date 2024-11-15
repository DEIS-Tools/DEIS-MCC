# Singularity
Singularity (v4.2.0-jammy) is a container platform specifically designed for High-Performance Computing (HPC) environments. It enables users to run containers rootlessly.
With a few caveats, you can use Singularity as you would Docker.

__IMPORTANT CAVEAT__: Note that the fakeroot functionality is missing currently (05/09/24). Find workarounds below under Troubleshooting.

## Basic usage
Singularity is not installed on the login-nodes to avoid blocking actions, so to interact with Singularity you can start an interactive shell on a compute node: `srun --pty bash`.

```sh
singularity shell library://ubuntu:latest # runs container and drops into interactive shell

singularity run library://ubuntu:latest # executes default run command

singularity exec library://ubuntu:latest echo "Hello MCC!" # runs container and executes command 'echo "Hello MCC!"'

singularity pull library://ubuntu:latest # pulls latest version of container and converts into .sif image for local use

singularity build ubuntu.img library://ubuntu:latest # creates Singularity image from latest library container version
```

### Docker?
Singularity supports Docker images, replace `library` with `docker` as the source of the image.

#### Limitations
- Docker networking options like `--network` and `--link` are not supported, due to disallowing priviledged access to host's network stack. 
- No root in containers, just as in native Slurm.

[Official Sylabs Docker docs](https://docs.sylabs.io/guides/2.6/user-guide/singularity_and_docker.html)


## Definition files
Similar in function to docker-compose files are Singularity's definition (`.def`) files.
Use these to describe the setup and creation of Singularity images in a reproducible way.

Below is an [official example](https://docs.sylabs.io/guides/latest/user-guide/definition_files.html) of a def-file that uses all available definition-sections. 
```sh
Bootstrap: library
From: ubuntu:22.04
Stage: build

%setup
    touch /file1
    touch ${SINGULARITY_ROOTFS}/file2

%files
    /file1
    /file1 /opt

%environment
    export LISTEN_PORT=54321
    export LC_ALL=C

%post
    apt-get update && apt-get install -y netcat
    NOW=`date`
    echo "export NOW=\"${NOW}\"" >> $SINGULARITY_ENVIRONMENT

%runscript
    echo "Container was created $NOW"
    echo "Arguments received: $*"
    exec echo "$@"

%startscript
    nc -lp $LISTEN_PORT

%test
    grep -q NAME=\"Ubuntu\" /etc/os-release
    if [ $? -eq 0 ]; then
        echo "Container base is Ubuntu as expected."
    else
        echo "Container base is not Ubuntu."
        exit 1
    fi

%labels
    Author myuser@example.com
    Version v0.0.1

%help
    This is a demo container used to illustrate a def file that uses all
    supported sections.
```

On a cluster with fakeroot functionality, build an image from a definition file with this command: `singularity build --fakeroot example.sif example.def`. 

## GPU resources
Use the flag `--nv` (nvidia) for running CUDA applications to have Singularity setup the container environment for GPU enabled applications.

Common images are kept locally in `/nfs/container`.

### TensorFlow interactive example
From the login node, we ask SLURM to run Singularity command with 1 GPU allocated and NVIDIA support.
`srun --gres=gpu:1 singularity exec --nv /ceph/container/tensorflow_24.03-tf2-py3.sif python3 -c ""`

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
