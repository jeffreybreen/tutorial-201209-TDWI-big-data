#!/bin/sh

/usr/bin/hadoop fs -mkdir /user/cloudera

/usr/bin/hadoop fs -mkdir /user/cloudera/wordcount
/usr/bin/hadoop fs -mkdir /user/cloudera/wordcount/data
/usr/bin/hadoop fs -put data/hadoop/wordcount/* /user/cloudera/wordcount/data/

/usr/bin/hadoop fs -mkdir /user/cloudera/airline
/usr/bin/hadoop fs -mkdir /user/cloudera/airline/data
/usr/bin/hadoop fs -put data/hadoop/airline/* /user/cloudera/airline/data/
