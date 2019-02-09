#!/bin/sh

if [ ! -f "containers/$1.def" ]; then
  echo "this is not a valid example script!"
fi

if [ ! -f "containers/$1.sif" ]; then
  echo "the image file is not built!  consider running `sudo ./fum-build.sh $1`"
  exit 1
fi

if [ ! -d "$2" ]; then
  echo "no output directory specified"
  exit 1
else
  # clean out the output directory
  rm -rf "$2/*"
fi

# run setup bootstrap which can check for file dependencies
# and/or add bindmounts.

if [ -f "setup/$1.sh" ]; then
  echo "using setup bootstrap for $1 example"
  "setup/$1.sh" $1 $2
else
  singularity run -B "scripts/$1:/script" -B "inputs/$1:/input" -B "$2:/output" "containers/$1.sif"
fi