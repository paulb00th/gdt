#!/bin/bash

# Set the fixed width
fixed_width=352

# Get the dimensions of the three input images
dimensions1=$(identify -format '%wx%h' "$1")
dimensions2=$(identify -format '%wx%h' "$2")
dimensions3=$(identify -format '%wx%h' "$3")

# Calculate the aspect ratios for each image
IFS="x" read -ra dims1 <<< "$dimensions1"
aspect_ratio1=$(echo "${dims1[0]} / ${dims1[1]}" | bc -l)
IFS="x" read -ra dims2 <<< "$dimensions2"
aspect_ratio2=$(echo "${dims2[0]} / ${dims2[1]}" | bc -l)
IFS="x" read -ra dims3 <<< "$dimensions3"
aspect_ratio3=$(echo "${dims3[0]} / ${dims3[1]}" | bc -l)

# Calculate the heights based on the fixed width and aspect ratios
height1=$(printf "%.0f" "$(echo "$fixed_width / $aspect_ratio1" | bc -l)")
height2=$(printf "%.0f" "$(echo "$fixed_width / $aspect_ratio2" | bc -l)")
height3=$(printf "%.0f" "$(echo "$fixed_width / $aspect_ratio3" | bc -l)")

# Find the lowest height among the three
min_height=$(( height1 < height2 ? height1 : height2 ))
min_height=$(( min_height < height3 ? min_height : height3 ))

# Create the thumbnails directory if it doesn't exist
mkdir -p thumbs

# Get the input filenames without paths
filename1=$(basename "$1")
filename2=$(basename "$2")
filename3=$(basename "$3")

# Resize and crop the images, saving them in the thumbs directory
convert "$1" -resize "${fixed_width}x${height1}^" -gravity center -crop "${fixed_width}x${min_height}+0+0" "thumbs/$filename1"
convert "$2" -resize "${fixed_width}x${height2}^" -gravity center -crop "${fixed_width}x${min_height}+0+0" "thumbs/$filename2"
convert "$3" -resize "${fixed_width}x${height3}^" -gravity center -crop "${fixed_width}x${min_height}+0+0" "thumbs/$filename3"
