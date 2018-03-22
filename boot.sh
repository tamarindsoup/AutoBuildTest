#! /bin/bash

docker build -t test .
docker run -ti --rm \
       -e DISPLAY=${DISPLAY} \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v ${PWD}:/home/developer/haribote\
       test
