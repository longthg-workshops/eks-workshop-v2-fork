FROM ubuntu:22.04

RUN apt install -y shadow-utils && useradd \
    --home "/home/ubuntu" \
    --create-home \
    --user-group \
    --shell /bin/bash \
    ubuntu

ADD scripts/installer.sh /tmp/installer.sh

RUN bash /tmp/installer.sh

ADD scripts/entrypoint.sh /entrypoint.sh

COPY --chmod=755 bin/* /usr/local/bin

RUN mkdir -p /eks-workshop && chown ubuntu /eks-workshop

USER ubuntu

COPY --chmod=755 scripts/setup.sh /tmp/setup.sh

RUN mkdir -p /home/ubuntu/environment

WORKDIR /home/ubuntu/environment

ENTRYPOINT ["bash", "/entrypoint.sh"]
