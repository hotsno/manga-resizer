#!/bin/bash

unzip_d() {
    zipfile="$1"
    zipdir=${1%.cbz}
    echo "Unzipping..."
    unzip -d "$zipdir" "$zipfile" > /dev/null
}

if [[ ! -f $1 ]] || [[ $1 != *.cbz ]]; then
    echo "Give a valid .cbz"
    exit 1
fi

# Unzip the original
cbzDir="$(dirname $1)"
cbzBase="$(basename "$1" .cbz)"

echo "Unzipping ${1}..."
extractedDir="./${cbzBase}"
unzip -d "$extractedDir" "$1" > /dev/null

# Resize all original images
mkdir ./resized
echo "Doing magick..."
for f in "$extractedDir"/*; do
    # echo "Resizing $file..."
    magick "$f" -resize 1640x2360 "./resized/$(basename "$f")"
done

# Delete the unzipped original
rm -rf "$extractedDir"

# Create new .cbz
echo "Creating new .cbz..."
newCbz="./${cbzBase} RESIZED.cbz"
zip -r -0 "$newCbz" ./resized > /dev/null
echo -e "Created new .cbz at ${newCbz}!\n"

# Delete resized images
rm -rf ./resized