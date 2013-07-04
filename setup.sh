#! /bin/sh


mkdir -p data/conf data/sh{1,2} log
mongod --dbpath data/conf --configsvr --logpath log/config.log --fork

mongod --shardsvr --logpath log/sh1.log --port 27501 --dbpath data/sh1 --fork
mongod --shardsvr --logpath log/sh2.log --port 27601 --dbpath data/sh2 --fork

mongos --configdb localhost:27019 --logpath log/mongos.log --fork

echo "Waiting for mongod's to start"
sleep 3

mongo shardsetup.js
#wget https://www.dropbox.com/s/ykghlxuih28tjvb/enron.tar
wget https://education.10gen.com/static/m101j-may-2013/handouts/enron.1febe86d6d2e.tar
mv enron.1febe86d6d2e.tar enron.tar
tar xf enron.tar
mongorestore dump
