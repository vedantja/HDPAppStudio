#!/bin/bash
cwd=$(pwd)

cp HDPAppStudio*jar /var/lib/ambari-server/resources/views

/root/start_ambari.sh

echo Waiting until Ambari is fully up
sleep 120

cwd=$(pwd)


cp json-20140107.jar /var/lib/ambari-server/resources/views/work/HDPAppStudio\{2.2.0\}/
cd /var/lib/ambari-server/resources/views/work/HDPAppStudio\{2.2.0\}/
tar xf $cwd/apache-ant-1.9.4-bin.tar
git clone https://github.com/LucidWorks/banana.git
cd ${pwd}

curl -u admin:admin -H "X-Requested-By:ambari" -i -X PUT -d '{"RequestInfo": {"context" :"Start HBase via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://127.0.0.1:8080/api/v1/clusters/Sandbox/services/HBASE
curl -u admin:admin -H "X-Requested-By:ambari" -i -X PUT -d '{"RequestInfo": {"context" :"Start Storm via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://127.0.0.1:8080/api/v1/clusters/Sandbox/services/STORM
curl -u admin:admin -H "X-Requested-By:ambari" -i -X PUT -d '{"RequestInfo": {"context" :"Start Kafka via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' http://127.0.0.1:8080/api/v1/clusters/Sandbox/services/KAFKA

echo Please go to Ambari and checkout HDPAppStudio under Views. Before creating an app please make sure HBase, Kafka and Storm are all up and running.
