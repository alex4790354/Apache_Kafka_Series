alex / alex (just on Win-10)
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

#window-1
zookeeper-server-start.sh ~/kafka_2.13-3.2.0/config/zookeeper.properties

#window-2
kafka-server-start.sh ~/kafka_2.13-3.2.0/config/server.properties


#window-3
# create input topic with one partition to get full ordering
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic favourite-colour-input

# create intermediary log compacted topic
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --config cleanup.policy=compact --topic user-keys-and-colours

# create output log compacted topic
#kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic favourite-colour-output
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --config cleanup.policy=compact --topic favourite-colour-output


#window-4
# launch a Kafka consumer
kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic favourite-colour-output \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer

#optional:
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic favourite-colour-input --from-beginning
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic user-keys-and-colours --from-beginning



# launch the streams application


#window-3
# then produce data to it
kafka-console-producer.sh --broker-list localhost:9092 --topic favourite-colour-input

stephane,blue
jhon,blue
olga,blue

stephane,red
jhon,red
olga,red

stephane,green
jhon,green

alex,white
stephane,yellow



# list all topics that we have in Kafka (so we can observe the internal topics)
bin/kafka-topics.sh --list --zookeeper localhost:2181


