#!/usr/bin/env bash

pushd /opt/app-root/src

./manage.py collectstatic
./manage.py createsuperuser --username geoqadmin --email "geoqadmin@example.com" --noinput

popd
