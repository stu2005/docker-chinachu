FROM node:14-alpine
ARG REPOSITORY="git://github.com/Chinachu/Chinachu.git"
ARG BRANCH="master"

ARG WORK_DIR="/usr/local/chinachu"

#node container default value
ARG USER_NAME="node"

RUN set -x \
	&& apk add --no-cache\
		bash \
		coreutils \
		curl \
		procps \
		ca-certificates \
	\
	&& apk add --no-cache --virtual .build-deps \
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
	&& echo 5 | sudo -u ${USER_NAME} ./chinachu installer \
	&& sudo -u ${USER_NAME} ./chinachu service operator initscript | tee /tmp/chinachu-operator \
	&& sudo -u ${USER_NAME} ./chinachu service wui initscript | tee /tmp/chinachu-wui \
	&& sudo -u ${USER_NAME} mkdir log \
	&& chmod u+x /tmp/chinachu-operator /tmp/chinachu-wui \
	&& mv /tmp/chinachu-operator /etc/init.d/ \
	&& mv /tmp/chinachu-wui /etc/init.d/ \
        && echo [] >rules.json \
        && chown ${USER_NAME}:${USER_NAME} rules.json \
        && mkdir data \
        && cd data \
        && touch recorded.json  recording.json  reserves.json  schedule.json  scheduler.pid \
        && chown ${USER_NAME}:${USER_NAME} recorded.json  recording.json  reserves.json  schedule.json  scheduler.pid \
	\
	# cleaning
	&& cd / \
	&& npm cache verify \
	&& apk del --purge .build-deps

COPY chinachu/services.sh chinachu/setup.sh /usr/local/bin
COPY chinachu/config.sample.json ${WORK_DIR}

WORKDIR ${WORK_DIR}
CMD ["/usr/local/bin/services.sh"]
EXPOSE 20772
