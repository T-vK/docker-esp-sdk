#!/bin/sh

# change and optionally download the specified SDK version. 
# if none specified use 1.5.3
cd ~/esp-open-sdk
make VENDOR_SDK=${SDK_VERSION:-1.5.3}

# change dir to the directory that is linked with the project that is going to be compiled or flashed
cd ~/shared_project

eval $*
