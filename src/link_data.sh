#!/bin/bash


DIRS=./server/solr/cores/*
for f in $DIRS
do
	echo "Creating directory $(basename $f)"
	if mkdir /data/$(basename $f)/; then
		echo "SUCCESS"
	else
		echo "Directory /data/$(basename $f) already exists...moving on"
	fi
	echo "Linking $f..."
	if ln -s /data/$(basename $f)/ $f/data; then
		echo "SUCCESS"
	else
		echo "ERROR"
	fi
done