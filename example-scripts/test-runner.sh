#!/bin/bash
#SBATCH --mail-type=NONE  # Type of email notification: BEGIN,END,FAIL,ALL
#SBATCH --mail-user=<YOUR-EMAIL>
#SBATCH --output=/nfs/home/cs.aau.dk/<YOUR-ACCOUNT-NAME>/slurm-output/test-runner-%A_%a.out  # Redirect the output stream to this file (%A_%a is the job's array-id and index)
#SBATCH --error=/nfs/home/cs.aau.dk/<YOUR-ACCOUNT-NAME>/slurm-output/test-runner-%A_%a.err   # Redirect the error stream to this file (%A_%a is the job's array-id and index)
#SBATCH --partition=naples,dhabi,rome  # If you need run-times to be consistent across tests, you may need to restrict to one partition.
#SBATCH --mem=1G  # Memory limit that slurm allocates

###
## This script is designed to be executed as several parallel runners. 
## For example to start 20 runners use:
## sbatch --array=1-20 ./test-runner.sh <arguments> <to> <the> <script>
## If you have a large number of fast-running test instances, running e.g. 10000 jobs that each just runs a single test instance, may overload the scheduler.
## This template lets you use only a few 'runner' jobs that goes through all available instances.
###

# Memory limit for user program
let "m=1024*1024*1"
ulimit -v $m

U=$(whoami)
PD=$(pwd)
# Create a unique folder for this job execution in your scratch folder. (In case your program writes temporary files.)
SCRATCH_DIRECTORY=/scratch/${U}/${SLURM_JOBID}  
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}

# With noclobber set, 'echo "" > myfile' will not overwrite myfile if it exists. We use this to aquire locks on specific test instances.
set -o noclobber

# TODO: Get the arguments you need. 
BIN="${PD}/bin/$1"
INSTANCE_FOLDER="${PD}/$2"
RESULT_FOLDER="${PD}/$3"
TIMEOUT="$4"

mkdir -p ${RESULT_FOLDER}
EXIT_CODE=0

###
## If your program uses large or latency critical files, consider copying them here (/scratch is node-local, whereas your home-directory is networked).
## cp ${PD}/your-large-dependency .
###

# Go through all test instances in INSTANCE_FOLDER. 
# Several identical runners of this script can do this in parallel. 
for INSTANCE in $(ls "${INSTANCE_FOLDER}") ; do
    # TODO: Adapt this to your file structure
    RESULT_FILE="${RESULT_FOLDER}/$INSTANCE"

    # Aquire lock on this test execution here.
    echo "" > "${RESULT_FILE}"
    if [ "$?" -eq "0" ]; then
        # TODO: Your test execution command. Adapt this to your needs and parameters.
        MYCMD="${BIN} --instance ${INSTANCE_FOLDER}/${INSTANCE} ${@:5}"
        # Here we direct the output to RESULT_FILE, add a timeout, and log the time and memory consumption.
        CMD="timeout ${TIMEOUT} /usr/bin/time -f \"@@@%e,%M@@@\" ${MYCMD} >> ${RESULT_FILE}"
        echo "${CMD}"  # Log command to slurm output file.
        eval "${CMD}"  # Run the command

        # We return the last non-zero exit code, if any instance gave an error. 
        RETVAL=$?
        if [ ${RETVAL} -ne 0 ]; then
            EXIT_CODE=${RETVAL}
        fi
    fi
done

# Clean up after yourself, in case any temporary files were written.
cd /scratch/${U}
[ -d '${SLURM_JOBID}' ] && rm -r '${SLURM_JOBID}'

exit ${EXIT_CODE}
