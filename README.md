# Paus: Docker Compose PaaS

Bring your app to the cloud easily.

Deploy application by 2 steps:

- Prepare `docker-compose.yml` on the repository
- `git push paus master`

That's all. You don't have to learn the platform-specific file anymore.

## Try on local machine with Vagrant

At first, run `script/bootstrap` :rocket:

```bash
$ script/boostrap
```

### Prepare `.env`

Set environment variables in `.env`.

__MUST:__ `PAUS_GITHUB_CLIENT_ID` and `PAUS_GITHUB_CLIENT_SECRET` are required to launch Paus.
Create new OAuth application from [here](https://github.com/settings/applications/new), then write Client ID and Client Secret in `.env`
For Vagrant, callback URL should be "http://paus.dev/oauth/callback".

### Launch Paus

3 CoreOS machines are launched.

``` bash
$ vagrant up
$ vagrant dns --install
$ vagrant dns --start
```

### Sign up

Access to http://paus.dev and sign up with your GitHub account.

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
$ cd /path/to/your/app
$ git remote add paus git@paus.dev:<username>/<app_name>
```

### Push!

```bash
$ git push paus master
```

### Access to the application

Access to the URL shown the end of deployment.

## Modules

Paus consists of the below modules:

- [__paus-frontend__](https://github.com/dtan4/paus-frontend)
  - Web frontend of Paus
- [__paus-gitreceive__](https://github.com/dtan4/paus-gitreceive)
  - Git server of Paus

## Presentation material
- [Docker Compose PaaS の作り方、そして社内に導入した話 / #yapc8oji // Speaker Deck](https://speakerdeck.com/dtan4/number-yapc8oji) (in Japanese)
  - 2016-07-03 YAP(achimon)C::Asia Hachioji 2016 mid in Shinagawa
