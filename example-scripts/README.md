# Example Scripts
`simple.sh` provides a minimal example with the common sbatch settings and memory limit. 

`python-venv-example.sh` shows how to setup a virtual environment for installing python dependencies locally for the job (on /scratch), and cleaning up afterwards.

`test-runner.sh` can be used to have several runner jobs go through a large set of test instances, without overloading the scheduler. This is also useful if your test requires some setup e.g. copying large files to the node, which may take long time compared to executing the test itself.

## Slurm Job Dependencies
You might have an experiment setup, where first you need to generate some random instances, next run tests on those instances, and finally sumarize the results.

This pipeline can be automated using [slurm's dependency feature](https://slurm.schedmd.com/sbatch.html#OPT_dependency). 

The file `slurm-dependencies.sh` provides functions to handle the boiler-plate code involved in scheduling jobs with dependencies.

The following example shows how to schedule a pipeline of interdependent jobs using the functions in the script. 
```bash
#!/bin/bash

# Import the functions
source slurm-dependencies.sh

# Some example settings
TEST_FOLDER="my-tests"
RESULT_FOLDER="my-results"
TIMEOUT="10m"

# Schedule test generation
run generate-tests.sh ${TEST_FOLDER} <other> <parameters>
# Next jobs will be dependent on the test generation completing
next
# We start runners for each tool.
for TOOL in "our-tool" "competitor" ; do begin_step
    # We only run tests, if the generate-tests script finished ok (exit code 0). Start 20 runners
    if_ok run_many 20 test-runner.sh ${TOOL} ${TEST_FOLDER} ${RESULT_FOLDER} ${TIMEOUT}
    # Schedule summarize-results.sh with dependency on all runners finishing (but not checking exit code)
    next run summarize-results.sh ${TOOL} ${RESULT_FOLDER}
end_step ; done # The next step (with the other tool) will not depend on this step, only on generate-tests.sh

# Run final script after all other jobs finish
next run make-comparison.sh 
```

If you use the `if_ok` condition, your jobs may get stuck in the state DependencyNeverSatisfied. Make sure to keep an eye out for this, and `scancel` such jobs. 