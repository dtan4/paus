# Paus

UNDER DEVELOPMENT

## Usage

### Launch gitreceive + sshd

```bash
$ docker-compose up gitreceive
```

### Register SSH public key

```bash
$ cat ~/.ssh/id_rsa.pub | docker-compose run gitreceive-run upload-key <username>
```

### Write `~/.ssh/config`

```
Host paus
  HostName <hostname_or_ip_of_paus>
  User git
  Port 2222
  IdentityFile ~/.ssh/id_rsa
```

### Add Git remote repository

```bash
$ git remote add paus git@paus:<app_name>
```

### Push!

```bash
$ git push paus master
```
