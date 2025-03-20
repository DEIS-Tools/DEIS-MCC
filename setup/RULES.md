# House Rules
As the cluster is a shared piece of equipment, please adhere to the following rules.

 - No-blame culture. If you stumble across a problem, report it with [Morten](mailto:mksc@cs.aau.dk) regardless of cause.
 - Cancel jobs that are useless/not producing valuable results ASAP
 - Make space for others!
    - Occupying the entire cluster for an hour/over night is ok
    - Do not allocate the entire cluster for weeks
    - Offload large datasets from your home `~` to your own machine when not needed 
    - If you have multi-node, long-running jobs, clear them with [Morten](mailto:mksc@cs.aau.dk) first.
    - Other people may have tighter deadlines than you
 - Keep an eye on your jobs (daily)
    - Your script may have failed, leading to wasted cpu-time for others
    - Use the `--mail-type=FAIL` directive to get emails on failing jobs
 - Clean up after yourself in `/scratch`
