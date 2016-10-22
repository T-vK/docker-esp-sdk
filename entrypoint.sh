#!/bin/sh

# This entrypoint script is kinda useless at this point
# but I'm too lazy to get rid of it and it might come in handy in the future.

# change dir to the directory that is linked with the project that is going to be compiled or flashed
cd ~/shared_project

eval $*
