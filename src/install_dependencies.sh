#!/bin/bash -e
#
# This script utilizes convert utility from ImageMagic tools
# http://www.imagemagick.org/script/command-line-tools.php
#

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main"
sudo apt-get update
sudo apt-get install imagemagick
sudo apt-get install parallel
