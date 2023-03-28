# Manga Resizer
This script takes a `.cbz` file, and runs an ImageMagick command
to resize each image with a high quality filter (Lanczos) to the
resolution of your reading device. It will create an output `.cbz`
in your current directory.


Note: Need to have ImageMagick installed and in PATH. The `unzip`
and `zip` commands likely only work on macOS, but modifying for
other OS's should be straight forward.


## Usage
1. Download `manga-resizer.sh`
2. `chmod +x manga-resizer.sh`
3. run `./manga-resizer.sh [cbz file here]`


Tip: You can run it for all `.cbz` in a directory with something like:
`for f in ./*.cbz; do ./manga-resizer "$f"; done`
