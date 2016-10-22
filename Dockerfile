FROM ubuntu:16.04

MAINTAINER T-vK

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository multiverse

RUN apt-get update && apt-get install -y \
	autoconf \
	automake \
	bash \
	bison \
	bzip2 \
	flex \
	g++ \
	gawk \
	gcc \
	git \
	gperf \
	libexpat-dev \
	libtool \
	libtool-bin \
	make \
	ncurses-dev \
	nano \
	python \
	python-dev \
	python-serial \
	sed \
	texinfo \
	unrar \
	unzip \
	wget \
	help2man

RUN useradd -m -s /bin/bash -g dialout esp && passwd -d esp

USER esp

WORKDIR /home/esp

RUN git clone -b esp32 --recursive https://github.com/T-vK/esp-open-sdk.git

RUN cd esp-open-sdk && make STANDALONE=n

RUN cd esp-open-sdk && make STANDALONE=y

ENV PATH /home/esp/esp-open-sdk/xtensa-lx106-elf/bin:/home/esp/esp-open-sdk/esptool:$PATH
ENV XTENSA_TOOLS_ROOT /home/esp/esp-open-sdk/xtensa-lx106-elf/bin
ENV SDK_BASE /home/esp/esp-open-sdk/sdk

COPY ./entrypoint.sh ./entrypoint.sh
USER root
RUN ["chmod", "+x", "./entrypoint.sh"]
USER esp

ENTRYPOINT ["./entrypoint.sh"]
