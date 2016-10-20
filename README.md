## Example usage

### simple example

``` bash
sudo docker run -t -i --device=/dev/ttyUSB0 \
-v /home/example/blinky:~/shared_project \
-e COM_PORT='/dev/ttyUSB0' \
-e SDK_VERSION='1.5.3' \
-e BIN_FILE_1='blinky-0x00000.bin' \
-e BIN_FILE_2='blinky-0x40000.bin'
```

### directly passing arguments to make and esptool

``` bash
sudo docker run -t -i --device=/dev/ttyUSB0 \
-v /home/example/blinky:~/shared_project \
-e MAKE_PARAMETERS='build' \
-e ESPTOOL_PARAMETERS='' \
-e BIN_FILE_1='blinky-0x00000.bin' \
-e BIN_FILE_2='blinky-0x40000.bin'
```

## List of available parameters

 - `MAKE_PARAMETERS` (content will be appended directly to the make command)
 - `ESPTOOL_PARAMETERS` (content will be appended directly to the esptool command)
 - `COM_PORT` (the port to which you want to flash. Default: `/dev/ttyUSB0`)
 - `BAUD` (the baudrate for the flashing. Default: `115200`)
 - `CHIP` (the chip that your module uses. `ESP32` or `ESP8266`. Default: `ESP8266`)
 - `ADDRESS_1` (the address to which to flash the first bin file. Default: `0x00000`)
 - `BIN_FILE_1` (the name of the first bin file to flash)
 - `ADDRESS_2` (the address to which to flash the first bin file. Default: `0x40000`)
 - `BIN_FILE_2` (the name of the second bin file to flash)
