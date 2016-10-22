## Easily compile and flash binaries for the ESP32 and ESP31b
You might also be interested in the branch for the ESP8266 and ESP8266EX: https://github.com/T-vK/docker-esp-sdk/

## !!! This branch is completely untested for now!

## How to install

If you don't have docker, install docker first: https://docs.docker.com/engine/installation/linux/

``` bash
git clone -b esp32 https://github.com/T-vK/docker-esp-sdk.git
cd docker-esp-sdk
sudo docker build -t tavk/esp-sdk:0.1 .
```

## How to use

### Compiling binaries

``` bash
sudo docker run -t -i -u esp \
-v /home/ubuntu/esp8266/esp-open-sdk/examples/blinky:/home/esp/shared_project \
tavk/esp-sdk:0.1 \
make
```

 - Replace `/home/ubuntu/esp8266/esp-open-sdk/examples/blinky` with the absolute path to the directory of the project oyu want to compile.
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
tavk/esp-sdk:0.1 \
make ESP_ROOT=/home/esp/esp-open-sdk burn
```

 - Replace `/dev/ttyUSB0` with the COM port your esp is connected to.
 - Replace `/home/debian/espusb` with the absolute path to directory of the project you want to compile/flash.
 - Replace `make ESP_ROOT=/home/esp/esp-open-sdk burn` with the command necessary to compile and flash your project.
