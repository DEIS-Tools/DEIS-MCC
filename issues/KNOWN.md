# GitHub

## Error when cloning GitHub repo over SSH 
If you get `ssh: connect to host github.com port 22: No route to host` when cloning over SSH, use the following addition to your ssh config located at `/nfs/home/cs.aau.dk/<aau-id>/.ssh/config`:

```
host github.com
    HostName ssh.github.com
    Port 443
```

If you also get `Bad owner or permissions on <path-to-config>`, then remember to set correct permissions. A suggestion follows based on [ssh man_page](http://linuxcommand.org/lc3_man_pages/ssh1.html), but be careful that you are not exposing any of your private keys:
```sh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
```


# Singularity

## Docker Hub limited
Docker Hub limits its downloads, You can avoid the limit by logging in with a username and password using the singularity docker login command:

```sh
singularity remote login --username username docker://docker.io`
Password / Token:
INFO:    Token stored in /nfs/home/cs.aau.dk/<aau-id>/.singularity/remote.yaml
```

# Display servers
Currently (16/09/24) e.g. `emacs` gives a graphical interface if you are running an Xserver on your own machine.

Other workloads such as interactive `matplotlib` windows does not seem to function on the standard Ubuntu installation. 

This is not a priority functionality. Offload the results to your own machine for further analysis.