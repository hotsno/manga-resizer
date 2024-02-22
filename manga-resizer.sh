#!/bin/bash

# This script takes a .cbz file, and runs an ImageMagick command
# to resize each image with a high quality filter (Lanczos) to the
# resolution of your reading device. It will create an output .cbz
# in your current directory.

# Note: Need to have ImageMagick installed and in PATH. The `unzip`
# and `zip` commands likely only work on macOS, but modifying for
# other OS's should be straight forward.

# Change this to your device's resolution
resolution="1640x2360"

if [[ ! -f $1 ]] || [[ $1 != *.cbz ]]; then
	echo "Not a valid .cbz"
	exit 1
fi

cbzFile="$1"
cbzBase="$(basename "$1" .cbz)"

# Unzip the original
echo "Unzipping '${cbzFile}'"
extractedDir="/tmp/${cbzBase}"
unzip -d "$extractedDir" "$cbzFile" >/dev/null

# Resize all original images
resizedDir="$extractedDir - Resized"
mkdir "$resizedDir"
images="$(find "$extractedDir" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \))"
total=$(echo "$images" | wc -l | xargs)
count=1
echo "$images" | while read -r image; do
	echo -ne "Resizing image ${count}/${total}\r"
	magick "$image" -resize "$resolution" "$resizedDir/$(basename "$image")"
	((count = count + 1))
done
echo

# Delete the unzipped original
rm -rf "$extractedDir"

# Create new .cbz
newCbz="./${cbzBase} - Resized.cbz"
zip -rj -0 "$newCbz" "$resizedDir" >/dev/null
echo -e "Created new .cbz at '${newCbz}'!\n"

# Delete resized images
rm -rf "$resizedDir"
