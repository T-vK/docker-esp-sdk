#!/bin/sh

# change and optionally download the specified SDK version. 
# if none specified use 1.5.3
cd ~/esp-open-sdk
if [ -z "$SDK_VERSION" ]; then
    make VENDOR_SDK=$SDK_VERSION
else
    make VENDOR_SDK=1.5.3
fi

# change dir to the directory that is linked with the project that is going to be compiled or flashed
cd ~/shared_project

eval $*
