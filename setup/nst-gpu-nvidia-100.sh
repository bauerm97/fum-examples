#!/bin/sh

parent=`pwd`

mkdir -p "$parent/inputs/$1"
mkdir -p "$parent/scripts/$1"

if [ ! `ls -A $parent/inputs/$1` ]; then
  echo "empty input directory found for $1.  Populating with stata center image."

  cd "$parent/inputs/$1"
  wget https://upload.wikimedia.org/wikipedia/commons/2/25/Wfm_stata_center.jpg
fi

if [ ! `ls -A $parent/scripts/$1` ]; then
  echo "empty input directory found for $1.  Populating with stata center image."

  cd "$parent/scripts/$1"
  wget https://s3-us-west-2.amazonaws.com/fumcontainers/wave.ckpt
fi

cd "$parent"

singularity run -B "scripts/$1:/script" \
                -B "inputs/$1:/input" \
                -B "$2:/output" \
                -B "/usr/lib/x86_64-linux-gnu/" \
                "containers/$1.sif"
