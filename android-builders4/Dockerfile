FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes
RUN apt update && apt install -y \
    curl git unzip xz-utils zip libglu1-mesa openjdk-11-jdk wget ca-certificates \
    jq \
    iputils-ping \
    libcurl4 \
    libicu60 \
    libunwind8 \
    netcat \
    libssl1.0
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
ENV ANDROID_HOME /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
RUN mkdir -p /home/developer/.gradle && mkdir -p /home/developer/.pub-cache

# # Download Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git
# ENV PATH "$PATH:/home/developer/flutter/bin"

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mkdir -p Android/sdk/cmdline-tools
RUN mv tools Android/sdk/cmdline-tools/tools
RUN cd Android/sdk/cmdline-tools/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/cmdline-tools/tools/bin && ./sdkmanager "platforms;android-29" "platforms;android-30" "build-tools;30.0.0" "build-tools;29.0.2" "platform-tools"
ENV PATH "$PATH:/home/developer/Android/sdk/cmdline-tools/tools/bin"
# Run basic check to download Dark SDK
# RUN flutter doctor

WORKDIR /home/developer
RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
  && rm -rf /var/lib/apt/lists/*
ENV TARGETARCH=linux-x64
# ENV PATH "$PATH:/home/developer/flutter/bin"
CMD tail -f /dev/null
WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh
COPY ./run-docker.sh .
RUN chmod +x run-docker.sh

ENTRYPOINT ["./start.sh"]
