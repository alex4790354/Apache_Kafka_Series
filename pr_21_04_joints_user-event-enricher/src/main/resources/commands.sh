alex / alex (just on Win-10)
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

#window-1
zookeeper-server-start.sh ~/kafka_2.13-3.2.0/config/zookeeper.properties

#window-2
kafka-server-start.sh ~/kafka_2.13-3.2.0/config/server.properties


#window-3
# create input topic with one partition to get full ordering
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic user-purchases

# create intermediary log compacted topic
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --config cleanup.policy=compact --topic user-table

# create out topic for user purchases enriched with user data (left join)
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 3 --replication-factor 1--topic user-purchases-enriched-left-join

# create out topic for user purchases enriched with user data (inner join)
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 3 --replication-factor 1 --topic user-purchases-enriched-inner-join

# start a consumer on the output topic (left join)
kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic user-purchases-enriched-left-join \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer


# start a consumer on the output topic (inner join)
kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic user-purchases-enriched-inner-join \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
