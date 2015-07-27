#!/bin/bash -e
#
#  This script might be used to copy files from directory with train data
#  based on the second argument contained file names
#
#  For example, lets train folder contains jpeg files, 0.txt contains names
#  of files to copy (without extension) and the distination folder is 0folder.
#  Then separation might be achived as follows:
#
#  separate_images.sh train 0.txt 0folder
#

if [ -z $1 ]; then
    echo "Please set input directory"
    exit -1
fi

if [ -z $2 ]; then
    echo "Please provide text file with file names to extract"
    exit -1
fi

if [ -z $3 ]; then
    echo "Please set output directory"
    exit -1
fi

mkdir -p $3

parallel -j+0 cp $1/{}.jpeg $3 :::: $2
