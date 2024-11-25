FROM ubuntu:22.04

RUN apt update && \
    apt install -y git wget sudo openssh-server zsh curl nano build-essential libssl-dev pkg-config protobuf-compiler libclang1 clang \
       cmake \
        libpq-dev \
        libdw-dev \
        binutils \
        lld \
        libudev-dev \
        iputils-ping \
        iproute2 && \
    rm -rf /var/lib/apt/lists/*

# Creating the user and usergroup
RUN (useradd -rm -d /home/ubuntu -s /usr/bin/zsh -g root -G sudo -u 1000 test) \
    && (echo 'test ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers) \
    && (mkdir /var/run/sshd && systemctl enable ssh) \
    && (sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config) \
    && (sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config)

COPY environment /etc/environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN wget https://dl.google.com/go/go1.22.3.linux-amd64.tar.gz && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz
RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

RUN wget https://github.com/mozilla/sccache/releases/download/v0.8.1/sccache-v0.8.1-x86_64-unknown-linux-musl.tar.gz \
    && tar xzf sccache-v0.8.1-x86_64-unknown-linux-musl.tar.gz \
    && mv sccache-v0.8.1-x86_64-unknown-linux-musl/sccache /usr/local/bin/sccache \
    && chmod +x /usr/local/bin/sccache

RUN echo "deb [trusted=yes] https://apt.fury.io/kurtosis-tech/ /" | tee /etc/apt/sources.list.d/kurtosis.list && \
   apt update && apt install kurtosis-cli

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

USER test

WORKDIR /home/ubuntu
RUN mkdir -p ~/.ssh && (echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDIc9Y0f+TAroVKezx9U5hF4ZtKguHZLw/q/457dMpVi server" > ~/.ssh/authorized_keys)

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-autosuggestions
COPY --link zshrc .zshrc
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
RUN /home/ubuntu/.cargo/bin/rustup default nightly

RUN mkdir -p /home/ubuntu/.config
COPY kube-config /home/ubuntu/.kube/config
COPY kurtosis-config.yml /home/ubuntu/.config/kurtosis/kurtosis-config.yml
COPY contexts-config.json /home/ubuntu/.config/kurtosis/contexts-config.json

USER root
CMD ["/usr/sbin/sshd","-D"]
