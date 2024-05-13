FROM ubuntu:22.04

RUN apt update && \
    apt install -y git wget sudo openssh-server zsh curl nano build-essential libssl-dev pkg-config protobuf-compiler libclang1 clang \
       cmake \
        libpq-dev \
        libdw-dev \
        binutils \
        lld \
        libudev-dev && \
    rm -rf /var/lib/apt/lists/*

# Creating the user and usergroup
RUN useradd -rm -d /home/ubuntu -s /usr/bin/zsh -g root -G sudo -u 1000 test

RUN  echo 'test:test' | chpasswd

RUN systemctl enable ssh

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config


RUN wget https://dl.google.com/go/go1.22.3.linux-amd64.tar.gz && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz

RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh

USER test

WORKDIR /home/ubuntu

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-autosuggestions
COPY zshrc .zshrc

USER root

RUN apt update && \
    apt install -y iputils-ping iproute2

CMD ["/usr/sbin/sshd","-D"]
