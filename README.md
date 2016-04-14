# Paus

Docker Compose PaaS

:warning: UNDER DEVELOPMENT :warning:

## Run on Vagrant
### Prepare `.env`

Set environment variables via `.env`.

``` bash
$ script/boostrap
$ cat coreos/.env
TIMEZONE=Asia/Tokyo
DOCKER_COMPOSE_VERSION=1.6.0
PAUS_BASE_DOMAIN=
PAUS_URI_SCHEME=http

#
# Quay.io
#
DOCKER_QUAY_AUTH=

#
# Private Docker Registry
#
REGISTRY_AWS_ACCESS_KEY_ID=
REGISTRY_AWS_SECRET_ACCESS_KEY=
REGISTRY_AWS_REGION=
REGISTRY_S3_BUCKET=
```

### Launch VMs

3 CoreOS VMs are launched.

``` bash
$ cd coreos
$ vagrant up
```

### Upload SSH public key

Access to http://172.17.8.101:8080 and upload your username and SSH public key.

### Write `~/.ssh/config`

```
Host paus
  HostName 172.17.8.101
  User git
  Port 2222
  IdentityFile ~/.ssh/id_rsa
  StrictHostKeyChecking no
```

### Add Git remote repository

```bash
$ git remote add paus git@paus:<app_name>
```

### Push!

```bash
$ git push paus master
```
