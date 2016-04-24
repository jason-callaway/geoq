#!/usr/bin/env bash

pushd ~

virtualenv ~/geoq
source ~/geoq/bin/activate

cat > ~/queries.sql << EOF
create role geoq login password 'geoq';
create database geoq with owner geoq;
\c geoq
create extension postgis;
create extension postgis_topology;
EOF
# This sucks, need to make these queries idempotent. For now always return true.
PGPASSWORD=${DATABASE_PASSWORD} psql -h pg-master -U postgres -f ~/queries.sql || true


pip install django
pip install paver
paver install_dependencies
paver sync
paver install_dev_fixtures


cat << EOF > ~/geoq/local_settings.py
STATIC_URL_FOLDER = '/static'
STATIC_ROOT = '{0}{1}'.format('/var/www/html', STATIC_URL_FOLDER)
EOF

/usr/bin/env python ~/manage.py collectstatic
/usr/bin/env python ~/manage.py createsuperuser
