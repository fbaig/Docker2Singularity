# Docker2Singularity
A simple utility to convert local docker image to remote singularity image suitable for running on HPC environments. 

Generally speaking there is a straightforward way to do this if you create and make your docker image available in a repository. In such case, you can pull the docker image and directly convert  it to a singularity using

```
singularity pull docker://repo/image:tag
```

However, this utility is useful when you want to stay offline and directly convert your local docker image to a singularity container.

## Before You Start
- `Local` is where you configure/debug/create your docker image. Most probably this will be your local machine with docker setup.
  - In `docker/Dockerfile`, image can be customized based on requirements e.g. packages and dependencies etc. Please note that the same environment will be available in singularity
- `Remote` is any environment with `singularity` already setup. Usually this will be an HPC head/login node.

## How To Run?
This is a three step process. 
1. `[Local]` Run `d2s_local.sh` to create local docker image tarball
    - [Optional] Customize image name in `config.env`
2. Upload following to `Remote` environment. (Any file transfer utility e.g. `scp` etc.)
    - `config.env`
    - `d2s_image.tar` (locally generated docker image tarball)
    - `d2s_remote.sh`
3. `[Remote]` Run `d2s_remote.sh` to generate singularity image (`d2s_image.sif`)


## What's Next?
Once you successfully create a singularity image, you can launch and get a shell in it using
```
singularity shell d2s_image
```
Alternatively, you can submit a job to HPC with the singularity container by creating the following `sbatch` script

[NOTE] Please change `CMD` to desired command or script to be executed for the job.
```
# Script file name: sbatch_run.sh
#!/bin/bash
#SBATCH --job-name=bone_sim
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=1G
#SBATCH --partition=high
#SBATCH -o %x-%j.out # File to which STDOUT will be written
#SBATCH -e %x-%j.err # File to which STDERR will be written

singularity run d2s_image.sif CMD
```
Then submit the job by 
```
sbatch sbatch_run.sh
```
