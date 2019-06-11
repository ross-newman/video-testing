#!/bin/bash
export QUALITY=$1
pkill -f display
wget http://www.defenceimagery.mod.uk/fotoweb/archives/5042-Downloadable%20Stock%20Images/Archive/Army/45158/45158850.jpg
echo "Resize"
identify 45158850.jpg 
convert 45158850.jpg -resize x480 -quality 100 img_resize.png
ls -hal img_resize.png 
echo "Compress"
convert img_resize.png -quality ${QUALITY} img_compress.jpg
convert img_compress.jpg img_compress.png
ls -hal img_resize.png img_compress.jpg
echo "Differerance Mask"
identify img_compress.png
compare -compose src img_resize.png img_compress.png img_difference.png
echo "Mask"
convert img_difference.png -background none -transparent "#CCCCCC" -flatten img_mask.png
echo "Compose"
composite -compose src img_compress.png img_difference.png img_mask.png img_result_quality_${QUALITY}.png
FILE_SIZE=$(du -bh img_result_quality_${QUALITY}.png)
set -- $FILE_SIZE
SIZE=$1
convert img_result_quality_${QUALITY}.png -background lightblue -fill yellow  -size 200x90 -pointsize 48 -gravity center -annotate +0+200 "QUALITY $QUALITY ($SIZE)" img_compress_diff_${QUALITY}.gif
convert img_compress.png -background lightblue -fill yellow  -size 200x90 -pointsize 48 -gravity center -annotate +0+200 "QUALITY $QUALITY (${SIZE})" img_compress_${QUALITY}.gif
echo "Display"
display img_resize.png &
display img_compress.png &
display img_difference.png &
display img_result_quality_${QUALITY}.png &
pkill -f display

