# Setup-Guide

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
You can also replace `deis-mcc-login2.srv.aau.dk` with its backup `deis-mcc-login1.srv.aau.dk`.

## Copy of ssh-key
It is recomended that you copy your ssh-key to the cluster to avoid typing your password more than strictly needed.
If you do not allready have ssh-keys generated, [convenient guides exist online](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

Linux users can conveniently copy the key to the DEIS-MCC machine using the following commands on your local machine.
```
ssh-add
ssh-copy-id deismcc
```

Otherwise you can use scp or any other tool to place the keys on the cluster in `~/.ssh/`

If you manually copy the keys, make sure to run the following commands (while logged in to the cluster) to ensure any private keys stay private.
```
chmod 600 -R ~/.ssh
```

## Proxy
If you are outside the AAU-network, you can either use VPN to gain access to the AAU-network OR you can do `ssh deismcc_proxy` to go through the `sshgw.aau.dk` tunnel. Remember to use the `deismcc_proxy` host-config in the above example.
If you use the ssh-gateway, you need [2-factor authentication](https://www.en.its.aau.dk/instructions/Username+and+password/2-factor-authentication/), which you should already have setup to use other AAU-resources.

You will be met by the following prompt:
```
$ ssh deismcc_proxy
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
ssh-copy-id deismcc_proxy
```
