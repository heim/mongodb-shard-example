#!/bin/sh

echo -e "[00;32mKilling all mongod and mongos processes[00m"
killall mongod mongos
echo -e "[00;32mRemoving data, log and dump directories[00m"
rm -r data log dump
