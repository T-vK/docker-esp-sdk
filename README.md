## Easily compile and flash binaries for the ESP8266 and ESP8266EX
You might also be interested in the branch for the ESP32: https://github.com/T-vK/docker-esp-sdk/tree/esp32


## How to install

If you don't have docker, install docker first: https://docs.docker.com/engine/installation/linux/

``` bash
git clone https://github.com/T-vK/docker-esp-sdk.git
cd docker-esp-sdk
sudo docker build -t tavk/esp-sdk:0.1 .
```

If you don't understand what that means do this:

 - Download the files of this repository and put them in a folder or use git to clone the repository.
 - Open a command line / terminal and navigate into the folder.
 - Paste this `sudo docker build -t tavk/esp-sdk:0.1 .` and press enter. (This takes a long time; around 20 minutes for me.)


## How to use

### Compiling binaries

``` bash
sudo docker run -t -i -u esp \
-v /home/ubuntu/esp8266/esp-open-sdk/examples/blinky:/home/esp/shared_project \
-e SDK_VERSION='1.5.3' \
tavk/esp-sdk:0.1 \
make
```

 - Replace `/home/ubuntu/esp8266/esp-open-sdk/examples/blinky` with the absolute path to the directory of the project oyu want to compile.
 - Replace `1.5.3` with whatever version of the ESP SDK you want to compile. 1.4.0 up to 2.0.0 are supported.
 - Replace `make` with whatever command is necessary to compile your binary/binaries.


### Flashing binaries

``` bash
sudo docker run -t -i -u esp \
--device=/dev/ttyUSB0 \
-v /home/ubuntu/esp8266/esp-open-sdk/examples/blinky:/home/esp/shared_project \
tavk/esp-sdk:0.1 \
esptool.py --port /dev/ttyUSB0 write_flash 0x00000 blinky-0x00000.bin 0x40000 blinky-0x40000.bin
```

 - Replace `/home/ubuntu/esp8266/esp-open-sdk/examples/blinky` with the absolute path to the directory that contains the files you want to flash.
 - Replace `/dev/ttyUSB0` with the COM port that your ESP is connected to.
 - Replace `esptool.py --port /dev/ttyUSB0 write_flash 0x00000 blinky-0x00000.bin 0x40000 blinky-0x40000.bin` with whatever command is necessary to flash your binaries.


### Flashing bootloaders

``` bash
sudo docker run -t -i -u esp \
--device=/dev/ttyUSB0 \
-v /home/ubuntu/projects/esp-bootloader:/home/esp/shared_project \
tavk/esp-sdk:0.1 \
esptool.py --port /dev/ttyUSB0 write_flash --flash_mode dio --flash_size 32m 0x0 bootloader.bin
```

 - Replace `/home/ubuntu/projects/esp-bootloader` with the absolute path to the directory that contains the files you want to flash.
 - Replace `/dev/ttyUSB0` with the COM port that your ESP is connected to.
 -Replace `esptool.py --port /dev/ttyUSB0 write_flash --flash_mode dio --flash_size 32m 0x0 bootloader.bin` with whatever command is necessary to flash your binaries.

### If the make file takes care of compiling AND flashing

``` bash
sudo docker run -t -i -u esp \
--device=/dev/ttyUSB0 \
-v /home/debian/espusb:/home/esp/shared_project \
-e SDK_VERSION='1.5.3' \
tavk/esp-sdk:0.1 \
make ESP_ROOT=/home/esp/esp-open-sdk burn
```

 - Replace `/dev/ttyUSB0` with the COM port your esp is connected to.
 - Replace `/home/debian/espusb` with the absolute path to directory of the project you want to compile/flash.
 - Replace `1.5.3` with whatever version of the ESP SDK you want to use for the compiling process.
 - Replace `make ESP_ROOT=/home/esp/esp-open-sdk burn` with the command necessary to compile and flash your project.

### For more information on flashing please refer to the README of https://github.com/themadinventor/esptool

### Tested
I personally tested the docker image under Ubuntu 16.04 x64 and Debian 8 Jessie x64.

## Can I use this on Windows?
Yes, but docker doesn't run natively on Windows. Tools like boot2docker or docker-machine create a Linux VM using VirtualBox. So in order to grant the docker image access to your serial port and your project folder you have to pass your serial port (or usb serial adapter) through to the vm and the same applies for your project folder.  
Read this for more information on that: http://stackoverflow.com/questions/30864466/whats-the-best-way-to-share-files-from-windows-to-boot2docker-vm

## Can I use this on Mac OS X?
Probably yes. If docker runs natively on Mac OS X, then there is no need to do anything special. Otherwise follow the same steps that are required for Windows as described above.
