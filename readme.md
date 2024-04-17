# Database Replication with Debezium and Kafka

It is common for other databases outside of the 'source' database to require up-to-date data to other systems.  This tutorial will step through setting up this replication from stratch.  

There are two sets of data that will be replicated.  The first is HR related tables (employees, departments, jobs, locations) which will be replicated from Oracle to Postgres.  The second is baseball related tables (game, team, venue) which will be replicated from Postgres to Oracle.

## Components Overview

### Volumes

Several volumes need to be presented to various containers to persist data.  Be sure to review/update the docker-compose.yaml and the volume references.

| Container    | Target Mount         |
|--------------|----------------------|
| oracle       | /opt/oracle/oradata  |
| postgres     | /pgdata              |

### Ports

Several ports are exposed to interact with the deployed containers and software deployments.  Note that Postgres is using the non-default port setting of 5433 to avoid any already running Postgres clusters. 

| Container    | Port(s)         |
|--------------|-----------------|
| oracle       | 1521            |
| postgres     | 5433            |
| zookeeper    | 2181,2888,3888  |
| kafka        | 9092,29092,9999 |
| connect      | 8083,9080,9012  |
| prometheus   | 9090            |
| grafana      | 3000            |

### Oracle

Oracle Database Express Edition is used in this tutorial.  Prior to using this tutorial be sure that you have read and understand the licenses around Express Edition.

The container used is container-registry.oracle.com/database/express:21.3.0-xe.  As this container spins up for the first time it could take several minutes to create the new instance.  If deploying on Linux then modify the oracle/Dockerfile and comment out the COPY lines for runOracle.sh, checkDBStatus.sh, createDB.sh.  These custom scripts are required to workaround issues on Mac (and possibily Windows).

## Setup

All of the steps assume the current directory is debezium-poc.

### Oracle Instant Client

Before performing the build, the Kafka Connect container needs the Oracle Instant client.  Refer to the Oracle Instant Client download page to download the necessary packages and review the license agreement.  Download the Basic Package and extract the contents into the connect/instantclient directory.

Here is an example of the process for Mac OS:

```shell
cd connect
wget https://download.oracle.com/otn_software/mac/instantclient/198000/instantclient-basic-macos.x64-19.8.0.0.0dbru.zip 
unzip instantclient-basic-macos.x64-19.8.0.0.0dbru.zip
mv instantclient_19_8 instantclient
```

### Docker Compose

Review the docker compose file and make any necessary adjustments for volumes.  Note that if any port modifications are made there may be requirements to modify the connector json files.

Deploy the environment using docker-compose.

```shell
cd debezium-poc
docker-compose -f docker-compose.yaml up --build -d
```

### Oracle Setup

Once the Oracle container is fully up and running (look for the 'Database is Ready' banner in the container log), the database needs to be modified to enable archive log mode, supplemental logging, etc.  Use the following steps to exec into the Oracle container and perform these setups.  The database will restart several times.

```shell
docker exec -it oracle /bin/bash
su - oracle
# Set ORACLE_SID to XE using oraenv
. oraenv
./setup-oracle.sh
sqlplus sys/welcome1@localhost:1521/xepdb1 as sysdba @sql/hr-ora.sql
sqlplus sys/welcome1@localhost:1521/xepdb1 as sysdba @sql/mlb-ora.sql 
```

The container may also report a few ORA-600s which can be ignored as this is related to the container environment itself and does not affect the functionality needed for this tutorial.

### Postgres Setup

To setup Postgres database execute the commands below.

```shell
docker exec -it postgres /bin/bash
psql -p 5433 -f /var/lib/pgsql/sql/hr-pg.sql
psql -p 5433 -f /var/lib/pgsql/sql/mlb-pg.sql
```

### Register the Connectors

Using curl, register the connectors with Kafka-Connect.

```shell
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @connectors/oracle-connector.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @connectors/postgres-connector.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @connectors/postgres-sink.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @connectors/oracle-sink.json
```

### Check Kafka Connect Logs

To ensure that everything is working from the Kafka-Connect perspective, view the logs from the kafka-connect conatiner.

```shell
docker logs kafka-connect -f
```

## Test Replication

### Update Oracle

Exec into Oracle container and start sqlplus.

```shell
docker exec -it oracle /bin/bash
su - oracle
# Set ORACLE_SID to XE via oraenv
. oraenv
sqlplus sys/welcome1@localhost:1521/xepdb1 as sysdba
```

From within the sqlplus session, execute the following SQL statements.

```shell
INSERT INTO hr.employees (employee_id, first_name, last_name, hire_date) VALUES (200, 'George', 'Washington', sysdate);
SELECT SUM(salary) FROM hr.employees;
UPDATE hr.employees SET salary=salary*1.1;
COMMIT;
SELECT SUM(salary) FROM hr.employees;
```

### Verify Postgres

With the changes made to the employees table in Oracle, verify the updates in Postgres.  First, start psql using docker exec.

```shell
docker exec -it postgres psql -p 5433 -d hr
```

Run the following SQL to verify replication.

```sql
SELECT * FROM employees WHERE last_name='Washington';
SELECT SUM(salary) FROM employees;
```

### Update Postgres

Now let us test the reverse replication using the sports tables.  Connect to Postgres using psql and the sport database.

```shell
docker exec -it postgres psql -p 5433 -d sport
```

Run the following SQL statements to update data in Postgres.

```sql
INSERT INTO venue (venue_id, venue_name, city, country) VALUES (900,'Crunchy Park', 'Jacksonville, FL', 'USA');
UPDATE venue SET venue_name='Pace Park' WHERE venue_id=136;
```

### Verify Oracle

Exec into Oracle container and start sqlplus.

```shell
docker exec -it oracle /bin/bash
sqlplus sys/welcome1@localhost:1521/xepdb1 as sysdba
```

Run the following SQL statement to verify the updates in Oracle.

```sql
SELECT * FROM sport.venue WHERE venue_id IN (900,136);
```

## Conclusion

Debezium helps bridge the data gap by performing change data capture in both Oracle and Postgres and publishing those messages to Kafka.  The Oracle capture leverages logminner which does have some scalability challenges.  On the Postgres side, Debezium leverages the native logical replication capabilities and scales better.

Last, Prometheus and Grafana is deployed with built in dashboards and mining of metrics published by Debezium.  Be sure to check those out by access Grafana at http://localhost:3000.  The default user/password for Grafana is admin/admin.
