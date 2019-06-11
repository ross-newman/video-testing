#!/bin/bash
pkill -f display
wget http://www.defenceimagery.mod.uk/fotoweb/archives/5042-Downloadable%20Stock%20Images/Archive/Army/45158/45158850.jpg
identify 45158850.jpg 
echo "Resize"
convert 45158850.jpg -resize x480 -quality 100 img_resize.png
identify img_resize.png
ls -hal img_resize.png 
echo "Convert RBG"
convert img_resize.png -colorspace RGB img_raw.rgb
#convert -colorspace RGB -size 1170x480 -depth 8 img_raw.rgb img_rgb.png
echo "Convert YUV"
convert img_resize.png -colorspace YCbCr img_raw.yuv
#convert -colorspace YCbCr -size 1170x480 -depth 8 img_raw.yuv img_yuv.png
echo "Differerance Mask"
compare -compose src -size 1170x480+0 -colorspace RGB -depth 8 img_raw.rgb -size 1170x480+0 -colorspace YUV -depth 8 img_raw.yuv img_mask.png
echo "Mask"
convert img_mask.png -background none -transparent "#CCCCCC" -flatten img_difference.png
echo "Compose"
composite -compose src img_resize.png img_difference.png img_mask.png img_result_raw.png
convert img_resize.png -size 1170x480+0 -colorspace RGB -depth 8 img_raw.rgb 
convert img_resize.png -size 1170x480+0 -colorspace YCbCr -depth 8 ing_raw.yuv
echo "Captioning"
convert img_resize.png -background lightblue -fill yellow  -size 200x90 -pointsize 48 -gravity center -annotate +0+200 "ORIGINAL FILE" img_colour_1.gif
convert -size 1170x480+0 -colorspace RGB -depth 8 img_raw.rgb -background lightblue -fill yellow -size 200x90+0 -pointsize 48 -gravity center -annotate +0+200+0 "RGB COLOURSPACE" img_colour_2.gif
convert -size 1170x480+0 -colorspace YCbCr -depth 8 img_raw.yuv -background lightblue -fill yellow -size 200x90+0 -pointsize 48 -gravity center -annotate +0+200+0 "YCbCr COLOURSPACE" img_colour_3.gif
echo "Gif"
convert -delay 100 -loop 0 \
img_colour_1.gif \
img_colour_2.gif \
img_colour_3.gif \
jpeg_colour_levels.gif
ffmpeg -r 0.2 -i ./jpeg_colour_levels.gif jpeg_colour_levels.mp4
echo "Display"
display -size 1170x480+0 -colorspace RGB -depth 8 ./img_raw.rgb &
display -size 1170x480+0 -colorspace YCbCr -depth 8 ./img_raw.yuv &
display img_resize.png &
display img_difference.png &
display img_result_raw.png &
sleep 5
pkill -f display


