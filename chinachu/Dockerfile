FROM node:10-buster-slim
WORKDIR /usr/src/app
RUN apt-get update \
&& apt-get install build-essential curl git ffmpeg python3 -y \
&& git clone git://github.com/Chinachu/Chinachu.git chinachu \
&& cd chinachu \
&& echo 2 | ./chinachu installer \
&& echo 4 | ./chinachu installer \
&& cp config.sample.json config.json \
&& mkdir .nave \
&& ln -s /usr/bin/node /usr/bin/npm .nave/ \
&& echo [] > rules.json \
&& ./chinachu service operator initscript > /tmp/chinachu-operator \
&& ./chinachu service wui initscript > /tmp/chinachu-wui \
&& chown root:root /tmp/chinachu-operator /tmp/chinachu-wui \
&& chmod +x /tmp/chinachu-operator /tmp/chinachu-wui \
&& mv /tmp/chinachu-operator /tmp/chinachu-wui /etc/init.d/ \
&& mkdir log \
&& touch log/wui log/scheduler log/operator
&& apt-get autoremove --purge build-essential python3 git -y \
&& apt-get clean
WORKDIR /usr/src/app/chinachu
CMD ["./chinachu","update","&&","/etc/init.d/chinachu-operator","start","&&","/etc/init.d/chinachu-wui","start"]
EXPOSE 20772
