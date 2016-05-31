# Data structure of Paus

Store in etcd

```
paus
├── sessions
│     └── <session>
├── uri-scheme
└── users
       └── <username>
              ├── apps
              │     └── <appname>
              │             ├── build-args
              │             │     └── <BUILD_ARG>
              │             ├── envs
              │             │     └── <ENV>
              │             └── revisions
              │                    └── <revision>
              └── avater_url
```
