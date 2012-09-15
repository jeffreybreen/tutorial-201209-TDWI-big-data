#!/usr/bin/env Rscript

#
# Example 1: wordcount
#
# Tally the number of occurrences of each word in a text
#
# from https://github.com/RevolutionAnalytics/RHadoop/wiki/Tutorial
#

library(rmr)

# Set "LOCAL" variable to T to execute using rmr's local backend.
# Otherwise, use Hadoop (which needs to be running, correctly configured, etc.)

LOCAL=F

if (LOCAL)
{
	rmr.options.set(backend = 'local')

	# we have smaller extracts of the data in this project's 'local' directory
	hdfs.data.root = 'data/local/wordcount'
	hdfs.data = file.path(hdfs.data.root, 'all-shakespeare-1000')
	
	hdfs.out.root = 'out/wordcount'
	
	hdfs.out = file.path(hdfs.out.root, 'out')
	
	if (!file.exists(hdfs.out))
		dir.create(hdfs.out.root, recursive=T)
	
} else {
	rmr.options.set(backend = 'hadoop')

	# assumes 'wordcount' and wordcount/data exists on HDFS under user's home directory
	# (e.g., /user/cloudera/wordcount/ & /user/cloudera/wordcount/data/)

	hdfs.data.root = 'wordcount'
	hdfs.data = file.path(hdfs.data.root, 'data')
	
	# unless otherwise specified, directories on HDFS should be relative to user's home
	hdfs.out.root = hdfs.data.root
	hdfs.out = file.path(hdfs.out.root, 'out')
}


map = function(k,v) {
	lapply(
		strsplit(x = v, split = '\\W')[[1]], # '\\W' is regular expression speak for "non-word character"
				function(w) keyval(w,1)
		)
}

reduce = function(k,vv) {
	keyval(k, sum(unlist(vv)))
}

wordcount = function (input, output = NULL) {
	mapreduce(input = input ,
			  output = output,
			  input.format = "text",
			  map = map,
			  reduce = reduce,
			  combine = T)}

out = wordcount(hdfs.data, hdfs.out)

df = as.data.frame( from.dfs(out, structured=T) )
colnames(df) = c('word', 'count')

# sort by count:
df = df[order(-df$count),]

print(head(df))

