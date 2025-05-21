# Nodes
These are the available nodes in the MCC cluster (updated 2025/02/20).
To obtain this information, run `sinfo --long --Node --noheader | awk '!seen[$1]++'` on the cluster for the partition dimensions. For CPU and GPU look at `/proc/cpuinfo` or similar tools.
Indices of partition indicate number of available nodes within a partition, e.g. rome partition has seven available nodes.

| Node      	| Cores 	| Sockets:Cores:Threads 	| CPU 			        | GPU 			        | Memory GB  | High speed storage       | OS 				    | Python |
| - 		| - 		| - 				| - 			| - 			    | -		| - 				| - | - |
| dhabi[1-9]   	|  64  		|  8:8:1 			        | AMD Opteron 6376 	    | N/A 			        | 1000 	    | Networked scratch         | Ubuntu 22.04.4 LTS    | 2.7.18, 3.10.12 |
| naples[1-9]  	|  64  		|  8:8:1 			        | AMD EPYC 7551 	    | N/A 			        | 512  	    | Networked scratch         | Ubuntu 22.04.4 LTS    | 3.10.12 |
| rome[1-7]    	|  96  		|  2:48:1   	        | AMD EPYC 7642 	    | N/A 			        | 1024 	   	| Networked scratch         | Ubuntu 22.04.4 LTS    | 3.10.12 | 
| genoa[1-5]    |  64     |  2:32:1             | AMD EPYC 9334         | N/A                   | 1536      | 960GB NVMe PCIe4 x4       | Ubuntu 22.04.4 LTS    | 3.10.12 | 
| turing[1-2]  	|  64  		|  2:16:2 		        | AMD EPYC 7302 	    | 6x Tesla T4 (TU104GL) | 512  	    | Networked scratch         | Ubuntu 22.04.4 LTS    | 3.10.12 |
| vmware[1-4]  	|   1  		|  1:1:1 			        | Intel Xeon E5-2680 v4 | N/A 			        | 1 		| N/A                       | Ubuntu 18.04.5 bionic | N/A | 


## GPU compute

| Node Name  | Driver Version  | CUDA Version       |
|------------|--------------|--------------------|
| `turing01` | 575.51.03 | 12.9 |
| `turing02` | 575.51.03 | 12.9 |
