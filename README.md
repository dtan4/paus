# Paus

Docker Compose PaaS

## Run on Vagrant
### Prepare `.env`

Set environment variables via `.env`.

``` bash
$ script/boostrap
$ cat .env
TIMEZONE=Asia/Tokyo

DOCKER_COMPOSE_VERSION=1.7.0
DOCKER_SWARM_VERSION=1.2.3

#
# Paus
#
PAUS_BASE_DOMAIN=paus.dev
PAUS_DOCKER_CONFIG_BASE64=
PAUS_MAX_APP_DEPLOY=10
PAUS_SECRET_KEY_BASE=
PAUS_URI_SCHEME=http

#
# Create new OAuth application from the URL below, then set Client ID and Client Secret.
# Callback URL should be "http://$PAUS_BASE_DOMAIN/oauth/callback".
#
#   https://github.com/settings/applications/new
#
PAUS_GITHUB_CLIENT_ID=
PAUS_GITHUB_CLIENT_SECRET=

#
# Quay.io
#
DOCKER_QUAY_AUTH=

#
# Datadog Agent
#
PAUS_DATADOG_ENABLED=0
DATADOG_API_KEY=
```

### Launch Paus cluster

3 CoreOS VMs are launched.

``` bash
$ vagrant up
$ vagrant dns --install
$ vagrant dns --start
```

### Upload SSH public key

Access to http://pausapp.com and sign up with your GitHub account.

### Write `~/.ssh/config`

```
Host paus.dev
  User git
  Port 2222
  IdentityFile ~/.ssh/id_rsa
  StrictHostKeyChecking no
```

### Add Git remote repository

```bash
$ git remote add paus git@paus.dev:<username>/<app_name>
```

### Push!

```bash
$ git push paus master
```

## Modules

Paus consists of the below modules:

- [__paus-frontend__](https://github.com/dtan4/paus-frontend)
  - Web frontend of Paus
- [__paus-gitreceive__](https://github.com/dtan4/paus-gitreceive)
  - Git server of Paus
