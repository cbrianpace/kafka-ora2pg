FROM grafana/grafana:latest

USER root

# Added
RUN mkdir -p /etc/grafana/provisioning/dashboards
RUN mkdir -p /etc/grafana/provisioning/datasources
RUN mkdir -p /var/lib/grafana/dashboards

COPY dashboard.yml /etc/grafana/provisioning/dashboards
COPY datasource.yml /etc/grafana/provisioning/datasources
COPY debezium-dashboard.json /var/lib/grafana/dashboards/debezium-dashboard.json

# Added
RUN chmod -R 777 /etc/grafana/provisioning/dashboards
RUN chmod -R 777 /var/lib/grafana/dashboards
