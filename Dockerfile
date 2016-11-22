FROM centos:latest
MAINTAINER MIRhosting <dev@mirhosting.com>

ENV container docker

RUN yum update -y
RUN yum upgrade -y
RUN yum install wget -y

COPY install.sh /root/install.sh
RUN chmod +x /root/install.sh
RUN /root/install.sh

COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT /root/start.sh


EXPOSE 21 22 25 53 80 110 143 443 465 3306
