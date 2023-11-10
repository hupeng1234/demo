FROM debian:12-slim
# RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources
RUN apt update
RUN apt install -y sudo curl wget net-tools iproute2 openssh-server
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && apt update && apt install ngrok
RUN ngrok config add-authtoken 2XqmDuOQfm7OGY5niuahFPfKBQt_2M7Xd4Z372wbUzrfpb71u

RUN mkdir /run/sshd

#RUN echo root:railway2023 | chpasswd
RUN useradd -m -d /home/admin -s /bin/bash -u 10001 admin
RUN echo admin:railway2023 | chpasswd
RUN usermod -aG sudo admin
RUN echo "admin  ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
RUN echo 'sudo service ssh start' >> /start.sh
#RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config
RUN echo "ngrok tcp 22 --log stdout" >> start.sh
RUN chmod +x /start.sh
EXPOSE 22 3000
USER 10001
CMD  /start.sh

