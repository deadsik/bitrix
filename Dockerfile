FROM centos:latest
MAINTAINER MIRhosting <dev@mirhosting.com>

ENV container docker

RUN yum update -y
RUN yum upgrade -y
RUN yum install wget -y

RUN wget http://repos.1c-bitrix.ru/yum/bitrix-env.sh -O /usr/local/src/bitrix-env.sh
RUN chmod +x /usr/local/src/bitrix-env.sh
RUN /usr/local/src/bitrix-env.sh

COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT /root/start.sh


EXPOSE 21 22 25 53 80 110 143 443 465 3306
