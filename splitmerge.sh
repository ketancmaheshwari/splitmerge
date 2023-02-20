#!/bin/bash

set -euo pipefail 

SRC_AREA="/tmp/splitmerge/files"
SPLIT_AREA="/tmp/splitmerge/splits"
DONE_AREA="/tmp/splitmerge/done"

DBFILES="/tmp/splitmerge/dbfiles.txt"
DBSPLITS="/tmp/splitmerge/dbsplits.txt"

SIZE_THRESH=1024 #MB
CHUNK_SIZE="10000K"

# Generate dirs
mkdir -p $SRC_AREA $SPLIT_AREA $DONE_AREA

# Generate db files
touch $DBFILES
touch $DBSPLITS

if [ "$(find $SRC_AREA -type f|wc -l)" -lt 20 ]
then
  # Generate Test data
  ./genrandomfd.sh -d 1 -f 20 -n $SRC_AREA -b 30 -e 40 -s 1130 
fi


#while true
#do
## find the files that are greater in size than the threshold and pick first

file_to_split=$(find $SRC_AREA -type f -size +${SIZE_THRESH}M | head -1)
if [ -s $file_to_split ]
then
  file_name=$(basename ${file_to_split})
  mkdir -p ${SPLIT_AREA}/${file_name}
  split -b ${CHUNK_SIZE} -d $file_to_split && mv x* ${SPLIT_AREA}/${file_name}/
fi

## if the size is greater than SIZE_THRESH
## generate a unique key based on the file checksum
## check if the checksummed pk does not already exist in the db
## if not, add the file entry to the db
## perform the split
## move the split parts to DEST_AREA
## Update the database
#
	sleep 10s
#done

echo "Done."

