FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-16.1-1

COPY --chown=postgres:postgres sql /var/lib/pgsql/sql
COPY --chown=postgres:postgres postgresql.conf.template /opt/crunchy/conf/postgres/postgresql.conf.template

USER root

RUN sed -i "s/wal_level.*/wal_level = logical/g" /opt/crunchy/conf/postgres/postgresql.conf.template
RUN sed -i "s/shared_preload_libraries.*/shared_preload_libraries = 'pgaudit.so,pg_stat_statements.so,pgnodemx.so,pgoutput'/g" /opt/crunchy/conf/postgres/postgresql.conf.template

USER postgres