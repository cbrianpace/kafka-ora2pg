FROM prom/prometheus:latest

USER root
COPY --chmod=nobody:nobody prometheus.yml /etc/prometheus/
RUN chmod 644 /etc/prometheus/*
# RUN sed -i -e "s/'localhost:9090'/'localhost:9090','connect:8080'/" /etc/prometheus/prometheus.yml
