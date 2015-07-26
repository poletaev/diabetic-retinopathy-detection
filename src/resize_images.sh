#!/bin/bash -e
#
# This script utilizes convert utility from ImageMagic tools
# http://www.imagemagick.org/script/command-line-tools.php
#

if [ -z $1 ]; then
    echo "Please set input directory"
    exit -1
fi

SIZE=1024x1024
OUT_DIR="$1_out"

mkdir -p $OUT_DIR
echo "output directory is $OUT_DIR"

for file in `ls $1`; do
    echo "Process $file"
    IN_FILE="$1/$file"
    OUT_FILE="$OUT_DIR/$file"
    convert -fuzz 5% -trim +repage -resize $SIZE -gravity center -background black -extent $SIZE $IN_FILE $OUT_FILE
    # convert -fuzz 8% -trim +repage -resize $SIZE -gravity center -background black -extent $SIZE -enhance -colorspace OHTA -channel red -equalize -colorspace RGB $IN_FILE $OUT_FILE
done
