# Setup-Guide for MCC3

First you need to find your login-id:
  - If your account was created PRIOR to August 2019, its your email address (eg. pgj@cs.aau.dk/fvejlb17@student.aau.dk), 
  - else you use your AAU-ID (eg. xy99xy@cs.aau.dk/)
  - Remember to include the domain in your user (e.g. foobar@cs.aau.dk)
 

For linux-users, you can replace the `<aau-id>` in the following text, and append to your local `~/.ssh/config`:

```
host aaugw
        HostName sshgw.aau.dk
        User <aau-id>
        ForwardAgent yes

host mcc3
        HostName deis-mcc3-fe01.srv.aau.dk
        User <aau-id>
        ForwardAgent yes

host mcc3_proxy
        HostName deis-mcc3-fe01.srv.aau.dk
        User <aau-id>
        ProxyJump aaugw
        ForwardAgent yes
```

You should now be able to login to the cluster via the internal network by `ssh mcc3` using your AAU password. 
Consider using `ssh-copy-id` described below to login without having to type your password every time.
You can also replace `deis-mcc3-fe01.srv.aau.dk` with its backup `deis-mcc3-fe02.srv.aau.dk`.

### Error when cloning GitHub repo over SSH 
If you get `ssh: connect to host github.com port 22: No route to host` when cloning over SSH, use the following addition to your ssh config located at `/nfs/home/cs.aau.dk/<aau-id>/.ssh/config`:

```
host github.com
    HostName ssh.github.com
    Port 443
```

If you also get `Bad owner or permissions on <path-to-config>`, then remember to set correct permissions. A suggestion follows based on [ssh man_page](http://linuxcommand.org/lc3_man_pages/ssh1.html), but be careful that you are not exposing any private keys:
```sh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
```


## Copy of ssh-key
It is recomended that you copy your ssh-key to the cluster to avoid typing your password more than strictly needed.
If you do not allready have ssh-keys generated, [convenient guides exist online](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

Linux users can conveniently copy the key to the DEIS-MCC machine using the following commands on your local machine.
```
ssh-add
ssh-copy-id mcc3
```

Otherwise you can use scp or any other tool to place the keys on the cluster in `~/.ssh/`

If you manually copy the keys, make sure to run the following commands (while logged in to the cluster) to ensure any private keys stay private.
```
chmod 600 -R ~/.ssh
```

## Proxy
If you are outside the AAU-network, you can either use VPN to gain access to the AAU-network OR you can do `ssh mcc3_proxy` to go through the `sshgw.aau.dk` tunnel. Remember to use the `mcc3_proxy` host-config in the above example.
If you use the ssh-gateway, you need [2-factor authentication](https://www.en.its.aau.dk/instructions/Username+and+password/2-factor-authentication/), which you should already have setup to use other AAU-resources.

You will be met by the following prompt:
```
$ ssh mcc3_proxy
Hello, this is the SSH gateway.
This server uses 2-factor authentication.
Remember to setup your account at https://aka.ms/mfasetup first.
Password: 
```
FIXME: on AAU network, logging into student-account through proxy does not trigger 2FA, just twice use of password?


Linux users setting up from outside the AAU-network, can conveniently copy the ssh-key using the following commands:
```
ssh-add
ssh-copy-id aaugw
ssh-copy-id mcc3_proxy
```
