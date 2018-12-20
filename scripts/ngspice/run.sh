#!/bin/sh

cd "$input_dir/"

ngspice -b "run.cir"

python3.6 analysis.py "$output_dir"
