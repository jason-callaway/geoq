#!/usr/bin/env bash

mkdir geoq
virtualenv ~/geoq
pushd ~/geoq
source bin/activate
git clone https://github.com/ngageoint/geoq.git
pushd geoq

cat >queries.sql << EOF
create role geoq login password 'geoq';
create database geoq with owner geoq;
\c geoq
create extension postgis;
create extension postgis_topology;
EOF
# This sucks, need to make these queries idempotent. For now always return true.
PGPASSWORD=${DATABASE_PASSWORD} psql -h pg-master -U postgres -f ./queries.sql || true

#export PATH=$PATH:/usr/pgsql-9.4/bin
pip install paver
paver install_dependencies
paver sync
paver install_dev_fixtures

npm install -g less

#cat << EOF > geoq/local_settings.py
cat << EOF > local_settings.py
STATIC_URL_FOLDER = '/static'
STATIC_ROOT = '{0}{1}'.format('/var/www/html', STATIC_URL_FOLDER)
EOF

popd
python manage.py collectstatic
python manage.py createsuperuser
