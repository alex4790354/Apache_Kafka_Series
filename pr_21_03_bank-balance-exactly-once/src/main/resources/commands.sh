alex / alex (just on Win-10)
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

#window-1
zookeeper-server-start.sh ~/kafka_2.13-3.2.0/config/zookeeper.properties

#window-2
kafka-server-start.sh ~/kafka_2.13-3.2.0/config/server.properties


#window-3
# create input topic with one partition to get full ordering
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic bank-transactions

# create intermediary log compacted topic
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --config cleanup.policy=compact --topic bank-balance-exactly-once



#window-4
# launch a Kafka consumer
kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic bank-balance-exactly-once \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer

#optional:
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bank-transactions --from-beginning



# launch the streams application



