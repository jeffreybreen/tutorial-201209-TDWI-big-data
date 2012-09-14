#!/usr/bin/env Rscript

#
# "Example 0" -- square the integers from 1 to 1000
#
# from https://github.com/RevolutionAnalytics/RHadoop/wiki/Tutorial
#

library(rmr)

# Set "LOCAL" variable to T to execute using rmr's local backend.
# Otherwise, use Hadoop (which needs to be running, correctly configured, etc.)

LOCAL=F

if (LOCAL) {
	rmr.options.set(backend = 'local')
} else {
	rmr.options.set(backend = 'hadoop')
}

small.ints = 1:1000

small.int.path = to.dfs(small.ints)
out = mapreduce(input = small.int.path, map = function(k,v) keyval(v, v^2))

df = as.data.frame( from.dfs( out, structured=TRUE) )
colnames(df) = c('n', 'n2')
str(df)
