#!/bin/bash

## 
## Author: Morten K. Schou
## Date: Spring 2021
## Provided as is. No warranty. Feel free to use, copy, modify etc., but at your own risk. 
## 

NEXT_JOBS_STACK[0]=""
LAST_JOBS_STACK[0]=""
DEPENDENCY_TYPE="afterany"

run_impl () {
    if [ $1 -eq 1 ] ; then
        local CMD="sbatch --parsable ${@:2}"
    else
        local CMD="sbatch --parsable --array=1-$1 ${@:2}"
    fi
    echo "$CMD"
    local jobid=$($CMD) && NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-1]="${NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-1]}:$jobid" && echo "Scheduled job: $jobid"
}

run () {
    if [ -z "${LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}-1]}" ] ; then
        run_impl 1 "$@"
    else
        run_impl 1 --dependency=${DEPENDENCY_TYPE}${LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}-1]} "$@"
    fi
}
run_many () {
    if [ -z "${LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}-1]}" ] ; then
        run_impl "$@"
    else
        run_impl $1 --dependency=${DEPENDENCY_TYPE}${LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}-1]} "${@:2}"
    fi
}
next () {
    LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}-1]="${NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-1]}"
    NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-1]=""
    DEPENDENCY_TYPE="afterany"
    if [ -n "$1" ] ; then
        eval "$@"
    fi
}

begin_step () {
    LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}]=${LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}-1]}
    NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}]=""
}
end_step () {
    NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-2]="${NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-2]}${NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-1]}"
    unset NEXT_JOBS_STACK[${#NEXT_JOBS_STACK[*]}-1]
    unset LAST_JOBS_STACK[${#LAST_JOBS_STACK[*]}-1]
}

if_ok () {
    DEPENDENCY_TYPE="afterok"
    if [ -n "$1" ] ; then
        eval "$@"
    fi
    DEPENDENCY_TYPE="afterany" # Reset to default
}

if_not_ok () {
    DEPENDENCY_TYPE="afternotok"
    if [ -n "$1" ] ; then
        eval "$@"
    fi
    DEPENDENCY_TYPE="afterany" # Reset to default
}

# This last one is not thoroughly tested, but it shows how to use begin_step and end_step in a for-loop.
iterate () {
    local i
    for i in $2 ; do begin_step
        eval "$1=$i ${@:3}"
    end_step ; done
}
