FROM centos:6.6

# bitrix
ADD http://repos.1c-bitrix.ru/yum/bitrix-env.sh /tmp/
RUN chmod +x /tmp/bitrix-env.sh
RUN sed -i 's/read version_c/version_c=5/gi' /tmp/bitrix-env.sh
RUN /tmp/bitrix-env.sh

# update + ssh
RUN yum update -y
RUN yum install -y openssh-server

RUN yum update -y
RUN yum upgrade -y
RUN wget http://repos.1c-bitrix.ru/yum/bitrix-env.sh -O /usr/local/src/bitrix-env.sh
RUN chmod +x /usr/local/src/bitrix-env.sh
RUN /usr/local/src/bitrix-env.sh

COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT /root/start.sh

EXPOSE 21 22 25 53 80 110 143 443 465 3306
