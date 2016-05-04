#!/usr/bin/env bash

pushd /opt/app-root/src

cat > ~/queries.sql << EOF
create role geoq login password '${DATABASE_PASSWORD}';
create database geoq with owner geoq;
\c geoq
create extension postgis;
create extension postgis_topology;
EOF
# This sucks, need to make these queries idempotent. For now always return true.
PGPASSWORD=${DATABASE_PASSWORD} psql -h pg-master -U postgres -f ~/queries.sql || true

