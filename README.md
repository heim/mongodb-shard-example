A simple minimalistic mongodb cluster for local testing. The setup.sh-scripts initializes one config server, two shards and one mongos, adds the shards to the configdb and imports an excerpt of the enron-mail dataset.

The clean.sh-script kills all the mongo processes and removes the data and log directories.


To setup the database for sharding execute these commands at the mongo shell:

sh.enableSharding("enron")
db.messages.ensureIndex({"headers.From": 1})
sh.shardCollection("enron.messages", {"headers.From": 1}, false)


Some fun commands to run in the shell.




db.messages.find({"headers.To": "jeff.skilling@enron.com"}).count() //explain()
db.messages.ensureIndex({"headers.To": 1})


db.messages.find({"headers.From": "jeff.skilling@enron.com"}).count() //explain()
db.messages.ensureIndex({"headers.From": 1})
sh.enableSharding("enron")
sh.shardCollection("enron.messages", {"headers.From":1}, false)


db.messages.aggregate({$unwind: "$headers.To"}, {$group: {_id: "$headers.To", sum: {$sum: 1}}}, {$sort: { "sum": -1}}, {$limit: 5})

db.messages.ensureIndex({"headers.To": 1})

db.messages.aggregate({$unwind: "$headers.To"}, {$group: {_id: {"to": "$headers.To", "from" : "$headers.From"}, sum: {$sum: 1}}}, {$sort: { "sum": -1}}, {$limit: 5})






