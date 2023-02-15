#!/bin/bash

SRC_AREA="/tmp/splitmerge/files"
SPLIT_AREA="/tmp/splitmerge/splits"
DONE_AREA="/tmp/splitmerge/done"

DBFILES="/tmp/splitmerge/dbfiles.txt"
DBSPLITS="/tmp/splitmerge/dbsplits.txt"

SIZE_THRESH=1024 #MB

# Generate db files
touch $DBFILES
touch $DBSPLITS


while true
do
	# find the largest file name and size

	# if the size is greater than SIZE_THRESH
	# generate a unique key based on the file checksum
	# check if the checksummed pk does not already exist in the db
	# if not, add the file entry to the db
	# perform the split
	# move the split parts to DEST_AREA
	# Update the database


	sleep 10m
done

