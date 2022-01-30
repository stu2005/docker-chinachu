FROM node:14-alpine AS chinachu-build
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
	&& sudo -u ${USER_NAME} ./chinachu service operator initscript | tee /tmp/chinachu-operator \
	&& sudo -u ${USER_NAME} ./chinachu service wui initscript | tee /tmp/chinachu-wui \
	&& sudo -u ${USER_NAME} mkdir log \
	&& chmod u+x /tmp/chinachu-operator /tmp/chinachu-wui \
	&& mv /tmp/chinachu-operator /etc/init.d/ \
	&& mv /tmp/chinachu-wui /etc/init.d/ \
        && sudo -u ${USER_NAME} mkdir data
FROM node:14-alpine
COPY services.sh /usr/local/bin
COPY --from=chinachu-build /usr/local/chinachu /usr/local/chinachu
COPY --from=chinachu-build /etc/init.d/chinachu-operator /etc/init.d/chinachu-operator
COPY --from=chinachu-build /etc/init.d/chinachu-wui /etc/init.d/chinachu-wui
RUN apk add --no-cache bash \
		coreutils \
		curl \
		procps \
		ca-certificates
WORKDIR /usr/local/chinachu
CMD ["/usr/local/bin/services.sh"]
EXPOSE 20772
