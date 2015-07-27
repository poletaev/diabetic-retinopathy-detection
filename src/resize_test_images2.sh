#!/bin/bash -e
#
# This script utilizes convert utility from ImageMagic tools
# http://www.imagemagick.org/script/command-line-tools.php
#

if [ -z $1 ]; then
    echo "Please set input directory"
    exit -1
fi

SIZE=256x256
OUT_DIR="$1_out"

mkdir -p $OUT_DIR
echo "output directory is $OUT_DIR"

parallel -j+0 convert -fuzz 5% -trim +repage -resize $SIZE -gravity center -background black -extent $SIZE -enhance $1/{} $OUT_DIR/{} ::: `ls $1`
