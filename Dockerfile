FROM phusion/baseimage

ENV VERSION 4.0beta3

ENV DEBIAN_FRONTEND noninteractive
COPY installer/dude-install-$VERSION.exe /

#add thailand repo
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial main restricted" > /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial-security main restricted" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial-security universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror1.ku.ac.th/ubuntu/ xenial-security multiverse" >> /etc/apt/sources.list

# Need to generate our locale.
RUN locale-gen de_DE de_DE.UTF-8
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE.UTF-8
RUN apt-get update -q

RUN dpkg --add-architecture i386 \
  && apt-get install --yes --no-install-recommends software-properties-common \
  && add-apt-repository --yes ppa:ubuntu-wine/ppa \
  && apt-get update \
  && apt-get install --yes --no-install-recommends p7zip-full xvfb wine1.8 \
  && apt-get install --yes --no-install-recommends nano \
  && 7z x -o/dude /dude-install-$VERSION.exe \
  && chmod +x /dude/dude.exe \
  && mkdir /etc/service/dude \
  && rm /dude-install-$VERSION.exe \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY container/dude.sh /etc/service/dude/run

VOLUME /dude
VOLUME /root/.wine

CMD ["/sbin/my_init"]
