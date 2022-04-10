FROM ubuntu:20.04

ARG RELEASE_TAG

ARG USERNAME=stablecoin
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt update && \
    apt install -y git wget sudo && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /home/

# Downloading the latest VSC Server release and extracting the release archive
RUN wget https://github.com/gitpod-io/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-x64.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-x64.tar.gz && \
    rm -f ${RELEASE_TAG}-linux-x64.tar.gz

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 $USERNAME 

RUN  echo "$USERNAME:$USERNAME" | chpasswd

# # # Creating the user and usergroup
RUN groupadd --gid $USER_GID $USERNAME 

RUN chmod g+rw /home && \
    mkdir -p /home/workspace && \
    chown -R $USERNAME:$USERNAME /home/workspace && \
    chown -R $USERNAME:$USERNAME /home/${RELEASE_TAG}-linux-x64;

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Ho_Chi_Minh apt install -y zsh curl openssh-server && \
    rm -rf /var/lib/apt/lists/*

RUN service ssh start
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
RUN wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

RUN chsh -s $(which zsh)
RUN git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN echo "source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /home/workspace/.zshrc
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


USER $USERNAME

WORKDIR /home/workspace/

ENV PATH="$PATH:/usr/local/go/bin"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV HOME=/home/workspace
ENV EDITOR=code
ENV VISUAL=code
ENV GIT_EDITOR="code --wait"
ENV OPENVSCODE_SERVER_ROOT=/home/${RELEASE_TAG}-linux-x64

USER root

CMD ["/bin/sh", "-c", "${OPENVSCODE_SERVER_ROOT}/server.sh --connection-token=49e9f361-beb2-43dc-a97f-87e0839f2496 & /usr/sbin/sshd -D"]

