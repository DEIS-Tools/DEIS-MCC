# Requirements 
- You are able to navigate a CLI environment
- You have access to a Linux system (WSL on Windows is sufficient)
- Your workload is able to be run from the CLI and you have prepared both the required files and commands to execute it

# Setup-Guide
First you need to find your login id:
  - If your account was created **PRIOR** to August 2019, it's your AAU email address (eg. falkeboc@cs.aau.dk or fvejlb17@student.aau.dk), 
  - Otherwise you use your AAU-ID (eg. ab12cd@cs.aau.dk/). Keep in mind that this AAU-ID is [personal](https://www.en.its.aau.dk/instructions/aau-account).
  - Remember to include the domain in your user (e.g. <aau-id>@student.aau.dk or <aau-id>@cs.aau.dk)
 

You replace the `<aau-id>` in the following block, and append to your `~/.ssh/config`:

```
host aaugw
        HostName sshgw.aau.dk
        User <aau-id>
        ForwardAgent yes

host mcc
        HostName deis-mcc3-fe01.srv.aau.dk
        User <aau-id>
        ForwardAgent yes

host mcc_proxy
        HostName deis-mcc3-fe01.srv.aau.dk
        User <aau-id>
        ProxyJump aaugw
        ForwardAgent yes
```

You should now be able to login to the cluster via the internal network by `ssh mcc` using your AAU password.

In the rare case that the main cluster frontend is down, you can try with replacing `HostName deis-mcc3-fe01.srv.aau.dk` with its backup `HostName deis-mcc3-fe02.srv.aau.dk`.

## Copy of ssh-key
It is recomended that you copy your ssh-key to the cluster to avoid typing your password more than strictly needed.
If you do not allready have ssh-keys generated, [convenient guides exist online](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

In a Linux environment, users can conveniently copy the key using the following commands.
```
ssh-add .ssh/<your-key>
ssh-copy-id mcc
```
### Manual copying of ssh-key
Otherwise you can use scp or any other tool to place the keys on the cluster in `~/.ssh/`

If you manually copy the keys, make sure to run the following commands (while logged in to the cluster) to ensure any private keys stay private.
```
chmod 600 -R ~/.ssh
```

## Proxy
If you are outside the AAU-network, you can either use VPN to gain access to the AAU-network OR you can do `ssh mcc_proxy` to go through the `sshgw.aau.dk` gateway tunnel. Remember to use the `mcc_proxy` host-config in the above example.
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
ssh-copy-id mcc_proxy
```
