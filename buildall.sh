#!/bin/bash
VERSIONS="2.3 2.4 2.5 2.6 3.0 3.1"
docker login
for i in $VERSIONS
do
echo "starting build $i"
docker build --build-arg VERSION=$i -t ehlers320/carbon-c-relay:$i .
docker push ehlers320/carbon-c-relay:$i
done
