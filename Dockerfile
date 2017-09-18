FROM ubuntu:latest
LABEL maintainer="eshizhan <eshizhan@126.com>"

ENV LANG C.UTF-8

# RUN sed -i 's/archive.ubuntu.com/cn.archive.ubuntu.com/g' /etc/apt/sources.list
RUN apt-get update -y && \
    apt-get -y install openssh-server vim-tiny iproute2 iputils-ping curl netcat-openbsd --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'root:root' | chpasswd

RUN mkdir -p /var/run/sshd
RUN sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

