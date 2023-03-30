# Manga Resizer
Takes a `.cbz` file, and runs an ImageMagick command that resizes each image with a high quality filter (Lanczos) to the resolution of your reading device. It will create an output `.cbz` in your current directory.

## Why?
High resolution manga needs to be downscaled when viewed on devices with a lower resolution. Manga tends to create [Moiré patterns](https://en.wikipedia.org/wiki/Moir%C3%A9_pattern) when downscaled, but better downscaling algorithms/filters can prevent this. Many manga reader apps use the fastest possible scaling algorithms, which have the drawback of producing much lower quality results. Resizing the images with a high quality algorithm/filter to the exact size of your device lets you use any reader app without having to worry about artifacts created from their scaling. Just hope that the app doesn't try to resize the image despite it being the exact resolution of your screen...

TL;DR - I want to read high quality digitals on my iPad but all the iOS manga readers suck.

## Requirements
- macOS (can be modified to work with Linux, just run it and see what errors you get)
- ImageMagick (`brew install imagemagick`)

## Usage
1. Download `manga-resizer.sh`
2. Edit file to use your device's resolution
3. Run `chmod +x manga-resizer.sh`
4. Run `./manga-resizer.sh [cbz file]`

Tip: You can run it for all `.cbz` in a directory with something like:
`for f in ./*.cbz; do ./manga-resizer "$f"; done`
