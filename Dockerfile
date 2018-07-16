FROM ubuntu:16.04

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && \
	chmod +x /usr/local/bin/docker-compose

CMD ["/sbin/init"]