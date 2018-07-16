FROM ubuntu:16.04

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yqq install --no-install-recommends \
	apt-utils \
	curl \
	apt-transport-https ca-certificates \
	snapd snapcraft \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN snap install conjure-up --classic && conjure-up kubernetes

CMD ["/sbin/init"]