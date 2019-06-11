#!/bin/bash
rm *.gif
./test.sh 1
./test.sh 10
./test.sh 20
./test.sh 30
./test.sh 40
./test.sh 50
./test.sh 60
./test.sh 70
./test.sh 80
./test.sh 90
./test.sh 100
pkill -f display

convert -delay 100 -loop 0 \
img_compress_1.gif \
img_compress_10.gif \
img_compress_20.gif \
img_compress_30.gif \
img_compress_40.gif \
img_compress_50.gif \
img_compress_60.gif \
img_compress_70.gif \
img_compress_80.gif \
img_compress_90.gif \
img_compress_100.gif \
img_compress_diff_1.gif \
img_compress_diff_10.gif \
img_compress_diff_20.gif \
img_compress_diff_30.gif \
img_compress_diff_40.gif \
img_compress_diff_50.gif \
img_compress_diff_60.gif \
img_compress_diff_70.gif \
img_compress_diff_80.gif \
img_compress_diff_90.gif \
img_compress_diff_100.gif \
jpeg_compression_levels.gif
# Display gif
display jpeg_compression_levels.gif
# Create video from gif
ffmpeg -r 1 -i ./jpeg_compression_levels.gif output.mp4
