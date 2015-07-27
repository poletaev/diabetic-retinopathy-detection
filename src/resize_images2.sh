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
OUT_DIR="$1_$SIZE"
mkdir -p $OUT_DIR
echo "output directory is $OUT_DIR"

# func_resize <input file> <output directory> <number or rateted copies>
func()
{
    if [ -z "$3" ] # Is parameter #3 zero length?
    then
	NUM=30
    else
	NUM=$3
    fi
    echo $1 $2 $NUM

    SIZE=256x256
    TMP_DIR="../data/tmp"
    mkdir -p $TMP_DIR

    TMP_FILE1="$TMP_DIR/$RANDOM$RANDOM.jpeg"
    convert +repage -resize $SIZE -gravity center -background black -extent $SIZE -enhance $1 $TMP_FILE1
    TMP_FILE2="$TMP_DIR/$RANDOM$RANDOM.jpeg"
    convert -flip $TMP_FILE1 $TMP_FILE2
    mv $TMP_FILE2 $2/$(shasum -a 256 $TMP_FILE2 | awk '{ print $1 }').jpeg
    TMP_FILE3="$TMP_DIR/$RANDOM$RANDOM.jpeg"
    convert -flop $TMP_FILE1 $TMP_FILE3
    mv $TMP_FILE3 $2/$(shasum -a 256 $TMP_FILE3 | awk '{ print $1 }').jpeg
    TMP_FILE4="$TMP_DIR/$RANDOM$RANDOM.jpeg"
    convert -colorspace OHTA -channel red -equalize -colorspace RGB $TMP_FILE1 $TMP_FILE4
    mv $TMP_FILE4 $2/$(shasum -a 256 $TMP_FILE4 | awk '{ print $1 }').jpeg
    for i in `seq 1 $NUM`;
    do
    	TMP_FILE5="$TMP_DIR/$RANDOM$RANDOM.jpeg"
    	convert -rotate $(( ( RANDOM % 330 ) + 5 )) -fuzz 5% -trim +repage -resize $SIZE -gravity center -background black -extent $SIZE $TMP_FILE1 $TMP_FILE5
    	mv $TMP_FILE5 $2/$(shasum -a 256 $TMP_FILE5 | awk '{ print $1 }').jpeg
    done
    mv $TMP_FILE1 $2/$(shasum -a 256 $TMP_FILE1 | awk '{ print $1 }').jpeg
}

export -f func
parallel -j+0 func $1/{} $OUT_DIR $2 ::: `ls $1`
