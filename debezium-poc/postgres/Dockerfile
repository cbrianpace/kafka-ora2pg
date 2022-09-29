FROM registry.crunchydata.com/crunchydata/crunchy-postgres-gis:ubi8-14.5-3.1-0

COPY --chown=postgres:postgres sql /var/lib/pgsql/sql

USER root

RUN sed -i "s/wal_level.*/wal_level = logical/g" /opt/crunchy/conf/postgres/postgresql.conf.template
RUN sed -i "s/shared_preload_libraries.*/shared_preload_libraries = 'pgaudit.so,pg_stat_statements.so,pgnodemx.so,pgoutput'/g" /opt/crunchy/conf/postgres/postgresql.conf.template

USER postgres