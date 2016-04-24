#!/usr/bin/env bash

pushd /opt/app-root/src
source ./geoq_virtualenv/bin/activate
paver start_django