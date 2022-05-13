FROM registry.nestybox.com/nestybox/ubuntu-focal-systemd-docker

RUN apt update && \
    apt install -y git wget nano openssh-server
RUN systemctl enable ssh
ARG RELEASE_TAG

RUN apt update && \
    apt install -y zsh curl nano

USER admin
RUN echo admin | chsh -s $(which zsh)
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /home/admin/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/admin/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
COPY .zshrc /home/admin/.zshrc
USER root
ARG GO_VERSION
RUN wget https://golang.org/dl/${GO_VERSION}.tar.gz && rm -rf /usr/local/go && tar -C /usr/local -xzf ${GO_VERSION}.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

RUN sh -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
USER admin
WORKDIR /home/admin
# Downloading the latest VSC Server release and extracting the release archive
RUN wget https://github.com/gitpod-io/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-x64.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-x64.tar.gz && \
    rm -f ${RELEASE_TAG}-linux-x64.tar.gz
RUN mkdir codes
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV EDITOR=code
ENV VISUAL=code
ENV GIT_EDITOR="code --wait"
ENV OPENVSCODE_SERVER_ROOT=/home/admin/${RELEASE_TAG}-linux-x64
#ENTRYPOINT sleep 10000

ENTRYPOINT [""]
