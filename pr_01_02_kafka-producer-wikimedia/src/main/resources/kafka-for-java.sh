alex / alex
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

zookeeper-server-start.sh ~/kafka_2.13-3.2.0/config/zookeeper.properties
kafka-server-start.sh ~/kafka_2.13-3.2.0/config/server.properties


kafka-topics.sh --bootstrap-server 127.0.0.1:9092 --topic wikimedia.recentchange   --create --partitions 3 --replication-factor 1

kafka-console-consumer.sh --bootstrap-server 127.0.0.1:9092 --topic wikimedia.recentchange --from-beginning

kafka-console-producer.sh --bootstrap-server localhost:9092 --topic wikimedia.recentchange






# consuming from beginning
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic demo_java --from-beginning
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic demo_java --from-beginning

# other terminal


