#!/bin/bash

chown -R oracle:oinstall /opt/oracle/diag
chown -R oracle:oinstall /opt/oracle/oradata

"$@"