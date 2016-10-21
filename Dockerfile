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

RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git

RUN cd esp-open-sdk && make STANDALONE=n

RUN cd esp-open-sdk \
	#&& make VENDOR_SDK=0.9.2 \
	#&& make VENDOR_SDK=0.9.3 \
	#&& make VENDOR_SDK=0.9.4 \
	#&& make VENDOR_SDK=0.9.5 \
	#&& make VENDOR_SDK=0.9.6b1 \
	#&& make VENDOR_SDK=1.0.0 \
	#&& make VENDOR_SDK=1.0.1b1 \
	#&& make VENDOR_SDK=1.0.1b2 \
	#&& make VENDOR_SDK=1.0.1 \
	#&& make VENDOR_SDK=1.1.0 \
	#&& make VENDOR_SDK=1.1.1 \
	#&& make VENDOR_SDK=1.1.2 \
	#&& make VENDOR_SDK=1.2.0 \
	#&& make VENDOR_SDK=1.3.0 \
	&& make VENDOR_SDK=1.4.0 \
	&& make VENDOR_SDK=1.5.0 \
	&& make VENDOR_SDK=1.5.1 \
	&& make VENDOR_SDK=1.5.2 \
	&& make VENDOR_SDK=1.5.3 \
	&& make VENDOR_SDK=2.0.0 \
	&& make VENDOR_SDK=1.5.4

ENV PATH /home/esp/esp-open-sdk/xtensa-lx106-elf/bin:/home/esp/esp-open-sdk/esptool:$PATH
ENV XTENSA_TOOLS_ROOT /home/esp/esp-open-sdk/xtensa-lx106-elf/bin
ENV SDK_BASE /home/esp/esp-open-sdk/sdk

COPY ./entrypoint.sh ./entrypoint.sh
USER root
RUN ["chmod", "+x", "./entrypoint.sh"]
USER esp

ENTRYPOINT ["./entrypoint.sh"]
