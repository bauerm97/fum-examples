#!/bin/sh

if [ ! -f "containers/$1.def" ]; then
  echo "this is not a valid example script!"
fi

if [ ! -f "containers/$1.img" ]; then
  echo "the image file is not built!  consider running `sudo ./fum-build.sh $1`"
  exit 1
fi

if [ ! -d "$2" ]; then
  echo "no output directory specified"
  exit 1
fi

rm -f "$2/*"

singularity run -B "scripts/$1:/script" -B "inputs/$1:/input" -B "$2:/output" "containers/$1.img"
