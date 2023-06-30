# Nodes
These are the available nodes in the MCC cluster (updated 02/05/2023).
To obtain this information, run `sinfo --long --Node --noheader | awk '!seen[$1]++'` on the cluster for the partition dimensions. For CPU and GPU look at `/proc/cpuinfo` or similar tools.

| Node      	| Cores 	| Sockets:Cores:Threads 	| CPU 			| GPU 			| Memory GB 	| OS 				|
| - 		| - 		| - 				| - 			| - 			| -		| - 				|
| dhabi[1-9]   	|  64  		|  8:8:1 			| AMD Opteron 6376 	| N/A 			| 1000 		| Ubuntu 18.04.5 bionic 	|
| naples[1-9]  	|  64  		|  8:8:1 			| AMD EPYC 7551 	| N/A 			| 500  		| Debian oldstable-updates sid 	| 
| rome[1-9]    	|  96  		| 2:48:1 			| AMD EPYC 7642 	| N/A 			| 1000 		| Ubuntu 20.04 focal 		|
| turing[1-2]  	|  64  		| 2:16:2 			| AMD EPYC 7302 	| 6x Tesla T4 (TU104GL) | 500  		| Ubuntu 20.04 focal 		|
| vmware[1-4]  	|   1  		|  1:1:1 			| Intel Xeon E5-2680 v4 | N/A 			| 1 		| Ubuntu 18.04.5 bionic 	|
