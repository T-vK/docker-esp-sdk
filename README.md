## Example usage

docker run -t -i --device=/dev/ttyUSB0 \
-v /home/example/blinky:~/shared_project \
-e COM_PORT='/dev/ttyUSB0' \
-e SDK_VERSION='1.5.3' \
-e BIN_FILE_1='blinky-0x00000.bin' \
-e BIN_FILE_2='blinky-0x40000.bin'


docker run -t -i --device=/dev/ttyUSB0 \
-v /home/example/blinky:~/shared_project \
-e COM_PORT='/dev/ttyUSB0' \
-e SDK_VERSION='1.5.3' \
-e BIN_FILE_1='blinky-0x00000.bin' \
-e BIN_FILE_2='blinky-0x40000.bin'
