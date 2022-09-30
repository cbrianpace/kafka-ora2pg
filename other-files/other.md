### Repo for Topic Transformer
https://github.com/jcustenborder/kafka-connect-transform-common

### List Connectors
    curl -s -XGET "http://localhost:8083/connectors/"

### Delete Connectors
    curl -s -XDELETE "http://localhost:8083/connectors/postgres-sink"
    curl -s -XDELETE "http://localhost:8083/connectors/oracle-connector"

### Kafka Topics
/app/kafka/kafka_2.13-3.2.1/bin/kafka-topics.sh list --bootstrap-server localhost:9092 --list

/app/kafka/kafka_2.13-3.2.1/bin/kafka-topics.sh list --bootstrap-server localhost:9092 --delete --topic departments
/app/kafka/kafka_2.13-3.2.1/bin/kafka-topics.sh list --bootstrap-server localhost:9092 --delete --topic employees
/app/kafka/kafka_2.13-3.2.1/bin/kafka-topics.sh list --bootstrap-server localhost:9092 --delete --topic jobs
/app/kafka/kafka_2.13-3.2.1/bin/kafka-topics.sh list --bootstrap-server localhost:9092 --delete --topic locations

/app/kafka/kafka_2.13-3.2.1/bin/kafka-topics.sh list --bootstrap-server localhost:9092 --delete --topic orahr
/app/kafka/kafka_2.13-3.2.1/bin/kafka-topics.sh list --bootstrap-server localhost:9092 --delete --topic schema-changes.oracle

/app/kafka/kafka_2.13-3.2.1/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --property print.key=false --topic EMPLOYEES



## Oracle Connector Config
{
  "name": "inventory-connector",
  "config": {
    "connector.class" : "io.debezium.connector.oracle.OracleConnector",
    "tasks.max" : "1",
    "database.server.name" : "server1",
    "database.hostname" : "oracle",
    "database.port" : "1521",
    "database.user" : "c##dbzuser",
    "database.password" : "dbz",
    "database.dbname" : "XE",
    "database.pdb.name" : "XEPDB1",
    "database.connection.adapter" : "logminer",
    "database.history.kafka.bootstrap.servers" : "kafka:19092",
    "database.history.kafka.topic": "schema-changes.inventory",
    "transforms": "route",
    "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
    "transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
    "transforms.route.replacement": "$3"
    // "transforms": "filter,route",
    // "transforms.filter.type": "io.debezium.transforms.Filter",
    // "transforms.filter.language": "jsr223.groovy",
    // "transforms.filter.condition": "value.source.table == 'CUSTOMERS'",
    // "transforms.filter.topic.regex": "server1.DEBEZIUM.*",
    // "transforms.route.type": "org.apache.kafka.connect.transforms.RegexRouter",
    // "transforms.route.regex": "([^.]+)\\.([^.]+)\\.([^.]+)",
    // "transforms.route.replacement": "$3",
    "transforms"               : "topicCase",
    "transforms.topicCase.type": "com.github.jcustenborder.kafka.connect.transform.common.ChangeTopicCase",
    "transforms.topicCase.from": "LOWER_HYPHEN",
    "transforms.topicCase.to"  : "UPPER_CAMEL"
  }
}

{
    "name": "wm-postgres-sink",
    "config": {
        "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
        "tasks.max": "1",
        "topics": "wikimedia",
        "connection.url": "jdbc:postgresql://postgres:5433/postgres?user=postgres&password=Elc4r016",
        "auto.create": "false",
        "auto.evolve": "false",
        "insert.mode": "insert",
        "delete.enabled": "true",
        "pk.mode": "record_value",
        "pk.fields": "id",
        "batch.size": 3000,
        "quote.sql.identifiers": "never",
        "schemas.enable": "false",
        "transforms": "t1,t2,t3",
        "transforms.t1.type": "org.apache.kafka.connect.transforms.Flatten$Value",
        "transforms.t2.type": "org.apache.kafka.connect.transforms.ReplaceField$Value",
        "transforms.t2.renames": "meta.uri:uri,meta.id:id,meta.dt:dt,meta.domain:domain,meta.stream:stream,meta.topic:topic",
        "transforms.t3.type": "org.apache.kafka.connect.transforms.ReplaceField$Value",
        "transforms.t3.whitelist": "uri,id,dt,domain,stream,topic"
    }
}


### Signal Table
insert into debezium.debezium_signal (id, type, data) values (to_char(systimestamp,'DDMONYYYYHH24MISS'), 'log', '{"message": "Signal message at offset {}"}');
insert into debezium.debezium_signal (id, type, data) values (to_char(systimestamp,'DDMONYYYYHH24MISS'), 'execute-snapshot', '{"data-collections": ["debezium.customers"]}');
