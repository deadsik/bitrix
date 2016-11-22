FROM centos:6.6

RUN yum install openssh-server -y
RUN yum install wget -y

# bitrix
RUN wget http://repos.1c-bitrix.ru/yum/bitrix-env.sh -O /tmp/bitrix-env.sh
RUN chmod +x /tmp/bitrix-env.sh
RUN sed -i 's/read version_c/version_c=5/gi' /tmp/bitrix-env.sh
RUN /tmp/bitrix-env.sh

# update + ssh
RUN yum update -y
RUN yum upgrade -y

COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh
ENTRYPOINT /root/start.sh

EXPOSE 21 22 25 53 80 110 143 443 465 3306
