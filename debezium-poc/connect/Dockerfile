FROM debezium/connect:1.9
# ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc
ENV LD_LIBRARY_PATH=/oracle/instantclient
ENV INSTANT_CLIENT_DIR=/oracle/instantclient/
ENV CONNECT_PLUGIN_PATH=/kafka/connect

USER root
#RUN microdnf -y install libaio && microdnf clean all
RUN mkdir /kafka/etc && cd /kafka/etc 
RUN mkdir /oracle
RUN chmod -R 777 /oracle
RUN chmod -R 777 /kafka/etc

USER kafka

# Add Oracle client and drivers
COPY --chown=kafka:kafka instantclient/xstreams.jar /kafka/libs
COPY --chown=kafka:kafka instantclient/ojdbc8.jar /kafka/libs
#COPY --chown=kafka:kafka instantclient /oracle/

# Add Confluent kafka connect for jdbc & elastic sink connector
COPY --chown=kafka:kafka confluentinc-kafka-connect-jdbc-10.3.3/lib/*.jar /kafka/connect/kafka-connect-jdbc/
COPY --chown=kafka:kafka confluentinc-connect-transforms-1.4.2/lib/*.jar /kafka/connect/kafka-connect-transforms/
COPY --chown=kafka:kafka kafka-connect-transform-common /kafka/connect/

# Add filter dependencies
COPY --chown=kafka:kafka debezium-scripting/*.jar /kafka/connect/debezium-connector-oracle/
COPY --chown=kafka:kafka groovy/*.jar /kafka/connect/debezium-connector-oracle/

# Add JMX dependencies
COPY --chown=kafka:kafka config.yml /kafka/etc/config.yml
COPY --chown=kafka:kafka jmx_prometheus_javaagent-0.15.0.jar /kafka/etc/jmx_prometheus_javaagent.jar
RUN chmod 644 /kafka/etc/config.yml