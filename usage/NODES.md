# Nodes
These are the available nodes in the MCC cluster (updated 2026/03/19).
To obtain this information, run `sinfo --long --Node --noheader | awk '!seen[$1]++'` on the cluster for the partition dimensions. For CPU and GPU look at `/proc/cpuinfo` or similar tools.
Indices of partition indicate number of available nodes within a partition, e.g. rome partition has seven available nodes.

| Node      	  | Cores 	| Sockets:CoresThreads	| CPU 			            | GPU 			            | Memory GB | OS 			              | Python  | High speed storage   | 
| - 	          | - 		  | - 			              | - 			              | - 	      		        | -		      | - 				            | -       | -                    |
| dhabi[01-08]  |  64  		|  8:8:1 			          | AMD Opteron 6376 	    | N/A 			            | 1000 	    | Ubuntu 22.04.5 LTS    | 3.10.12 | Networked scratch    |
| naples[01-09] |  64  		|  8:8:1 			          | AMD EPYC 7551 	      | N/A 			            | 512  	    | Ubuntu 22.04.5 LTS    | 3.10.12 | Networked scratch    |
| rome[01-07]   |  96  		|  2:48:1   	          | AMD EPYC 7642 	      | N/A 			            | 1024 	   	| Ubuntu 22.04.5 LTS    | 3.10.12 | Networked scratch    |
| genoa[01-05]  |  64     |  2:32:1               | AMD EPYC 9334         | N/A                   | 1536      | Ubuntu 22.04.5 LTS    | 3.10.12 | 960GB NVMe PCIe4 x4  |
| turin[01-05]  |  32     |  2:16:1               | AMD EPYC 9135         | N/A                   | 768       | Ubuntu 22.04.5 LTS    | 3.10.12 | 960GB NVMe x2        |
| turing[01-02] |  64  		|  2:16:2 		          | AMD EPYC 7302 	      | 6x Tesla T4 (TU104GL) | 512  	    | Ubuntu 22.04.4 LTS    | 3.10.12 | Networked scratch    |
| ada[01-02]    |  128  	|  2:32:2 		          | AMD EPYC 9334 	      | 2x NVIDIA L4          | 1536      | Ubuntu 22.04.5 LTS    | 3.10.12 | Networked scratch    |
| vmware[01-04] |  1  		|  1:1:1 			          | Intel Xeon E5-2680 v4 | N/A 			            | 1         | Ubuntu 22.04.5 LTS    | 3.10.12 | N/A                  |


## GPU compute

| Node Name       | Driver Version | CUDA Version |
|-----------------|----------------|--------------|
| `turing[01-02]` | 595.45.04      | 13.2         |
| `ada[01-02]`    | 595.45.04      | 13.2         |
