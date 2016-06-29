# Data structure of Paus

Stored in etcd

```
paus
├── sessions
│     └── <session>
├── uri-scheme
└── users
       └── <username>
              ├── apps
              │     └── <appname>
              │            ├── build-args
              │            │     └── <BUILD_ARG> : <value>
              │            ├── envs
              │            │     └── <ENV> : <value>
              │            └── deployments
              │                   └── <timestamp> : <revision>
              └── avater_url
```
