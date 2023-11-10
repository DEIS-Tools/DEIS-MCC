# Nodes
These are the available nodes in the MCC cluster (updated 25/10/2023).
To obtain this information, run `sinfo --long --Node --noheader | awk '!seen[$1]++'` on the cluster for the partition dimensions. For CPU and GPU look at `/proc/cpuinfo` or similar tools.
Indices of partition indicate number of available nodes within a partition, e.g. rome partition has seven available nodes.

| Node      	| Cores 	| Sockets:Cores:Threads 	| CPU 			| GPU 			| Memory GB 	| OS 				| Python |
| - 		| - 		| - 				| - 			| - 			| -		| - 				| - |
| dhabi[1-9]   	|  64  		|  8:8:1 			| AMD Opteron 6376 	| N/A 			| 1000 		| Ubuntu 18.04.5 bionic 	| 2.7.18, 3.8.6, 3.9.2 |
| naples[1-9]  	|  64  		|  8:8:1 			| AMD EPYC 7551 	| N/A 			| 500  		| Debian oldstable-updates sid 	| 2.7.18, 3.8.6, 3.9.2 |
| rome[1-7]    	|  96  		| 2:48:1 			| AMD EPYC 7642 	| N/A 			| 1000 		| Ubuntu 20.04 focal 		| 2.7.18, 3.8.10 | 
| turing[1-2]  	|  64  		| 2:16:2 			| AMD EPYC 7302 	| 6x Tesla T4 (TU104GL) | 500  		| Ubuntu 20.04 focal 		| 2.7.18, 3.8.10 |
| vmware[1-4]  	|   1  		|  1:1:1 			| Intel Xeon E5-2680 v4 | N/A 			| 1 		| Ubuntu 18.04.5 bionic 	| N/A | 


## GPU compute
The two nodes of the `turing` partition has different driver- and software-stacks as depicted below, this is to accomodate projects which require newer features. 
Note that `turing02` might be unstable due to this newer stack, report any issues and requests to [falke](mailto:falkeboc@cs.aau.dk).

| Node Name  | CUDA Driver  | CUDA Toolkit       |
|------------|--------------|--------------------|
| `turing01` | cuda-driver-450 | cuda-toolkit-11-0    |
| `turing02` | cuda-driver-535 | cuda-toolkit-12.2 |
