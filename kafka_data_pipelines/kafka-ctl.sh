#!/bin/bash

kafkaBase="/home/afcamar/proj/kafka"
binDir="${kafkaBase}/bin"
configDir="${kafkaBase}/config"

key=$1

if [[ "$key" == "startk" ]]; then
  # start zookeeper
  ${binDir}/zookeeper-server-start.sh ${configDir}/zookeeper.properties &
  echo "zookeeper started..."

  echo "sleeping for 10 secs..."
  sleep 10

  # start kafka
  ${binDir}/kafka-server-start.sh ${configDir}/server.properties &
  echo "kafka started..."
fi

if [[ "$key" == "createt" ]]; then
  # create topic
  ${binDir}/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
fi

if [[ "$key" == "listt" ]]; then
  # list topics
  ${binDir}/kafka-topics.sh --list --zookeeper localhost:2181
fi

if [[ "$key" == "sendmsg" ]]; then
  # send message
  ${binDir}/kafka-console-producer.sh --broker-list localhost:9092 --topic test
fi

if [[ "$key" == "startc" ]]; then
  # start a consumer
  ${binDir}/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
fi
