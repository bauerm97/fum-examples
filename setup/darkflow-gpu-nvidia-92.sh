#!/bin/sh

parent=`pwd`

scriptsdir="$parent/scripts/$1"

if [ ! -d "$scriptsdir" ]; then
  cd "$parent/scripts"
  git clone https://github.com/rstorlabs/darkflow
  mv darkflow "$1"
  cd "$parent"
fi

weightsdir="$parent/scripts/darkflow-cpu/bin"

mkdir -p "$weightsdir"

if [ ! -f "$weightsdir/yolov2.weights" ]; then
  echo "yolov2 weights not found, downloading."

  cd "$weightsdir"
  wget https://pjreddie.com/media/files/yolov2.weights
  cd "$parent"
fi

singularity run -B "scripts/$1:/script" \
                -B "inputs/$1:/input" \
                -B "$2:/output" \
                -B "/usr/local/cuda-9.2/" \
                -B "/usr/lib/x86_64-linux-gnu/" \
                "containers/$1.sif"
