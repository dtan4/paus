FROM ubuntu:14.04
MAINTAINER Daisuke Fujita <dtanshi45@gmail.com> (@dtan4)

ENV GITRECEIVE_COMMIT d152fd28e9dba9fcd0af5366cf188fc89ce8385f

RUN apt-get update && \
    apt-get install -y git openssh-server wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/local/bin/gitreceive https://raw.githubusercontent.com/progrium/gitreceive/$GITRECEIVE_COMMIT/gitreceive && \
    chmod +x /usr/local/bin/gitreceive

RUN mkdir /var/run/sshd
COPY files/sshd_config /etc/ssh/

RUN gitreceive init

VOLUME /home/git
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
