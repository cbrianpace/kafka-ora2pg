FROM container-registry.oracle.com/database/express:21.3.0-xe

COPY --chown=oracle:oracle sql /home/oracle/sql
COPY --chown=oracle:oracle --chmod=0755 setup-oracle.sh /home/oracle/

# Added USER as root for later version of docker
USER 0