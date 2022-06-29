sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Start the ZooKeeper service
# Note: Soon, ZooKeeper will no longer be required by Apache Kafka.
#Win: https://kafka.apache.org/quickstart
#Win: .\bin\windows\zookeeper-server-start.bat .\config\zookeeper.properties
zookeeper-server-start.sh ~/kafka_2.13-3.2.0/config/zookeeper.properties

# Start the Kafka broker service
#Win: .\bin\windows\kafka-server-start.bat .\config\server.properties
kafka-server-start.sh ~/kafka_2.13-3.2.0/config/server.properties

# Create topic:
#kafka-topics.sh --bootstrap-server 127.0.0.1:9092 --topic demo_java   --create --partitions 3 --replication-factor 1
kafka-topics.sh  --create --topic topic-example --bootstrap-server localhost:9092

# Create producer 
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic topic-example 

# Create consumer: 
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-example --from-beginning
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic javaguides --from-beginning
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic javaguides_json --from-beginning



17:00 
теорию 
ООП
Хибирнет
Анатации 
Микросервисы. 