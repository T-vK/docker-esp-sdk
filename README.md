## Easily compile and flash binaries for the ESP32 and ESP31b
You might also be interested in the branch for the ESP8266 and ESP8266EX: https://github.com/T-vK/docker-esp-sdk/

## How to install

If you don't have docker, install docker first: https://docs.docker.com/engine/installation/linux/

``` bash
git clone -b esp32 https://github.com/T-vK/docker-esp-sdk.git
cd docker-esp-sdk
sudo docker build -t tavk/esp32-sdk:0.1.0 .
```

## How to use examples

### Compiling binaries

``` bash
sudo docker run -t -i -u esp \
-v /home/debian/esp-idf/examples/01_hello_world:/home/esp/shared_project \
tavk/esp32-sdk:0.1.0 \
make all
```

 - Replace `/home/debian/esp-idf/examples/01_hello_world` with the absolute path to the directory of the project oyu want to compile.
 - Replace `make all` with whatever command is necessary to compile your binary/binaries.


### Flashing

``` bash
sudo docker run -t -i -u esp \
--device=/dev/ttyUSB0 \
-v /home/debian/esp-idf/examples/01_hello_world:/home/esp/shared_project \
tavk/esp32-sdk:0.1.0 \
make flash
```

 - Replace `/home/debian/esp-idf/examples/01_hello_world` with the absolute path to the directory that contains the files you want to flash.
 - Replace `/dev/ttyUSB0` with the COM port that your ESP is connected to.
 - Replace `make flash` with whatever command is necessary to flash your binaries.

### Please refer to https://github.com/espressif/esp-idf for more indepth information on how to compile/flash for your ESP32

## Testing
I have successfully compiled an example project.  
Since I don't have my ESP32 modules yet, I can't test if the flashing actually works.  
But I'm sure you will tell me in the issues if something doesn't work. :)

I don't really know how to change the config wihtout going through menuconfig manually,  
so that might be a problem.. I haven't really looked into it too much though.

## Can I use this on Windows?
Yes, but docker doesn't run natively on Windows. Tools like boot2docker or docker-machine create a Linux VM using VirtualBox. So in order to grant the docker image access to your serial port and your project folder you have to pass your serial port (or usb serial adapter) through to the vm and the same applies for your project folder.  
Read this for more information on that: http://stackoverflow.com/questions/30864466/whats-the-best-way-to-share-files-from-windows-to-boot2docker-vm

## Can I use this on Mac OS X?
Probably yes. If docker runs natively on Mac OS X, then there is no need to do anything special. Otherwise follow the same steps that are required for Windows as described above.
