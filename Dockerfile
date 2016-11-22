FROM centos:latest
MAINTAINER MIRhosting <dev@mirhosting.com>


ENV container docker

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs

RUN yum install -y \
  openssh-server \
wget

RUN wget http://repos.1c-bitrix.ru/yum/bitrix-env.sh -O /usr/local/src/bitrix-env.sh
RUN chmod +x /usr/local/src/bitrix-env.sh
RUN /usr/local/src/bitrix-env.sh

COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT /root/start.sh


EXPOSE 21 22 25 53 80 110 143 443 465 3306
