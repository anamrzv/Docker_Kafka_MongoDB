#!/bin/bash
echo "sleeping for 10 seconds"
sleep 10

echo mongo_setup.sh time now: `date +"%T" `
mongosh --host mongodb-source:27017 <<EOF
  var cfg = {
    "_id": "ana-replication-set",
    "version": 1,
    "members": [
      {
        "_id": 0,
        "host": "mongodb-source:27017",
        "priority": 2
      },
      {
        "_id": 1,
        "host": "mongodb-target:27017",
        "priority": 0
      }
    ]
  };
  rs.initiate(cfg);
EOF