# Paus

UNDER DEVELOPMENT

## Usage

### Launch gitreceive + sshd

```bash
$ docker-compose up gitreceive
```

### Register SSH public key

```bash
$ docker-compose run gitreceive-upload-key <username> "$(cat ~/.ssh/id_rsa.pub)"
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
