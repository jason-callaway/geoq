create role geoq login password 'geoq';
create database geoq with owner geoq;
\c geoq
create extension postgis;
create extension postgis_topology;