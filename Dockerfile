FROM ubuntu:18.04
LABEL maintainer="wyp <wangyp0701@gmail.com>"

ENV TZ Asia/Shanghai
ENV TINI_VERSION 0.19.0
ENV ZIMG_VERSION 3.2.0
ARG DEBIAN_FRONTEND=noninteractive

RUN    /bin/sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install  -y tzdata  libtool pkg-config nasm build-essential \
    openssl  libevent-dev libjpeg-dev  libgif-dev libpng-dev  libwebp-dev libmemcached-dev cmake git curl autoconf ca-certificates \
    && git clone https://github.com/buaazp/zimg -b master --depth=1 \
    && curl -fSL "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" -o /usr/local/bin/tini \
    && chmod +x /usr/local/bin/tini \
    && cd /zimg   \
    && make -j2\
    && /bin/sed -i "s/is_daemon       = 1/is_daemon       = 0/g" bin/conf/zimg.lua \
    && mkdir /zimg/bin/log \
    && ln -sf /dev/stdout /zimg/bin/log/zimg.log \
    && apt-get autoremove -y git build-essential autoconf cmake curl &&apt-get clean \
    && /bin/rm -rf /var/lib/apt/lists/* build/ deps/ doc/ specs/ src/ test

EXPOSE 4869
VOLUME  /zimg/bin/img 
WORKDIR /zimg/bin
ENTRYPOINT ["tini", "--"]
#  Define default command.
CMD [ "./zimg", "conf/zimg.lua"]
