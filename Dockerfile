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

RUN curl https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb \
	-o docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb && dpkg -i docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ADD kubernetes.list /etc/apt/sources.list.d/kubernetes.list
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add && \
	apt-get update && \
	apt-get -yqq install --no-install-recommends kubelet kubeadm kubectl kubernetes-cni \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

CMD ["/sbin/init"]