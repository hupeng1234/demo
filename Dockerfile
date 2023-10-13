FROM debian:12-slim
# RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources
RUN apt update
RUN apt install -y openssh-server wget

RUN mkdir /run/sshd
RUN echo '/usr/sbin/sshd -D' >> /start.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config
RUN echo root:railway2023 | chpasswd
RUN chmod +x /start.sh
EXPOSE 22
CMD  /start.sh
