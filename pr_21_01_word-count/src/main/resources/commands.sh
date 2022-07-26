alex / alex (just on Win-10)
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

#window-1
zookeeper-server-start.sh ~/kafka_2.13-3.2.0/config/zookeeper.properties

#window-2
kafka-server-start.sh ~/kafka_2.13-3.2.0/config/server.properties


#window-3
# create input topic with one partition to get full ordering
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic word-count-input
kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --replication-factor 1 --topic word-count-output


# launch a Kafka consumer
kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic word-count-output \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer

# launch the streams application

# then produce data to it
kafka-console-producer.sh --broker-list localhost:9092 --topic word-count-input

# package your application as a fat jar
mvn clean package

# run your fat jar
java -jar <your jar here>.jar

# list all topics that we have in Kafka (so we can observe the internal topics)
kafka-topics.sh --list --zookeeper localhost:2181
