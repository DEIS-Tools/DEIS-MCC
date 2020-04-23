# Setup-Guide

First you need to find your AAU-ID.
 + if your email-address was created PRIOR to August 2019, your AAU-ID is your email
 + otherwise you login with your AAU-ID (as normal)

For linux-users, you can replace the `<aau-id>` in the followin text, and append to your `~/.ssh/config`

```
host aaugw
        HostName sshgw.aau.dk
        ForwardAgent yes

host deismcc
        HostName deis-mcc-login1.srv.aau.dk
        User <aau-id>
        ForwardAgent yes

host deismcc_proxy
        HostName deis-mcc-login1.srv.aau.dk
        User <aau-id>
        ProxyJump aaugw
        ForwardAgent yes
```

You should now be able to login to the cluster via the internal network by `ssh deismcc` using your AAU password.
You can also replace `deis-mcc-login2.srv.aau.dk` with its backup `deis-mcc-login1.srv.aau.dk`

## Copy of ssh-key
It is recomended that you copy your ssh-key to the cluster to avoid typing your password more than strictly needed.
If you do not allready have ssh-keys generated, [convinient guides exist online](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

Linux users can conviniently copy the key using the following commands.
```
ssh-add
ssh-copy-id deismcc
```

Otherwise you can use scp or any other tool to place the keys on the cluster in `~/.ssh/`

If you manually copy the keys, make sure to run the following commands (while logged in to the cluster).
```
chmod 600 -R ~/.ssh
```

## Proxy
If you are outside the AAU-network, you can either use VPN to gain access to the AAU-network OR you can do `ssh deismcc_proxy` to go through the `sshgw.aau.dk` tunnel.
If you use the ssh-gateway, you first have to set up [2-factor authentication](https://www.en.its.aau.dk/instructions/Username+and+password/2-factor-authentication/).

You will be met by the following prompt:

```
$ ssh deismcc_proxy
Hello, this is the SSH gateway.
This server uses 2-factor authentication.
Remember to setup your account at https://aka.ms/mfasetup first.
Password: 
```
