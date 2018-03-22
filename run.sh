#! /bin/bash

docker run -ti --rm \
       -e DISPLAY=${DISPLAY} \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v ${PWD}/hariboteOSByRust:/home/developer/haribote\
       hariboteOSByRust
