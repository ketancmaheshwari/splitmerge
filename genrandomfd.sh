#!/bin/bash

# Script to generate directory tree with random files. 
# example invocation: ./genrandomfd.sh -d 16 -f 32 -n treename -b 30 -e 40 -s 10 
# generate 16 directories each containing 32 files with atime between 40 and 30 hours in the past and random size with maximum of 10MB

numdirs=16
numfiles=32
topdirname="topdir"
minrangehours=30
maxrangehours=40
filesizemax=10

while getopts ":d:f:n:b:e:s:" Option
do
  case $Option in
    d     ) numdirs="$OPTARG" ;;
    f     ) numfiles="$OPTARG";;
    n     ) topdirname="$OPTARG";;
    b     ) minrangehours="$OPTARG";;
    e     ) maxrangehours="$OPTARG";;
    s     ) filesizemax="$OPTARG";;
    *     ) echo "Unimplemented option chosen.";;   # Default.
  esac
done

currentepoch=$(date +%s)
minepoch=$((currentepoch-minrangehours*3600))
maxepoch=$((currentepoch-maxrangehours*3600))

for eachdir in $(seq 1 "$numdirs")
do
  randdname=dir_$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 32 | head -c 8)
  mkdir -p "$topdirname"/"$randdname"
  for eachfile in $(seq 1 "$numfiles")
  do
    randfname=file_$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 32 | head -c 8)
    filesizevalue=$(shuf -i 100-$((filesizemax*1024*1024)) -n 1)
    head -c $filesizevalue </dev/urandom >"$topdirname/${randdname}/${randfname}"
    touch -d @$(shuf -i $maxepoch-$minepoch -n 1)  ${topdirname}/${randdname}/${randfname} # $minepoch must be greater than $maxepoch
  done
done

