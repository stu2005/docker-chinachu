FROM node:14-alpine AS build

ENV DOCKER="YES"
ARG REPOSITORY="https://github.com/Chinachu/Chinachu.git"
ARG WORK_DIR="/app"

#node container default value
ARG USER_NAME="node"
RUN set -x \
	&& apk add --no-cache \
                bash \
		coreutils \
		procps \
		ca-certificates \
	        alpine-sdk \
		git \
		make \
		gcc \
		g++ \
		autoconf \
		automake \
		wget \
		curl \
		sudo \
		tar \
		xz \
		libc-dev \
		musl-dev \
		eudev-dev \
		libevent-dev \
		perl-utils \
	\
	&& mkdir -p ${WORK_DIR} \
	&& git clone ${REPOSITORY} ${WORK_DIR} \
	&& chown -R ${USER_NAME} ${WORK_DIR} \
	&& cd ${WORK_DIR} \
	&& echo 2 | sudo -u ${USER_NAME} ./chinachu installer \
	&& echo 4 | sudo -u ${USER_NAME} ./chinachu installer \
	&& sudo -u ${USER_NAME} ./chinachu service operator initscript | tee /tmp/chinachu-operator \
	&& sudo -u ${USER_NAME} ./chinachu service wui initscript | tee /tmp/chinachu-wui \
	&& sudo -u ${USER_NAME} mkdir log \
	\
	&& chmod u+x /tmp/chinachu-operator /tmp/chinachu-wui \
	&& mv /tmp/chinachu-operator /etc/init.d/ \
	&& mv /tmp/chinachu-wui /etc/init.d/

FROM node:14-alpine

COPY --from=build /app /app
COPY --from=build /etc/init.d/chinachu-operator /etc/init.d/chinachu-operator
COPY --from=build /etc/init.d/chinachu-wui /etc/init.d/chinachu-wui
COPY services.sh /usr/local/bin
COPY config.sample.json ${WORK_DIR}

RUN apk add --no-cache \
                sudo \
                ffmpeg \
                bash \
                coreutils \
                curl \
                procps \
                ca-certificates && \
    chown -R node:node /app && \
    sudo -u node mkdir /app/data && \
    cd /app/data && \
    sudo -u node echo [] >recording.json && \
    chown node:node ./recording.json
WORKDIR /app
CMD ["/usr/local/bin/services.sh"]
EXPOSE 20772
