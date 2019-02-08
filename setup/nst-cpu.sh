#!/bin/sh

parent=`pwd`

if [ ! `ls -A $parent/inputs/nst-cpu` ]; then
  echo "empty input directory found for nst-cpu.  Populating with stata center image."
  
  cd "$parent/inputs/nst-cpu"
  wget https://upload.wikimedia.org/wikipedia/commons/2/25/Wfm_stata_center.jpg
fi

if [ ! `ls -A $parent/scripts/nst-cpu` ]; then

  echo "empty input directory found for nst-cpu.  Populating with stata center image."

  cd "$parent/scripts/nst-cpu"
  wget https://s3-us-west-2.amazonaws.com/fumcontainers/wave.ckpt
fi

cd "$parent"

singularity run -B "scripts/$1:/script" -B "inputs/$1:/input" -B "$2:/output" "containers/$1.sif"
