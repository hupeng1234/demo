FROM debian:12-slim
# RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources
RUN apt update
RUN apt install -y openssh-server wget sudo

RUN mkdir /run/sshd
RUN echo 'sudo /usr/sbin/sshd -D' >> /start.sh
#RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config
#RUN echo root:railway2023 | chpasswd
RUN useradd -m -d /home/admin -s /bin/bash admin
RUN echo admin:railway2023 | chpasswd
RUN usermod -aG sudo admin
RUN echo "admin  ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
RUN chmod +x /start.sh
EXPOSE 22
USER admin
CMD  /start.sh

