A simple minimalistic mongodb cluster for local testing. The setup.sh-scripts initializes one config server, two shards and one mongos, adds the shards to the configdb and imports an excerpt of the enron-mail dataset.

The clean.sh-script kills all the mongo processes and removes the data and log directories.
