#! /bin/bash
echo -e "[00;32mCreating directories for data and logs[00m"
mkdir -p data/conf data/sh{1,2} log
echo -e "[00;32mStarting mongod config server[00m"
mongod --dbpath data/conf --configsvr --logpath log/config.log --fork

echo -e "[00;32mStarting shard servers[00m"
echo ""
mongod --shardsvr --logpath log/sh1.log --port 27501 --dbpath data/sh1 --fork
mongod --shardsvr --logpath log/sh2.log --port 27601 --dbpath data/sh2 --fork

echo -e "[00;32mStarting mongos[00m"
echo ""
mongos --configdb localhost:27019 --logpath log/mongos.log --fork

if [ ! -f enron.tar ]; then
  echo -e "[00;32mDownloading enron dataset[00m"
  echo ""
  wget https://www.dropbox.com/s/ykghlxuih28tjvb/enron.tar
  #wget https://education.10gen.com/static/m101j-may-2013/handouts/enron.1febe86d6d2e.tar
  #mv enron.1febe86d6d2e.tar enron.tar
fi

echo -e "[00;32mUnpacking enron dataset[00m"
tar xf enron.tar


echo -e "[00;32mConnecting to mongos and adding shards to config server[00m"
mongo shardsetup.js
echo -e "[00;32mImporting enron dataset[00m"
mongorestore dump
