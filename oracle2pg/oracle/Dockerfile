FROM container-registry.oracle.com/database/express:21.3.0-xe

COPY --chown=oracle:oinstall --chmod=0755 entrypoint.sh /home/oracle/ 
COPY --chown=oracle:oinstall --chmod=0750 oracle.bashrc /home/oracle/.bash_profile
COPY --chown=oracle:oinstall sql /home/oracle/sql
COPY --chown=oracle:oinstall --chmod=0755 setup-oracle.sh /home/oracle/
COPY --chown=oracle:oinstall --chmod=0755 runOracle.sh /opt/oracle/
COPY --chown=oracle:oinstall --chmod=0755 createDB.sh /opt/oracle/
COPY --chown=oracle:oinstall --chmod=0755 checkDBStatus.sh /opt/oracle/

USER 0