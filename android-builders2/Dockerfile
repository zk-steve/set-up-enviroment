FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes
RUN apt update && apt install -y \
    curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget ca-certificates \
    jq \
    iputils-ping \
    libcurl4 \
    libicu60 \
    libunwind8 \
    netcat \
    libssl1.0
WORKDIR /home/developer
RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
  && rm -rf /var/lib/apt/lists/*
COPY --from=handyman/build-flutter /home/developer/Android /home/developer/Android
COPY --from=handyman/build-flutter /home/developer/.android /home/developer/.android
COPY --from=handyman/build-flutter /home/developer/flutter /home/developer/flutter
COPY --from=handyman/build-flutter /home/developer/.gradle /home/developer/.gradle
COPY --from=handyman/build-flutter /home/developer/.pub-cache  /home/developer/.pub-cache
ENV TARGETARCH=linux-x64
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
ENV ANDROID_HOME /home/developer/Android/sdk
ENV PATH "$PATH:/home/developer/flutter/bin"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"
CMD tail -f /dev/null
WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh
COPY ./run-docker.sh .
RUN chmod +x run-docker.sh

ENTRYPOINT ["./start.sh"]
