# Nodes
These are the available nodes in the MCC cluster (updated 2025/02/20).
To obtain this information, run `sinfo --long --Node --noheader | awk '!seen[$1]++'` on the cluster for the partition dimensions. For CPU and GPU look at `/proc/cpuinfo` or similar tools.
Indices of partition indicate number of available nodes within a partition, e.g. rome partition has seven available nodes.

| Node      	| Cores 	| Threads:Cores:Sockets 	| CPU 			        | GPU 			        | Memory GB  | High speed storage       | OS 				    | Python |
| - 		| - 		| - 				| - 			| - 			    | -		| - 				| - | - |
| dhabi[1-9]   	|  64  		|  8:8:1 			        | AMD Opteron 6376 	    | N/A 			        | 1000 	    | Networked scratch         | Ubuntu 22.04.4 LTS    | 2.7.18, 3.10.12 |
| naples[1-9]  	|  64  		|  8:8:1 			        | AMD EPYC 7551 	    | N/A 			        | 500  	    | Networked scratch         | Ubuntu 22.04.4 LTS    | 3.10.12 |
| rome[1-7]    	|  96  		|  2:48:1   	        | AMD EPYC 7642 	    | N/A 			        | 1000 	   	| Networked scratch         | Ubuntu 22.04.4 LTS    | 3.10.12 | 
| turing[1-2]  	|  64  		|  2:16:2 		        | AMD EPYC 7302 	    | 6x Tesla T4 (TU104GL) | 500  	    | Networked scratch         | Ubuntu 22.04.4 LTS    | 3.10.12 |
| genoa[1-5]    |  64     |  2:32:2             | AMD EPYC 9334         | N/A                   | 1536      | 960GB NVMe PCIe4 x4       | Ubuntu 22.04.4 LTS    | 3.10.12 | 
| vmware[1-4]  	|   1  		|  1:1:1 			        | Intel Xeon E5-2680 v4 | N/A 			        | 1 		| N/A                       | Ubuntu 18.04.5 bionic | N/A | 

_Note: Genoa partition is expected to be available at end of Q1 2025._


## GPU compute
The two nodes of the `turing` partition has different driver- and software-stacks as depicted below, this is to accomodate projects which require newer features. 
Note that `turing02` might be unstable due to this newer stack, report any issues and requests to [falke](mailto:falkeboc@cs.aau.dk).

| Node Name  | CUDA Driver  | CUDA Toolkit       |
|------------|--------------|--------------------|
| `turing01` | cuda-driver-450 | cuda-toolkit-11-0    |
| `turing02` | cuda-driver-535 | cuda-toolkit-12.2 |
