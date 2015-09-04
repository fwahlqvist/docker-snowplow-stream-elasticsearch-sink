FROM java:7-jre

MAINTAINER Daniel Zohar <daniel@memrise.com>

ENV SNOWPLOW_SOURCE_ZIP snowplow_kinesis_r67_bohemian_waxwing.zip
ENV JAR_FILE snowplow-elasticsearch-sink-0.4.0

RUN wget https://bintray.com/artifact/download/snowplow/snowplow-generic/${SNOWPLOW_SOURCE_ZIP} \
    && unzip ${SNOWPLOW_SOURCE_ZIP} \
    && rm ${SNOWPLOW_SOURCE_ZIP} \
    && mv ${JAR_FILE} keep_${JAR_FILE} \
    && rm -f snowplow* \
    && mv keep_${JAR_FILE} snowplow-elasticsearch-sink.jar \
    && mkdir -p /etc/snowplow/enrichments/

ENTRYPOINT ["/usr/bin/java", "-jar", "snowplow-elasticsearch-sink.jar", "--config", "/etc/snowplow/elasticsearch-sink.conf"]
