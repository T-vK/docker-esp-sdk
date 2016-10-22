FROM ubuntu:16.04

MAINTAINER T-vK

#RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository multiverse

RUN apt-get update && apt-get install -y \
	autoconf \
	automake \
	bison \
	bzip2 \
	flex \
	g++ \
	gawk \
	gcc \
	git \
	gperf \
	grep \
	gettext \
	libtool \
	libtool-bin \
	libexpat-dev \
	make \
	ncurses-dev \
	libncurses-dev \
	flex \
	bison \
	gperf \
	help2man \
	python \
	python-dev \
	python-serial \
	texinfo \
	wget

RUN useradd -m -s /bin/bash -g dialout esp && passwd -d esp
USER esp
WORKDIR /home/esp

RUN git clone -b xtensa-1.22.x https://github.com/espressif/crosstool-NG.git

RUN cd crosstool-NG \
	&& ./bootstrap \
	&& ./configure --prefix=$PWD \
	&& make install
RUN cd crosstool-NG \
	&& ./ct-ng xtensa-esp32-elf \
	&& ./ct-ng build \
	&& chmod -R u+w builds/xtensa-esp32-elf

RUN git clone --recursive https://github.com/espressif/esp-idf.git

ENV PATH /home/esp/crosstool-NG/builds/xtensa-esp32-elf/bin:$PATH
ENV IDF_PATH=/home/esp/esp-idf

COPY ./entrypoint.sh ./entrypoint.sh
USER root
RUN ["chmod", "+x", "./entrypoint.sh"]
USER esp

ENTRYPOINT ["./entrypoint.sh"]
