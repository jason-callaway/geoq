#!/usr/bin/env bash

pushd /opt/app-root/src
./openshift/setup.sh
source ./geoq_virtualenv/bin/activate
paver start_django