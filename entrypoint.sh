#!/bin/sh

# change and optionally download the specified SDK version. 
# if none specified use 1.5.3
cd ~/esp-open-sdk
if [ -z "$SDK_VERSION" ]; then
    make VENDOR_SDK=$SDK_VERSION
else
    make VENDOR_SDK=1.5.3
fi


# change dir to the directory that is linked with the project that is going to be compiled
cd ~/shared_project
touch test.txt

if [ -z "$MAKE_PARAMETERS" ]; then
    make $MAKE_PARAMETERS
else
    make
fi

# flash the compiled bin file
if [ -z "$ESPTOOL_PARAMETERS" ]; then
    esptool $ESPTOOL_PARAMETERS
else
    if [ -z "$COM_PORT" ]; then
        $COM_PORT = "/dev/ttyUSB0";
    fi
    if [ -z "$BAUD" ]; then
        $BAUD = "115200";
    fi
    if [ -z "$CHIP" ]; then
        $CHIP = "esp8266";
    fi
    if [ -z "$ADDRESS_1" ]; then
        $ADDRESS_1 = "0x00000";
    fi
    if [ -z "$ADDRESS_2" ]; then
        $ADDRESS_2 = "0x40000";
    fi
    
    esptool -cc $CHIP -cp $COM_PORT -cb $BAUD -ca $ADDRESS_1 -cf $BIN_FILE_1 -ca $ADDRESS_2 -cf $BIN_FILE_2
fi
